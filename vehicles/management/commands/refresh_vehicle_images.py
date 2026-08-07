"""
refresh_vehicle_images
======================
python manage.py refresh_vehicle_images [options]

Sources par ordre de priorite (automatique selon categorie) :
  Voitures    : IMAGIN.studio (si IMAGIN_API_KEY) > Wikimedia Commons > Openverse > Wikipedia
  Motos       : Wikimedia Commons > Openverse > Wikipedia
  Velos       : Wikimedia Commons > Openverse
  Trottinettes: Openverse > Wikimedia Commons
  Scooters    : Wikimedia Commons > Openverse

Pexels : supprime definitivement.

Cache    : media/vehicles/.search_cache.json   (valide 7 jours)
Tracking : media/vehicles/.image_sources.json  (source + score de chaque image)
Rapport  : media/vehicles/rapport_qualite.html (avec --report)
"""

import json
import os
import re
import time
from dataclasses import dataclass
from datetime import datetime
from pathlib import Path
from typing import Optional

import requests
from django.conf import settings
from django.core.management.base import BaseCommand

from vehicles.models import Vehicle, VehicleImage


# ── APIs ───────────────────────────────────────────────────────────────────────

COMMONS_API   = "https://commons.wikimedia.org/w/api.php"
OPENVERSE_API = "https://api.openverse.org/v1/images/"
WIKIPEDIA_API = "https://en.wikipedia.org/w/api.php"
IMAGIN_API    = "https://cdn.imagin.studio/getimage"

HEADERS = {"User-Agent": "MultiDriveTFE/2.0 (tfe-student@school.be)"}

# Groupes de categories pour la selection automatique de source
CAR_SLUGS  = {"citadine", "compacte", "suv-compact", "break", "utilitaire-leger", "monospace"}
MOTO_SLUGS = {"moto-legere", "scooter"}
VELO_SLUGS = {"velo"}
TROT_SLUGS = {"trottinette"}

# Mots qui indiquent une image inutilisable
REJECT_WORDS = frozenset({
    "logo", "badge", "emblem", "icon", "flag", "map", "chart", "diagram",
    "drawing", "illustration", "sketch", "render", "rendering", "3d",
    "blueprint", "schematic", "interior", "engine", "dashboard", "cabin",
    "cockpit", "brochure", "advertisement", "advert", "prototype", "concept",
    "recall", "manual", "parts", "repair", "catalog", "catalogue",
})

# Palette couleurs (FR + EN + DE + NL)
COLOR_KEYWORDS = {
    "blanc":  ["white", "blanc", "blanche", "weiss", "wit", "polar", "pearl"],
    "noir":   ["black", "noir", "noire", "schwarz", "zwart", "obsidian"],
    "gris":   ["grey", "gray", "gris", "silver", "argent", "silber", "grijs", "anthracite"],
    "rouge":  ["red", "rouge", "rot", "rood", "crimson", "scarlet", "burgundy"],
    "bleu":   ["blue", "bleu", "bleue", "blau", "blauw", "navy", "cobalt", "sapphire"],
    "vert":   ["green", "vert", "verte", "gruen", "groen", "olive", "emerald"],
    "jaune":  ["yellow", "jaune", "gelb", "geel", "gold", "golden"],
    "orange": ["orange"],
    "marron": ["brown", "marron", "beige", "braun", "bruin", "bronze", "copper"],
    "violet": ["purple", "violet", "mauve", "lila"],
}

# Suffixes de recherche par categorie
SEARCH_SUFFIX = {
    "citadine":         "hatchback exterior parked",
    "compacte":         "hatchback exterior parked",
    "suv-compact":      "SUV exterior parked",
    "break":            "estate wagon exterior parked",
    "utilitaire-leger": "van exterior parked",
    "monospace":        "minivan exterior parked",
    "velo":             "bicycle side view",
    "moto-legere":      "motorcycle parked side view",
    "scooter":          "scooter parked side view",
    "trottinette":      "electric scooter product",
}

# Seuil minimum de confiance pour accepter une image
MIN_CONF = 0.55
# Gain minimum pour remplacer une image existante (quality-pass)
REPLACE_GAIN = 0.08


# ── Dataclass ──────────────────────────────────────────────────────────────────

@dataclass
class Candidate:
    url:        str
    thumb_url:  str
    title:      str
    source:     str
    color:      Optional[str] = None
    confidence: float = 0.5
    width:      int = 0
    height:     int = 0

    def to_dict(self):
        return {k: getattr(self, k) for k in
                ("url", "thumb_url", "title", "source", "color", "confidence", "width", "height")}

    @staticmethod
    def from_dict(d):
        return Candidate(**d)


# ── Cache ──────────────────────────────────────────────────────────────────────

class SearchCache:
    CACHE_DAYS = 7

    def __init__(self, path: Path):
        self.path = path
        try:
            self._data: dict = json.loads(path.read_text("utf-8")) if path.exists() else {}
        except Exception:
            self._data = {}

    def get(self, key: str) -> Optional[list]:
        entry = self._data.get(key)
        if not entry:
            return None
        try:
            age = (datetime.now() - datetime.fromisoformat(entry["at"])).days
            if age > self.CACHE_DAYS:
                return None
        except Exception:
            return None
        return [Candidate.from_dict(d) for d in entry.get("items", [])]

    def set(self, key: str, candidates: list):
        self._data[key] = {
            "at": datetime.now().isoformat(),
            "items": [c.to_dict() for c in candidates],
        }
        self._save()

    def usage(self) -> dict:
        return self._data.get("_usage_", {})

    def mark_used(self, url: str):
        u = self._data.setdefault("_usage_", {})
        u[url] = u.get(url, 0) + 1
        self._save()

    def _save(self):
        self.path.write_text(json.dumps(self._data, ensure_ascii=False, indent=2), "utf-8")


# ── Tracking source ────────────────────────────────────────────────────────────

class SourceTracker:
    """Enregistre la source, l'URL et le score de chaque image telechargee."""

    def __init__(self, path: Path):
        self.path = path
        try:
            self._data: dict = json.loads(path.read_text("utf-8")) if path.exists() else {}
        except Exception:
            self._data = {}

    def get(self, vehicle_id: int, slot: str) -> dict:
        return self._data.get(str(vehicle_id), {}).get(slot, {})

    def set(self, vehicle_id: int, slot: str, source: str, url: str, confidence: float):
        self._data.setdefault(str(vehicle_id), {})[slot] = {
            "source": source, "url": url,
            "confidence": round(confidence, 3),
            "at": datetime.now().isoformat(),
        }
        self._save()

    def clear(self, vehicle_id: int):
        self._data.pop(str(vehicle_id), None)
        self._save()

    def _save(self):
        self.path.write_text(json.dumps(self._data, ensure_ascii=False, indent=2), "utf-8")


# ── Utilitaires ────────────────────────────────────────────────────────────────

def parse_title(title: str) -> dict:
    """Extrait brand, model, year depuis 'Renault Clio 2012 #001'."""
    tokens = [t for t in title.split() if not t.startswith("#")]
    year = None
    if tokens and re.fullmatch(r"\d{4}", tokens[-1]):
        year = int(tokens.pop())
    brand = tokens[0] if tokens else ""
    model = " ".join(tokens[1:]) if len(tokens) > 1 else ""
    return {"brand": brand, "model": model, "year": year}


def extract_color(text: str) -> Optional[str]:
    low = text.lower()
    for color, kws in COLOR_KEYWORDS.items():
        if any(kw in low for kw in kws):
            return color
    return None


def is_rejected(title: str) -> bool:
    return any(w in title.lower() for w in REJECT_WORDS)


def extract_years(text: str) -> list:
    return [int(y) for y in re.findall(r'\b(19[5-9]\d|20[0-3]\d)\b', text)]


def compute_confidence(title: str, brand: str, model: str, source: str,
                       width: int, target_year: int = 0) -> float:
    if is_rejected(title):
        return -1.0
    base = {
        "imagin":    0.92,
        "wikimedia": 0.72,
        "wikipedia": 0.68,
        "openverse": 0.62,
    }.get(source, 0.5)
    low = title.lower()
    if brand.lower() in low:
        base += 0.10
    if model.lower() in low:
        base += 0.10
    if any(w in low for w in ["exterior", "exterieur", "parked", "side", "front", "rear"]):
        base += 0.05
    if width >= 1200:
        base += 0.03
    elif 0 < width < 400:
        base -= 0.15
    if target_year:
        years = extract_years(title)
        if years:
            diff = min(abs(y - target_year) for y in years)
            if diff <= 3:
                base += 0.12
            elif diff <= 6:
                base += 0.02
            elif diff > 8:
                base -= 0.20
    return round(min(base, 1.0), 3)


def get_source_order(cat_slug: str, imagin_key: str) -> list:
    """Retourne l'ordre des sources a essayer selon la categorie."""
    if cat_slug in CAR_SLUGS:
        order = []
        if imagin_key:
            order.append("imagin")
        return order + ["wikimedia", "openverse", "wikipedia"]
    if cat_slug in MOTO_SLUGS:
        return ["wikimedia", "openverse", "wikipedia"]
    if cat_slug in VELO_SLUGS:
        return ["wikimedia", "openverse"]
    if cat_slug in TROT_SLUGS:
        return ["openverse", "wikimedia"]
    return ["wikimedia", "openverse"]


def pick_pair(candidates: list, usage: dict, target_year: int = 0) -> tuple:
    """
    Selectionne 2 candidats optimaux :
    - Filtre par seuil minimal de confiance
    - Trie par proximite d'annee, usage, confiance
    - Coherence couleur + generation pour img2
    - Refuse une img2 de mauvaise qualite (prefere 1 seule bonne image)
    """
    valids = [c for c in candidates if c.confidence >= MIN_CONF]
    if not valids:
        return None, None

    def sort_key(c):
        year_diff = 999
        if target_year:
            years = extract_years(c.title)
            if years:
                year_diff = min(abs(y - target_year) for y in years)
        return (year_diff, usage.get(c.url, 0), -c.confidence)

    ranked = sorted(valids, key=sort_key)
    img1   = ranked[0]
    others = [c for c in ranked if c.url != img1.url]
    img1_years = extract_years(img1.title) if target_year else []

    img2 = None

    # Priorite 1 : meme couleur + meme generation
    if img1.color and img1_years:
        same = [c for c in others
                if c.color == img1.color
                and any(abs(y - target_year) <= 5 for y in extract_years(c.title))]
        img2 = same[0] if same else None

    # Priorite 2 : meme couleur
    if img2 is None and img1.color:
        same = [c for c in others if c.color == img1.color]
        img2 = same[0] if same else None

    # Priorite 3 : n'importe quel autre candidat valide
    if img2 is None and others:
        img2 = others[0]

    # Ne pas accepter une 2eme image sous le seuil
    if img2 and img2.confidence < MIN_CONF:
        img2 = None

    return img1, img2


def http_get(url, params=None, extra_headers=None, timeout=12):
    hdrs = {**HEADERS, **(extra_headers or {})}
    for attempt in range(3):
        try:
            r = requests.get(url, params=params, headers=hdrs, timeout=timeout)
            if r.status_code == 429:
                time.sleep(4 * (attempt + 1))
                continue
            return r
        except requests.exceptions.RequestException:
            time.sleep(1)
    return None


def download_image(url: str, dest: Path, extra_headers: dict = None) -> bool:
    hdrs = {**HEADERS, **(extra_headers or {})}
    for attempt in range(3):
        try:
            r = requests.get(url, headers=hdrs, timeout=30, stream=True)
            if r.status_code == 429:
                time.sleep(4 * (attempt + 1))
                continue
            r.raise_for_status()
            with open(dest, "wb") as f:
                for chunk in r.iter_content(8192):
                    f.write(chunk)
            return True
        except Exception:
            time.sleep(1)
    return False


# ── Sources d'images ───────────────────────────────────────────────────────────

def search_wikimedia(brand: str, model: str, cat_slug: str,
                     year: int = 0, max_results: int = 10) -> list:
    query = f"{brand} {model} {year}" if year else f"{brand} {model}"
    r = http_get(COMMONS_API, params={
        "action": "query", "list": "search",
        "srsearch": query, "srnamespace": 6,
        "srlimit": max_results, "srprop": "title", "format": "json",
    })
    if not r or not r.ok:
        return []
    titles = [s["title"] for s in r.json().get("query", {}).get("search", [])]
    if not titles:
        return []
    time.sleep(0.8)
    r2 = http_get(COMMONS_API, params={
        "action": "query", "titles": "|".join(titles[:10]),
        "prop": "imageinfo", "iiprop": "url|size",
        "iiurlwidth": 1200, "format": "json",
    })
    if not r2 or not r2.ok:
        return []
    candidates = []
    for page in r2.json().get("query", {}).get("pages", {}).values():
        infos = page.get("imageinfo", [])
        if not infos:
            continue
        info  = infos[0]
        url   = info.get("thumburl") or info.get("url", "")
        w     = info.get("width", 0)
        h     = info.get("height", 0)
        title = page.get("title", "")
        if not re.search(r"\.(jpg|jpeg|png|webp)(\?|$)", url.lower()):
            continue
        if w and w < 300:
            continue
        conf = compute_confidence(title, brand, model, "wikimedia", w, target_year=year)
        if conf < 0:
            continue
        candidates.append(Candidate(
            url=url, thumb_url=url, title=title, source="wikimedia",
            color=extract_color(title), confidence=conf, width=w, height=h,
        ))
    return candidates


def search_openverse(brand: str, model: str, cat_slug: str,
                     year: int = 0, max_results: int = 10) -> list:
    suffix = SEARCH_SUFFIX.get(cat_slug, "exterior")
    query  = f"{brand} {model} {suffix}"
    r = http_get(OPENVERSE_API, params={
        "q": query, "license_type": "all-cc", "page_size": max_results,
    })
    if not r or not r.ok:
        return []
    candidates = []
    for res in r.json().get("results", []):
        url   = res.get("url", "")
        thumb = res.get("thumbnail", url)
        title = res.get("title", "")
        w     = res.get("width") or 0
        h     = res.get("height") or 0
        if not re.search(r"\.(jpg|jpeg|png|webp)(\?|$)", url.lower()):
            continue
        if w and w < 300:
            continue
        if model and model.lower() not in title.lower():
            continue
        conf = compute_confidence(title, brand, model, "openverse", w, target_year=year)
        if conf < 0:
            continue
        candidates.append(Candidate(
            url=url, thumb_url=thumb, title=title, source="openverse",
            color=extract_color(title), confidence=conf, width=w, height=h,
        ))
    return candidates


def search_wikipedia(brand: str, model: str, year: int = 0) -> list:
    """Thumbnail de l'article Wikipedia correspondant au modele."""
    r = http_get(WIKIPEDIA_API, params={
        "action": "query", "list": "search",
        "srsearch": f"{brand} {model}", "format": "json", "srlimit": 3,
    })
    if not r or not r.ok:
        return []
    results = r.json().get("query", {}).get("search", [])
    if not results:
        return []
    time.sleep(0.5)
    page_ids = "|".join(str(res["pageid"]) for res in results[:3])
    r2 = http_get(WIKIPEDIA_API, params={
        "action": "query", "pageids": page_ids,
        "prop": "pageimages", "pithumbsize": 1200, "format": "json",
    })
    if not r2 or not r2.ok:
        return []
    candidates = []
    for page in r2.json().get("query", {}).get("pages", {}).values():
        thumb = page.get("thumbnail", {}).get("source", "")
        title = page.get("title", "")
        if not thumb:
            continue
        if not re.search(r"\.(jpg|jpeg|png|webp)(\?|$)", thumb.lower()):
            continue
        conf = compute_confidence(title, brand, model, "wikipedia", 1200, target_year=year)
        if conf < 0:
            continue
        candidates.append(Candidate(
            url=thumb, thumb_url=thumb, title=title, source="wikipedia",
            color=extract_color(title), confidence=conf, width=1200, height=0,
        ))
    return candidates


def search_imagin(brand: str, model: str, imagin_key: str) -> list:
    """IMAGIN.studio : renders studio, 2 angles complementaires."""
    make  = brand.lower().replace(" ", "-")
    mdl   = model.lower().replace(" ", "-")
    angles = [("side", "side view"), ("frontView", "front view")]
    candidates = []
    for angle, label in angles:
        url = (f"{IMAGIN_API}?customer={imagin_key}"
               f"&make={make}&modelFamily={mdl}&angle={angle}&zoomType=fullscreen")
        r = http_get(url, timeout=10)
        if r and r.ok and "image" in r.headers.get("content-type", ""):
            candidates.append(Candidate(
                url=r.url, thumb_url=r.url,
                title=f"{brand} {model} {label}",
                source="imagin", confidence=0.92,
                width=1280, height=720,
            ))
    return candidates


# ── Recherche complete selon l'ordre de priorite ───────────────────────────────

def fetch_candidates(brand: str, model: str, cat_slug: str,
                     target_year: int, source_order: list,
                     imagin_key: str, stdout_fn) -> list:
    """Appelle les sources dans l'ordre jusqu'a avoir assez de candidats."""
    candidates = []
    for src in source_order:
        if src == "wikimedia":
            found = search_wikimedia(brand, model, cat_slug, year=target_year)
            candidates.extend(found)
            stdout_fn(f"    wikimedia  : {len(found)}")
            time.sleep(1.0)
        elif src == "openverse":
            if len(candidates) < 4:
                found = search_openverse(brand, model, cat_slug, year=target_year)
                candidates.extend(found)
                stdout_fn(f"    openverse  : {len(found)}")
                time.sleep(0.5)
        elif src == "wikipedia":
            if len(candidates) < 2:
                found = search_wikipedia(brand, model, year=target_year)
                candidates.extend(found)
                stdout_fn(f"    wikipedia  : {len(found)}")
                time.sleep(0.5)
        elif src == "imagin" and imagin_key:
            found = search_imagin(brand, model, imagin_key)
            candidates.extend(found)
            stdout_fn(f"    imagin     : {len(found)}")
    return candidates


# ── Rapport HTML qualite ───────────────────────────────────────────────────────

def generate_html_report(records: list, output: Path, media_url: str):
    n_unchanged  = sum(1 for r in records if r.get("action") == "unchanged")
    n_improved   = sum(1 for r in records if r.get("action") == "improved")
    n_new        = sum(1 for r in records if r.get("action") == "new")
    n_one        = sum(1 for r in records if r.get("action") == "one_image")
    n_manual     = sum(1 for r in records if r.get("action") == "manual")
    n_pexels     = sum(1 for r in records if r.get("pexels_replaced"))

    def img_cell(path_or_url, source, conf, label):
        if not path_or_url:
            return '<td class="no-img">—</td>'
        if str(path_or_url).startswith("http"):
            src = str(path_or_url)
        else:
            rel = str(path_or_url).replace(str(settings.MEDIA_ROOT), "").replace("\\", "/")
            src = f"{media_url.rstrip('/')}{rel}"
        conf_s = f"<small class='conf'>{conf:.2f}</small>" if conf else ""
        src_s  = f"<small class='src'>{source}</small>" if source else ""
        lbl_s  = f"<small class='lbl'>{label}</small>" if label else ""
        return (f'<td><img src="{src}" alt="" loading="lazy" '
                f'onerror="this.parentNode.innerHTML=\'<span class=no-img>err</span>\'">'
                f'<br>{src_s}{conf_s}{lbl_s}</td>')

    rows = []
    for rec in records:
        action = rec.get("action", "")
        badge = {
            "unchanged": '<span class="b-ok">Inchange</span>',
            "improved":  '<span class="b-imp">Ameliore</span>',
            "new":       '<span class="b-new">Nouveau</span>',
            "one_image": '<span class="b-warn">1 image</span>',
            "manual":    '<span class="b-err">Manuel</span>',
        }.get(action, "?")
        pex = '<span class="b-pex">Pexels</span> ' if rec.get("pexels_replaced") else ""
        rows.append(f"""
<tr>
  <td class="vid">{rec['id']}</td>
  <td><strong>{rec['title']}</strong><small class="cat">{rec['category']}</small></td>
  {img_cell(rec.get('before_img1'), rec.get('before_src1'), rec.get('before_conf1'), 'avant')}
  {img_cell(rec.get('before_img2'), rec.get('before_src2'), rec.get('before_conf2'), 'avant')}
  {img_cell(rec.get('img1_path'),   rec.get('src1'),        rec.get('conf1'),        'apres')}
  {img_cell(rec.get('img2_path'),   rec.get('src2'),        rec.get('conf2'),        'apres')}
  <td class="act">{pex}{badge}</td>
</tr>""")

    now = datetime.now().strftime("%d/%m/%Y a %H:%M")
    html = f"""<!DOCTYPE html>
<html lang="fr">
<head>
<meta charset="utf-8">
<title>Rapport qualite — MultiDrive</title>
<style>
*{{box-sizing:border-box;margin:0;padding:0}}
body{{font-family:system-ui,sans-serif;font-size:12px;background:#f0f2f5;padding:20px;color:#333}}
h1{{font-size:18px;color:#1a202c;margin-bottom:4px}}
.meta{{color:#888;font-size:11px;margin-bottom:18px}}
.stats{{display:flex;gap:10px;margin-bottom:20px;flex-wrap:wrap}}
.stat{{background:#fff;padding:10px 16px;border-radius:8px;box-shadow:0 1px 3px rgba(0,0,0,.1);min-width:90px}}
.stat strong{{font-size:22px;display:block;font-weight:700}}
.stat small{{color:#888;font-size:10px}}
.wrap{{overflow-x:auto}}
table{{border-collapse:collapse;min-width:1100px;width:100%;background:#fff;border-radius:8px;overflow:hidden;box-shadow:0 1px 3px rgba(0,0,0,.1)}}
th{{background:#1a202c;color:#fff;padding:8px 10px;text-align:left;font-size:10px;text-transform:uppercase;letter-spacing:.05em}}
td{{padding:6px 10px;border-bottom:1px solid #f0f2f5;vertical-align:middle}}
td small{{display:block;font-size:10px}}
tr:hover td{{background:#fafafa}}
td img{{width:110px;height:70px;object-fit:cover;border-radius:4px;display:block}}
.no-img{{display:inline-flex;align-items:center;justify-content:center;width:110px;height:70px;background:#f0f2f5;border-radius:4px;color:#aaa;font-size:10px}}
.src{{color:#6366f1}}.conf{{color:#888}}.lbl{{color:#bbb}}.cat{{color:#999}}
.vid{{color:#bbb;font-size:10px;white-space:nowrap}}
.act{{white-space:nowrap}}
.b-ok  {{background:#dcfce7;color:#166534;padding:2px 8px;border-radius:12px;font-size:10px;font-weight:600}}
.b-imp {{background:#dbeafe;color:#1e40af;padding:2px 8px;border-radius:12px;font-size:10px;font-weight:600}}
.b-new {{background:#f0fdf4;color:#15803d;padding:2px 8px;border-radius:12px;font-size:10px;font-weight:600}}
.b-warn{{background:#fef9c3;color:#854d0e;padding:2px 8px;border-radius:12px;font-size:10px;font-weight:600}}
.b-err {{background:#fee2e2;color:#991b1b;padding:2px 8px;border-radius:12px;font-size:10px;font-weight:600}}
.b-pex {{background:#fee2e2;color:#991b1b;padding:2px 6px;border-radius:10px;font-size:9px;font-weight:700;margin-right:4px}}
</style>
</head>
<body>
<h1>Rapport qualite images — MultiDrive</h1>
<p class="meta">Genere le {now} — {len(records)} vehicules traites</p>
<div class="stats">
  <div class="stat"><strong style="color:#166534">{n_unchanged}</strong><small>Inchanges</small></div>
  <div class="stat"><strong style="color:#1e40af">{n_improved}</strong><small>Ameliores</small></div>
  <div class="stat"><strong style="color:#15803d">{n_new}</strong><small>Nouveaux</small></div>
  <div class="stat"><strong style="color:#854d0e">{n_one}</strong><small>1 seule image</small></div>
  <div class="stat"><strong style="color:#991b1b">{n_manual}</strong><small>Manuel requis</small></div>
  <div class="stat"><strong style="color:#991b1b">{n_pexels}</strong><small>Pexels remplaces</small></div>
  <div class="stat"><strong>{len(records)}</strong><small>Total</small></div>
</div>
<div class="wrap">
<table>
<thead>
  <tr>
    <th>#</th><th>Vehicule</th>
    <th>Avant — img1</th><th>Avant — img2</th>
    <th>Apres — img1</th><th>Apres — img2</th>
    <th>Statut</th>
  </tr>
</thead>
<tbody>{''.join(rows)}</tbody>
</table>
</div>
</body>
</html>"""
    output.write_text(html, encoding="utf-8")


# ── Commande ───────────────────────────────────────────────────────────────────

class Command(BaseCommand):
    help = "Optimise les images vehicules (Wikimedia > Openverse > Wikipedia, sans Pexels)."

    def add_arguments(self, parser):
        parser.add_argument("--force",        action="store_true",
                            help="Supprime et retelecharge toutes les images.")
        parser.add_argument("--only-missing", action="store_true",
                            help="Traite uniquement les vehicules sans photo principale.")
        parser.add_argument("--dry-run",      action="store_true",
                            help="Simule sans telecharger ni modifier la DB.")
        parser.add_argument("--quality-pass", action="store_true",
                            help="Passe qualite : remplace Pexels et images a faible score.")
        parser.add_argument("--limit",       type=int, default=0,  metavar="N")
        parser.add_argument("--vehicle-id",  type=int, default=0,  metavar="ID")
        parser.add_argument("--category",    type=str, default="", metavar="SLUG")
        parser.add_argument("--report",      action="store_true",
                            help="Genere un rapport HTML avant/apres.")

    def handle(self, *args, **options):
        imagin_key = os.environ.get("IMAGIN_API_KEY", "")
        media_dir  = Path(settings.MEDIA_ROOT) / "vehicles"
        media_dir.mkdir(parents=True, exist_ok=True)

        cache   = SearchCache(media_dir / ".search_cache.json")
        tracker = SourceTracker(media_dir / ".image_sources.json")
        dry     = options["dry_run"]
        force   = options["force"]
        quality = options["quality_pass"]
        prefix  = "[DRY-RUN] " if dry else ""

        if imagin_key:
            self.stdout.write("  IMAGIN.studio : cle configuree")

        # ── Selection vehicules ─────────────────────────────────────────────
        qs = Vehicle.objects.select_related("category").prefetch_related("images").order_by("id")
        if options["vehicle_id"]:
            qs = qs.filter(id=options["vehicle_id"])
        elif options["category"]:
            qs = qs.filter(category__slug=options["category"])
        if options["only_missing"]:
            qs = qs.exclude(images__is_main=True)
        if options["limit"]:
            qs = qs[: options["limit"]]

        total = qs.count()
        self.stdout.write(f"{prefix}{total} vehicules a traiter.\n")

        report_data = []
        stats = dict(ok=0, partial=0, missing=0, skipped=0)

        for vehicle in qs:
            has_main    = vehicle.images.filter(is_main=True).exists()
            info        = parse_title(vehicle.title)
            brand       = info["brand"]
            model       = info["model"]
            cat_slug    = vehicle.category.slug if vehicle.category else ""
            cat_name    = vehicle.category.name if vehicle.category else ""
            target_year = info["year"] or 0
            ckey        = f"{brand} {model}".lower()

            t1 = tracker.get(vehicle.id, "img1")
            t2 = tracker.get(vehicle.id, "img2")
            before_src1  = t1.get("source", "unknown")
            before_conf1 = t1.get("confidence")
            before_src2  = t2.get("source", "unknown")
            before_conf2 = t2.get("confidence")
            pexels_replaced = before_src1 == "pexels" or before_src2 == "pexels"

            # ── Quality-pass : evaluer si ce vehicule doit etre traite ──────
            if quality and has_main and not force:
                needs_update = (
                    pexels_replaced
                    or (before_conf1 is not None and before_conf1 < MIN_CONF)
                    or (before_conf2 is not None and before_conf2 < MIN_CONF)
                    or before_src1 == "unknown"
                )
                if not needs_update:
                    stats["skipped"] += 1
                    p1 = media_dir / f"vehicle_{vehicle.id}_1.jpg"
                    p2 = media_dir / f"vehicle_{vehicle.id}_2.jpg"
                    report_data.append({
                        "id": vehicle.id, "title": vehicle.title, "category": cat_name,
                        "before_img1": p1 if p1.exists() else None, "before_src1": before_src1,
                        "before_conf1": before_conf1,
                        "before_img2": p2 if p2.exists() else None, "before_src2": before_src2,
                        "before_conf2": before_conf2,
                        "img1_path": p1 if p1.exists() else None, "src1": before_src1,
                        "conf1": before_conf1,
                        "img2_path": p2 if p2.exists() else None, "src2": before_src2,
                        "conf2": before_conf2,
                        "action": "unchanged", "pexels_replaced": False,
                    })
                    continue

            # ── Ignorer si deja complet (hors --force / --quality-pass) ─────
            if has_main and not force and not quality and not options["only_missing"]:
                stats["skipped"] += 1
                continue

            self.stdout.write(f"  [{vehicle.id}] {vehicle.title}")

            # ── Recuperer candidats ─────────────────────────────────────────
            source_order = get_source_order(cat_slug, imagin_key)
            candidates   = None if quality else cache.get(ckey)

            if candidates is not None:
                self.stdout.write(f"    [cache] {len(candidates)} candidats")
            else:
                candidates = fetch_candidates(
                    brand, model, cat_slug, target_year, source_order,
                    imagin_key, self.stdout.write,
                )
                if not quality:
                    cache.set(ckey, candidates)

            # ── Choisir la paire optimale ───────────────────────────────────
            img1, img2 = pick_pair(candidates, cache.usage(), target_year=target_year)

            if not img1:
                self.stdout.write("    -- aucun candidat valide")
                stats["missing"] += 1
                report_data.append({
                    "id": vehicle.id, "title": vehicle.title, "category": cat_name,
                    "before_img1": None, "before_src1": before_src1, "before_conf1": before_conf1,
                    "before_img2": None, "before_src2": before_src2, "before_conf2": before_conf2,
                    "action": "manual", "pexels_replaced": pexels_replaced,
                })
                continue

            # ── Quality-pass : ne remplacer que si gain significatif ────────
            if quality and has_main and not pexels_replaced:
                curr_conf = before_conf1 or 0.0
                if img1.confidence <= curr_conf + REPLACE_GAIN:
                    stats["skipped"] += 1
                    p1 = media_dir / f"vehicle_{vehicle.id}_1.jpg"
                    p2 = media_dir / f"vehicle_{vehicle.id}_2.jpg"
                    report_data.append({
                        "id": vehicle.id, "title": vehicle.title, "category": cat_name,
                        "before_img1": p1 if p1.exists() else None, "before_src1": before_src1,
                        "before_conf1": before_conf1,
                        "before_img2": p2 if p2.exists() else None, "before_src2": before_src2,
                        "before_conf2": before_conf2,
                        "img1_path": p1 if p1.exists() else None, "src1": before_src1,
                        "conf1": before_conf1,
                        "img2_path": p2 if p2.exists() else None, "src2": before_src2,
                        "conf2": before_conf2,
                        "action": "unchanged", "pexels_replaced": False,
                    })
                    continue

            color_info = (
                f"couleur={img1.color or '?'}"
                + (f" -> {img2.color or '?'}" if img2 else "")
                + (" [OK]" if img1.color and img2 and img1.color == img2.color else "")
            )
            self.stdout.write(
                f"    paire : {img1.source}({img1.confidence:.2f}) + "
                f"{(img2.source+'('+f'{img2.confidence:.2f}'+')') if img2 else 'aucune'}"
                f" | {color_info}"
            )

            p1 = media_dir / f"vehicle_{vehicle.id}_1.jpg"
            p2 = media_dir / f"vehicle_{vehicle.id}_2.jpg"
            rec = {
                "id": vehicle.id, "title": vehicle.title, "category": cat_name,
                "before_img1": p1 if has_main and p1.exists() else None,
                "before_src1": before_src1, "before_conf1": before_conf1,
                "before_img2": p2 if has_main and p2.exists() else None,
                "before_src2": before_src2, "before_conf2": before_conf2,
                "conf1": img1.confidence, "src1": img1.source,
                "conf2": img2.confidence if img2 else None,
                "src2": img2.source if img2 else "—",
                "img1_path": None, "img2_path": None,
                "pexels_replaced": pexels_replaced,
                "action": "improved" if (quality and has_main) else "new",
            }

            if dry:
                rec["img1_path"] = rec["before_img1"] or p1
                rec["img2_path"] = rec["before_img2"] or (p2 if img2 else None)
                rec["status"] = "ok" if img2 else "partial"
                if not img2:
                    rec["action"] = "one_image"
            else:
                if force or quality:
                    vehicle.images.all().delete()
                    tracker.clear(vehicle.id)

                # Photo 1 (principale)
                if download_image(img1.url, p1):
                    VehicleImage.objects.update_or_create(
                        vehicle=vehicle,
                        image=f"vehicles/vehicle_{vehicle.id}_1.jpg",
                        defaults={"is_main": True},
                    )
                    cache.mark_used(img1.url)
                    tracker.set(vehicle.id, "img1", img1.source, img1.url, img1.confidence)
                    rec["img1_path"] = p1
                    self.stdout.write("    OK photo 1 sauvegardee")
                else:
                    self.stdout.write("    -- photo 1 echec")

                # Photo 2
                if img2:
                    if download_image(img2.url, p2):
                        VehicleImage.objects.update_or_create(
                            vehicle=vehicle,
                            image=f"vehicles/vehicle_{vehicle.id}_2.jpg",
                            defaults={"is_main": False},
                        )
                        cache.mark_used(img2.url)
                        tracker.set(vehicle.id, "img2", img2.source, img2.url, img2.confidence)
                        rec["img2_path"] = p2
                        self.stdout.write("    OK photo 2 sauvegardee")
                    else:
                        self.stdout.write("    -- photo 2 echec")
                else:
                    rec["action"] = "one_image"

                rec["status"] = (
                    "ok"      if rec["img1_path"] and rec["img2_path"] else
                    "partial" if rec["img1_path"] else
                    "missing"
                )

            stats[rec["status"]] = stats.get(rec["status"], 0) + 1
            report_data.append(rec)
            time.sleep(0.4)

        # ── Resume ─────────────────────────────────────────────────────────
        self.stdout.write(self.style.SUCCESS(
            f"\n{prefix}Termine : {stats['ok']} complets, {stats['partial']} partiels, "
            f"{stats['missing']} manquants, {stats['skipped']} ignores."
        ))

        if options["report"] and report_data:
            out = media_dir / "rapport_qualite.html"
            generate_html_report(report_data, out, getattr(settings, "MEDIA_URL", "/media/"))
            self.stdout.write(f"Rapport HTML : {out}")
