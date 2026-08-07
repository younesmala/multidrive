"""
import_vehicle_library
=====================
Importe les images depuis la bibliotheque locale controlee.

Structure attendue :
    media/
        vehicle_library/
            001_renault_clio_2004_gris_metallise/
                main.jpg        (ou .jpeg / .webp)
                secondary.jpg   (optionnel)

Aucun telechargement. Aucun appel API.
Cette commande ne lit que des fichiers deja presents sur le disque.

Usage :
    python manage.py import_vehicle_library
    python manage.py import_vehicle_library --dry-run
    python manage.py import_vehicle_library --limit 5
    python manage.py import_vehicle_library --vehicle-id 42
    python manage.py import_vehicle_library --only-missing
    python manage.py import_vehicle_library --force
    python manage.py import_vehicle_library --report
"""

import csv
import re
import shutil
from pathlib import Path

from django.conf import settings
from django.core.management.base import BaseCommand

from vehicles.models import Vehicle, VehicleImage

# Extensions acceptees, dans l'ordre de priorite
IMAGE_EXTS = [".jpg", ".jpeg", ".webp", ".png"]

# CSV de reference
CSV_PATH = Path(settings.BASE_DIR) / "multidrive_vehicle_reference.csv"

# Bibliotheque d'images
LIBRARY_DIR = Path(settings.MEDIA_ROOT) / "vehicle_library"

# Dossier de destination Django (upload_to="vehicles/")
VEHICLES_DIR = Path(settings.MEDIA_ROOT) / "vehicles"

# Rapport CSV de sortie
REPORTS_DIR = Path(settings.BASE_DIR) / "reports"


# ── Utilitaires ────────────────────────────────────────────────────────────────

def find_image(folder: Path, stem: str) -> Path | None:
    """Cherche stem.jpg / stem.jpeg / stem.webp / stem.png dans folder."""
    for ext in IMAGE_EXTS:
        candidate = folder / (stem + ext)
        if candidate.exists():
            return candidate
    return None


def normalize(text: str) -> str:
    """Minuscules, supprime ponctuation, espaces normalises."""
    return re.sub(r"[^a-z0-9 ]", " ", text.lower()).split()


def title_matches(title: str, brand: str, model: str, year: int) -> bool:
    """
    Verifie si un titre Vehicle correspond a brand + model + year.
    Robuste : fonctionne meme si brand contient plusieurs mots (ex: Royal Enfield).
    """
    title_clean = title.lower()
    brand_words = normalize(brand)
    model_words = normalize(model)
    title_words = normalize(title_clean)

    # L'annee doit apparaitre comme token dans le titre
    if str(year) not in title_words:
        return False

    # Tous les mots de brand doivent etre dans le titre
    if not all(w in title_words for w in brand_words):
        return False

    # Tous les mots de model doivent etre dans le titre
    if not all(w in title_words for w in model_words):
        return False

    return True


def find_vehicle(brand: str, model: str, year: int):
    """
    Retrouve le Vehicle correspondant dans la DB.
    Retourne (vehicle, error_message).
    """
    matches = [
        v for v in Vehicle.objects.exclude(status=Vehicle.STATUS_SOLD)
                                  .select_related("category").all()
        if title_matches(v.title, brand, model, year)
    ]
    if len(matches) == 0:
        return None, f"Aucun vehicule trouve pour {brand} {model} {year}"
    if len(matches) > 1:
        ids = ", ".join(f"#{v.id} {v.title}" for v in matches)
        return None, f"Correspondance ambigue ({len(matches)} vehicules) : {ids}"
    return matches[0], None


# ── Commande ───────────────────────────────────────────────────────────────────

class Command(BaseCommand):
    help = "Importe les images depuis media/vehicle_library/ (bibliotheque locale, sans telechargement)."

    def add_arguments(self, parser):
        parser.add_argument("--dry-run",      action="store_true",
                            help="Simule sans modifier la DB ni copier de fichier.")
        parser.add_argument("--force",        action="store_true",
                            help="Remplace les images existantes.")
        parser.add_argument("--only-missing", action="store_true",
                            help="Traite uniquement les vehicules sans photo principale.")
        parser.add_argument("--limit",       type=int, default=0, metavar="N",
                            help="Traite les N premieres lignes du CSV.")
        parser.add_argument("--vehicle-id",  type=int, default=0, metavar="ID",
                            help="Traite un seul vehicule par son ID Django.")
        parser.add_argument("--report",      action="store_true",
                            help="Genere reports/import_vehicle_library_report.csv")

    def handle(self, *args, **options):
        dry    = options["dry_run"]
        force  = options["force"]
        prefix = "[DRY-RUN] " if dry else ""

        VEHICLES_DIR.mkdir(parents=True, exist_ok=True)
        REPORTS_DIR.mkdir(parents=True, exist_ok=True)

        # ── Lire le CSV ────────────────────────────────────────────────────
        if not CSV_PATH.exists():
            self.stderr.write(f"CSV introuvable : {CSV_PATH}")
            return

        with open(CSV_PATH, newline="", encoding="utf-8") as f:
            rows = list(csv.DictReader(f))

        self.stdout.write(f"CSV charge : {len(rows)} lignes")
        self.stdout.write(f"Bibliotheque : {LIBRARY_DIR}")

        # ── Verifier les dossiers ──────────────────────────────────────────
        if not LIBRARY_DIR.exists():
            self.stderr.write(f"Bibliotheque introuvable : {LIBRARY_DIR}")
            return

        lib_folders = {d.name for d in LIBRARY_DIR.iterdir() if d.is_dir()}
        self.stdout.write(f"Dossiers trouves : {len(lib_folders)}\n")

        # Differences CSV / dossiers
        csv_folders = {row["folder"] for row in rows}
        missing_dirs = csv_folders - lib_folders
        extra_dirs   = lib_folders - csv_folders
        if missing_dirs:
            self.stdout.write(f"  ATTENTION : {len(missing_dirs)} dossier(s) CSV absent(s) du disque :")
            for d in sorted(missing_dirs):
                self.stdout.write(f"    - {d}")
        if extra_dirs:
            self.stdout.write(f"  INFO : {len(extra_dirs)} dossier(s) sur disque non references dans le CSV :")
            for d in sorted(extra_dirs):
                self.stdout.write(f"    + {d}")

        # ── Filtrer les lignes a traiter ───────────────────────────────────
        if options["limit"]:
            rows = rows[: options["limit"]]

        if options["vehicle_id"]:
            target_id = options["vehicle_id"]
            # On garde uniquement la ligne CSV dont le vehicule correspond
            filtered = []
            for row in rows:
                v, _ = find_vehicle(row["brand"], row["model"], int(row["year"]))
                if v and v.id == target_id:
                    filtered.append(row)
            rows = filtered
            if not rows:
                self.stderr.write(f"Vehicule #{target_id} non trouve dans le CSV.")
                return

        self.stdout.write(f"{prefix}{len(rows)} vehicule(s) a traiter.\n")

        # ── Statistiques ───────────────────────────────────────────────────
        stats = dict(imported=0, two_images=0, one_image=0,
                     skipped=0, missing_folder=0, no_main=0,
                     no_vehicle=0, ambiguous=0, errors=0)

        report_rows = []

        for row in rows:
            brand  = row["brand"]
            model  = row["model"]
            year   = int(row["year"])
            folder = row["folder"]

            rec = {
                "id": "", "brand": brand, "model": model, "year": year,
                "folder": folder, "main_found": "non", "secondary_found": "non",
                "status": "", "error": "",
            }

            # 1. Retrouver le vehicule en DB
            vehicle, err = find_vehicle(brand, model, year)
            if err:
                self.stdout.write(f"  [{folder}] ERREUR : {err}")
                if "ambigue" in err:
                    stats["ambiguous"] += 1
                else:
                    stats["no_vehicle"] += 1
                rec["status"] = "erreur"
                rec["error"]  = err
                report_rows.append(rec)
                continue

            rec["id"] = vehicle.id

            # 2. Filtre --only-missing
            if options["only_missing"] and vehicle.images.filter(is_main=True).exists():
                stats["skipped"] += 1
                rec["status"] = "ignore"
                report_rows.append(rec)
                continue

            # 3. Filtre vehicule deja complet (sans --force)
            if vehicle.images.filter(is_main=True).exists() and not force:
                stats["skipped"] += 1
                rec["status"] = "ignore"
                report_rows.append(rec)
                continue

            # 4. Chercher le dossier de la bibliotheque
            lib_folder = LIBRARY_DIR / folder
            if not lib_folder.exists():
                self.stdout.write(f"  [{vehicle.id}] {vehicle.title} — dossier absent : {folder}")
                stats["missing_folder"] += 1
                rec["status"] = "erreur"
                rec["error"]  = f"Dossier absent : {folder}"
                report_rows.append(rec)
                continue

            # 5. Chercher main et secondary
            main_src      = find_image(lib_folder, "main")
            secondary_src = find_image(lib_folder, "secondary")

            if main_src:
                rec["main_found"] = "oui"
            if secondary_src:
                rec["secondary_found"] = "oui"

            self.stdout.write(
                f"  [{vehicle.id}] {vehicle.title}"
                f" | main={'oui' if main_src else 'NON'}"
                f" | secondary={'oui' if secondary_src else 'non'}"
            )

            if not main_src:
                self.stdout.write(f"    -- aucune image principale dans {folder}")
                stats["no_main"] += 1
                rec["status"] = "sans_image"
                rec["error"]  = "main.jpg absent"
                report_rows.append(rec)
                continue

            if dry:
                status = "ok_2img" if secondary_src else "ok_1img"
                rec["status"] = status
                report_rows.append(rec)
                if secondary_src:
                    stats["two_images"] += 1
                else:
                    stats["one_image"] += 1
                stats["imported"] += 1
                continue

            # 6. Supprimer les images existantes si --force
            if force:
                vehicle.images.all().delete()

            # 7. Copier et enregistrer main
            dest_main = VEHICLES_DIR / f"vehicle_{vehicle.id}_1{main_src.suffix}"
            try:
                shutil.copy2(main_src, dest_main)
                rel_main = f"vehicles/vehicle_{vehicle.id}_1{main_src.suffix}"
                VehicleImage.objects.update_or_create(
                    vehicle=vehicle,
                    image=rel_main,
                    defaults={"is_main": True},
                )
                self.stdout.write(f"    OK photo principale : {dest_main.name}")
            except Exception as e:
                self.stdout.write(f"    ERREUR photo principale : {e}")
                stats["errors"] += 1
                rec["status"] = "erreur"
                rec["error"]  = str(e)
                report_rows.append(rec)
                continue

            # 8. Copier et enregistrer secondary (si presente)
            if secondary_src:
                dest_sec = VEHICLES_DIR / f"vehicle_{vehicle.id}_2{secondary_src.suffix}"
                try:
                    shutil.copy2(secondary_src, dest_sec)
                    rel_sec = f"vehicles/vehicle_{vehicle.id}_2{secondary_src.suffix}"
                    VehicleImage.objects.update_or_create(
                        vehicle=vehicle,
                        image=rel_sec,
                        defaults={"is_main": False},
                    )
                    self.stdout.write(f"    OK photo secondaire : {dest_sec.name}")
                    stats["two_images"] += 1
                except Exception as e:
                    self.stdout.write(f"    ERREUR photo secondaire : {e}")
                    stats["one_image"] += 1
            else:
                stats["one_image"] += 1

            stats["imported"] += 1
            rec["status"] = "ok_2img" if secondary_src else "ok_1img"
            report_rows.append(rec)

        # ── Resume terminal ────────────────────────────────────────────────
        self.stdout.write("")
        self.stdout.write(self.style.SUCCESS(
            f"{prefix}Termine :\n"
            f"  Importes      : {stats['imported']}\n"
            f"  Avec 2 images : {stats['two_images']}\n"
            f"  Avec 1 image  : {stats['one_image']}\n"
            f"  Ignores       : {stats['skipped']}\n"
            f"  Sans image    : {stats['no_main']}\n"
            f"  Sans vehicule : {stats['no_vehicle']}\n"
            f"  Ambigus       : {stats['ambiguous']}\n"
            f"  Erreurs       : {stats['errors']}"
        ))

        # ── Rapport CSV ────────────────────────────────────────────────────
        if options["report"]:
            report_path = REPORTS_DIR / "import_vehicle_library_report.csv"
            fieldnames  = ["id", "brand", "model", "year", "folder",
                           "main_found", "secondary_found", "status", "error"]
            with open(report_path, "w", newline="", encoding="utf-8") as f:
                writer = csv.DictWriter(f, fieldnames=fieldnames)
                writer.writeheader()
                writer.writerows(report_rows)
            self.stdout.write(f"\nRapport CSV : {report_path}")
