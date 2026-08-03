import os
import re
import time
from pathlib import Path

import requests
from django.conf import settings
from django.core.management.base import BaseCommand

from vehicles.models import Vehicle, VehicleImage


WIKIPEDIA_API = "https://en.wikipedia.org/w/api.php"
PEXELS_URL    = "https://api.pexels.com/v1/search"

# Article Wikipedia exact pour chaque modele
WIKI_TITLES = {
    # Citadines
    ("renault",      "clio"):                   "Renault Clio",
    ("peugeot",      "208"):                    "Peugeot 208",
    ("citroen",      "c3"):                     "Citroen C3",
    ("ford",         "fiesta"):                 "Ford Fiesta",
    ("volkswagen",   "polo"):                   "Volkswagen Polo",
    ("toyota",       "yaris"):                  "Toyota Yaris",
    ("fiat",         "500"):                    "Fiat 500 (2007)",
    ("opel",         "corsa"):                  "Opel Corsa",
    ("dacia",        "sandero"):                "Dacia Sandero",
    ("seat",         "ibiza"):                  "SEAT Ibiza",
    ("hyundai",      "i20"):                    "Hyundai i20",
    ("kia",          "picanto"):                "Kia Picanto",
    ("suzuki",       "swift"):                  "Suzuki Swift",
    ("skoda",        "fabia"):                  "Skoda Fabia",
    # Compactes
    ("renault",      "megane"):                 "Renault Megane",
    ("peugeot",      "308"):                    "Peugeot 308",
    ("volkswagen",   "golf"):                   "Volkswagen Golf",
    ("ford",         "focus"):                  "Ford Focus",
    ("toyota",       "auris"):                  "Toyota Auris",
    ("hyundai",      "i30"):                    "Hyundai i30",
    ("kia",          "ceed"):                   "Kia Ceed",
    ("seat",         "leon"):                   "SEAT Leon",
    ("opel",         "astra"):                  "Opel Astra",
    # SUV
    ("renault",      "captur"):                 "Renault Captur",
    ("peugeot",      "2008"):                   "Peugeot 2008",
    ("citroen",      "c3 aircross"):            "Citroen C3 Aircross",
    ("dacia",        "duster"):                 "Dacia Duster",
    ("nissan",       "juke"):                   "Nissan Juke",
    ("kia",          "stonic"):                 "Kia Stonic",
    ("hyundai",      "kona"):                   "Hyundai Kona",
    ("ford",         "puma"):                   "Ford Puma (2019)",
    # Breaks
    ("peugeot",      "308 sw"):                 "Peugeot 308",
    ("renault",      "megane estate"):          "Renault Megane",
    ("volkswagen",   "golf variant"):           "Volkswagen Golf",
    ("ford",         "focus estate"):           "Ford Focus",
    ("opel",         "astra sports tourer"):    "Opel Astra",
    ("skoda",        "octavia combi"):          "Skoda Octavia",
    # Velos
    ("giant",        "escape 3"):               "Giant Escape",
    ("trek",         "fx 3"):                   "Trek FX",
    ("cannondale",   "quick 4"):                "Cannondale Quick",
    ("decathlon",    "rockrider 340"):          "Rockrider",
    ("decathlon",    "rockrider 520"):          "Rockrider",
    ("scott",        "aspect 50"):              "Scott Aspect",
    ("specialized",  "crossroads 2"):           "Specialized bicycle",
    ("btwin",        "riverside 500"):          "BTwin",
    ("cube",         "nature pro"):             "Cube Bikes",
    ("orbea",        "vector 30"):              "Orbea",
    # Motos
    ("yamaha",       "mt-07"):                  "Yamaha MT-07",
    ("honda",        "cb500f"):                 "Honda CB500",
    ("kawasaki",     "z650"):                   "Kawasaki Z650",
    ("kawasaki",     "z400"):                   "Kawasaki Z400",
    ("suzuki",       "sv650"):                  "Suzuki SV650",
    ("royal enfield","meteor 350"):             "Royal Enfield Meteor 350",
    # Scooters
    ("yamaha",       "aerox 50"):               "Yamaha Aerox",
    ("yamaha",       "nmax 125"):               "Yamaha NMAX",
    ("honda",        "pcx 125"):                "Honda PCX",
    ("piaggio",      "vespa primavera"):        "Vespa Primavera",
    ("kymco",        "agility 125"):            "Kymco Agility",
    ("peugeot",      "django 125"):             "Peugeot Django",
    # Trottinettes
    ("xiaomi",       "mi electric scooter 3"):  "Xiaomi Mi Electric Scooter",
    ("xiaomi",       "mi pro 2"):               "Xiaomi Mi Electric Scooter",
    ("segway",       "ninebot max g30"):         "Segway Ninebot",
    ("kaabo",        "mantis 10"):              "Kaabo Mantis",
}

# Suffixe Pexels par categorie pour affiner la recherche
PEXELS_SUFFIX = {
    "citadine":         "hatchback exterior parked",
    "compacte":         "hatchback exterior parked",
    "suv-compact":      "SUV exterior parked",
    "break":            "estate wagon exterior parked",
    "velo":             "bicycle side view",
    "moto-legere":      "motorcycle side view",
    "scooter":          "scooter side view",
    "trottinette":      "electric scooter",
}


def parse_title(title):
    """Retourne (brand_model_str, wiki_title_or_None)."""
    tokens = [t for t in title.split() if not t.startswith("#")]
    # Retirer uniquement le dernier token s'il ressemble a une annee
    if tokens and re.fullmatch(r"\d{4}", tokens[-1]):
        tokens = tokens[:-1]
    # Chercher le meilleur match dans WIKI_TITLES
    wiki = None
    for i in range(1, len(tokens)):
        brand = " ".join(tokens[:i]).lower()
        model = " ".join(tokens[i:]).lower()
        if (brand, model) in WIKI_TITLES:
            wiki = WIKI_TITLES[(brand, model)]
            break
    brand_model = " ".join(tokens)  # ex: "Renault Clio"
    return brand_model, wiki


def get_wiki_thumbnail(article_title):
    """Appelle l'API Wikipedia avec 3 tentatives sur 429."""
    params = {
        "action": "query",
        "titles": article_title,
        "prop": "pageimages",
        "format": "json",
        "pithumbsize": 1200,
    }
    for attempt in range(3):
        try:
            r = requests.get(
                WIKIPEDIA_API,
                params=params,
                headers={"User-Agent": "MultiDriveTFE/1.0"},
                timeout=15,
            )
            if r.status_code == 429:
                time.sleep(3 * (attempt + 1))
                continue
            r.raise_for_status()
            pages = r.json().get("query", {}).get("pages", {})
            for page in pages.values():
                if page.get("pageid", -1) != -1:
                    thumb = page.get("thumbnail", {}).get("source")
                    if thumb:
                        return thumb
            break
        except Exception:
            time.sleep(1)
    return None


def search_pexels(query, api_key, per_page=15):
    headers = {"Authorization": api_key}
    params  = {"query": query, "per_page": per_page, "orientation": "landscape"}
    r = requests.get(PEXELS_URL, headers=headers, params=params, timeout=10)
    r.raise_for_status()
    return r.json().get("photos", [])


def pexels_url_at(photos, vehicle_id, offset=0):
    if not photos:
        return None
    return photos[(vehicle_id + offset) % len(photos)]["src"]["large"]


def download_image(url, dest_path, api_key=None):
    headers = {"User-Agent": "Mozilla/5.0"}
    if api_key and "pexels" in url:
        headers["Authorization"] = api_key
    r = requests.get(url, headers=headers, timeout=30, stream=True)
    r.raise_for_status()
    with open(dest_path, "wb") as f:
        for chunk in r.iter_content(chunk_size=8192):
            f.write(chunk)


class Command(BaseCommand):
    help = "Telecharge 2 images par vehicule : Wikipedia (modele exact) + Pexels (modele specifique)."

    def add_arguments(self, parser):
        parser.add_argument("--force", action="store_true", help="Remplace les images existantes.")

    def handle(self, *args, **options):
        api_key = os.environ.get("PEXELS_API_KEY", "")
        if not api_key:
            self.stderr.write("PEXELS_API_KEY manquant dans .env")
            return

        force     = options["force"]
        media_dir = Path(settings.MEDIA_ROOT) / "vehicles"
        media_dir.mkdir(parents=True, exist_ok=True)

        vehicles = Vehicle.objects.select_related("category").prefetch_related("images").all()
        self.stdout.write(f"{vehicles.count()} vehicules trouves.\n")

        ok = skipped = errors = 0

        for vehicle in vehicles:
            if vehicle.images.filter(is_main=True).exists() and not force:
                skipped += 1
                continue
            if force:
                vehicle.images.all().delete()

            cat_slug             = vehicle.category.slug if vehicle.category else ""
            brand_model, wiki_title = parse_title(vehicle.title)
            self.stdout.write(f"  [{vehicle.id}] {vehicle.title}")

            # ── Photo 1 : Wikipedia thumbnail du bon article ──────────────
            img1_url = None
            if wiki_title:
                img1_url = get_wiki_thumbnail(wiki_title)
                if img1_url:
                    self.stdout.write(f"    OK wiki  : {wiki_title}")
                else:
                    self.stdout.write(f"    -- wiki  : pas de thumbnail ({wiki_title})")
                time.sleep(1.2)
            else:
                self.stdout.write(f"    -- wiki  : pas de mapping pour {brand_model!r}")

            # ── Photo 2 : Pexels avec nom du modele exact ─────────────────
            suffix  = PEXELS_SUFFIX.get(cat_slug, "exterior")
            # Ex: "Renault Clio hatchback exterior parked"
            query2  = f"{brand_model} {suffix}"
            img2_url = None
            try:
                photos   = search_pexels(query2, api_key)
                img2_url = pexels_url_at(photos, vehicle.id, 0)
                self.stdout.write(f"    OK pexels: {query2!r} ({len(photos)} resultats)")
            except Exception as e:
                self.stderr.write(f"    Pexels erreur : {e}")

            # Si Wikipedia a echoue, on utilise aussi Pexels pour la photo 1
            if not img1_url:
                try:
                    photos1 = search_pexels(f"{brand_model} {suffix}", api_key)
                    img1_url = pexels_url_at(photos1, vehicle.id, 1) or pexels_url_at(photos1, vehicle.id, 0)
                except Exception:
                    pass

            # ── Sauvegarde ────────────────────────────────────────────────
            saved = 0
            for i, url in enumerate([img1_url, img2_url]):
                if not url:
                    continue
                filename = f"vehicle_{vehicle.id}_{i + 1}.jpg"
                try:
                    download_image(url, str(media_dir / filename), api_key)
                    VehicleImage.objects.create(
                        vehicle=vehicle,
                        image=f"vehicles/{filename}",
                        is_main=(i == 0),
                    )
                    self.stdout.write(f"    OK photo {i + 1} sauvegardee")
                    saved += 1
                except Exception as e:
                    self.stderr.write(f"    Erreur photo {i + 1} : {e}")

            ok     += 1 if saved > 0 else 0
            errors += 1 if saved == 0 else 0
            time.sleep(0.5)

        self.stdout.write(self.style.SUCCESS(
            f"\nTermine -- {ok} mis a jour, {skipped} ignores, {errors} erreurs."
        ))
