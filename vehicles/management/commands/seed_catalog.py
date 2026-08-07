from django.core.management.base import BaseCommand
from django.db import transaction

from payments.models import Payment
from reservations.models import Reservation
from vehicles.models import Favorite, Review, Vehicle, VehicleCategory


VEHICLES = [
    # (slug_categorie, marque, modele, annee, prix)
    # Prix maximum : 3 000 EUR — vehicules d'occasion petit budget
    # Repartition : 60% voitures | 20% moto/scooter | 20% velo/trottinette

    # ── Citadines — 33 vehicules (2004-2013, 800-2 800 EUR) ─────────────────
    ("citadine", "Renault",    "Clio",       2004,   900),
    ("citadine", "Renault",    "Clio",       2006,  1400),
    ("citadine", "Renault",    "Clio",       2009,  2000),
    ("citadine", "Renault",    "Twingo",     2005,   750),
    ("citadine", "Renault",    "Twingo",     2008,  1100),
    ("citadine", "Peugeot",    "206",        2004,   800),
    ("citadine", "Peugeot",    "207",        2007,  1300),
    ("citadine", "Peugeot",    "207",        2010,  1800),
    ("citadine", "Peugeot",    "208",        2013,  2600),
    ("citadine", "Citroen",    "C2",         2005,   850),
    ("citadine", "Citroen",    "C3",         2005,  1100),
    ("citadine", "Citroen",    "C3",         2008,  1600),
    ("citadine", "Ford",       "Fiesta",     2005,  1000),
    ("citadine", "Ford",       "Fiesta",     2008,  1600),
    ("citadine", "Ford",       "Fiesta",     2011,  2200),
    ("citadine", "Volkswagen", "Polo",       2006,  1400),
    ("citadine", "Volkswagen", "Polo",       2009,  2000),
    ("citadine", "Toyota",     "Yaris",      2005,  1100),
    ("citadine", "Toyota",     "Yaris",      2008,  1700),
    ("citadine", "Fiat",       "Punto",      2005,   800),
    ("citadine", "Fiat",       "500",        2009,  1600),
    ("citadine", "Opel",       "Corsa",      2005,   950),
    ("citadine", "Opel",       "Corsa",      2008,  1500),
    ("citadine", "Dacia",      "Sandero",    2009,  1800),
    ("citadine", "Dacia",      "Sandero",    2012,  2400),
    ("citadine", "Seat",       "Ibiza",      2006,  1100),
    ("citadine", "Seat",       "Ibiza",      2009,  1700),
    ("citadine", "Hyundai",    "i10",        2009,  1200),
    ("citadine", "Hyundai",    "i20",        2011,  1800),
    ("citadine", "Kia",        "Picanto",    2007,  1000),
    ("citadine", "Kia",        "Picanto",    2010,  1500),
    ("citadine", "Suzuki",     "Swift",      2007,  1200),
    ("citadine", "Skoda",      "Fabia",      2008,  1300),

    # ── Compactes — 14 vehicules (2004-2011, 1 400-2 900 EUR) ───────────────
    ("compacte", "Renault",    "Megane",     2004,  1400),
    ("compacte", "Renault",    "Megane",     2007,  1900),
    ("compacte", "Renault",    "Megane",     2010,  2500),
    ("compacte", "Peugeot",    "307",        2004,  1400),
    ("compacte", "Peugeot",    "308",        2009,  2400),
    ("compacte", "Volkswagen", "Golf",       2005,  2100),
    ("compacte", "Volkswagen", "Golf",       2008,  2700),
    ("compacte", "Ford",       "Focus",      2005,  1500),
    ("compacte", "Ford",       "Focus",      2008,  2100),
    ("compacte", "Opel",       "Astra",      2005,  1400),
    ("compacte", "Opel",       "Astra",      2008,  2000),
    ("compacte", "Toyota",     "Auris",      2007,  1800),
    ("compacte", "Hyundai",    "i30",        2008,  1700),
    ("compacte", "Seat",       "Leon",       2006,  1600),

    # ── SUV compact — 5 vehicules (2007-2013, 1 900-3 000 EUR) ──────────────
    ("suv-compact", "Dacia",   "Duster",     2011,  2800),
    ("suv-compact", "Dacia",   "Duster",     2013,  3000),
    ("suv-compact", "Nissan",  "Juke",       2011,  2600),
    ("suv-compact", "Kia",     "Sportage",   2008,  2100),
    ("suv-compact", "Hyundai", "Tucson",     2007,  1900),

    # ── Break — 5 vehicules (2005-2009, 1 600-2 400 EUR) ────────────────────
    ("break", "Renault",       "Megane Estate",       2005,  1600),
    ("break", "Peugeot",       "307 SW",              2005,  1700),
    ("break", "Volkswagen",    "Golf Variant",        2007,  2200),
    ("break", "Ford",          "Focus Estate",        2006,  1700),
    ("break", "Opel",          "Astra Sports Tourer", 2008,  2000),

    # ── Moto legere — 10 vehicules (125cc, 2008-2019, 1 400-3 000 EUR) ──────
    ("moto-legere", "Honda",         "CB125F",     2016,  1800),
    ("moto-legere", "Honda",         "CB125R",     2018,  2500),
    ("moto-legere", "Honda",         "CBR 125R",   2015,  2300),
    ("moto-legere", "Yamaha",        "YBR 125",    2012,  1400),
    ("moto-legere", "Yamaha",        "YBR 125",    2015,  1900),
    ("moto-legere", "Yamaha",        "MT-125",     2017,  2700),
    ("moto-legere", "Kawasaki",      "Z125 Pro",   2017,  2100),
    ("moto-legere", "KTM",           "Duke 125",   2015,  2400),
    ("moto-legere", "Benelli",       "TNT 125",    2018,  1600),
    ("moto-legere", "Royal Enfield", "Bullet 350", 2009,  1800),

    # ── Scooter — 9 vehicules (50cc-125cc, 2013-2019, 400-2 400 EUR) ────────
    ("scooter", "Yamaha",  "Aerox 50",       2015,   650),
    ("scooter", "Yamaha",  "Aerox 50",       2019,   950),
    ("scooter", "Yamaha",  "Xenter 125",     2015,  1600),
    ("scooter", "Honda",   "SH 125",         2013,  1800),
    ("scooter", "Honda",   "PCX 125",        2016,  2200),
    ("scooter", "Piaggio", "Fly 125",        2015,  1100),
    ("scooter", "Peugeot", "Vivacity 50",    2014,   500),
    ("scooter", "Peugeot", "Kisbee 50",      2017,   420),
    ("scooter", "Kymco",   "Agility 50",     2016,   580),

    # ── Velo — 11 vehicules (2018-2021, 180-550 EUR) ────────────────────────
    ("velo", "Giant",      "Escape 3",       2018,   350),
    ("velo", "Giant",      "Escape 3",       2020,   480),
    ("velo", "Trek",       "FX 3",           2019,   420),
    ("velo", "Trek",       "Marlin 5",       2020,   490),
    ("velo", "Cannondale", "Quick 4",        2019,   380),
    ("velo", "Decathlon",  "Rockrider 340",  2018,   180),
    ("velo", "Decathlon",  "Rockrider 520",  2020,   280),
    ("velo", "Scott",      "Aspect 50",      2019,   310),
    ("velo", "Btwin",      "Riverside 500",  2020,   260),
    ("velo", "Cube",       "Nature Pro",     2019,   370),
    ("velo", "Orbea",      "Vector 30",      2020,   440),

    # ── Trottinette — 7 vehicules (2019-2022, 200-900 EUR) ──────────────────
    ("trottinette", "Xiaomi",  "Mi Electric Scooter 3", 2021,  280),
    ("trottinette", "Xiaomi",  "Mi Pro 2",              2020,  370),
    ("trottinette", "Xiaomi",  "Mi Scooter Essential",  2020,  200),
    ("trottinette", "Segway",  "Ninebot Max G30",       2021,  550),
    ("trottinette", "Segway",  "Ninebot ES2",           2019,  300),
    ("trottinette", "Kaabo",   "Mantis 10",             2021,  850),
    ("trottinette", "Oxelo",   "Town 7",                2020,  240),
]


class Command(BaseCommand):
    help = "Recrée le catalogue en gardant les véhicules vendus."

    @transaction.atomic
    def handle(self, *args, **options):
        # Véhicules à supprimer (tout sauf vendus)
        to_delete = Vehicle.objects.exclude(status=Vehicle.STATUS_SOLD)
        count_del = to_delete.count()

        # Supprimer dans l'ordre pour respecter les contraintes
        Payment.objects.filter(reservation__vehicle__in=to_delete).delete()
        Reservation.objects.filter(vehicle__in=to_delete).delete()
        Review.objects.filter(vehicle__in=to_delete).delete()
        Favorite.objects.filter(vehicle__in=to_delete).delete()
        to_delete.delete()

        self.stdout.write(f"{count_del} véhicules supprimés (vendus conservés).")

        # Numéro de série suivant
        serial = 1

        created = 0
        for slug, brand, model, year, price in VEHICLES:
            cat = VehicleCategory.objects.filter(slug=slug).first()
            if not cat:
                self.stderr.write(f"Catégorie introuvable : {slug}")
                continue

            title = f"{brand} {model} {year} #{serial:03d}"
            Vehicle.objects.create(
                category=cat,
                title=title,
                description=(
                    f"{brand} {model} de {year}. Véhicule en bon état général, "
                    f"entretien suivi, idéal pour petits budgets."
                ),
                price=price,
                status=Vehicle.STATUS_AVAILABLE,
            )
            serial += 1
            created += 1

        self.stdout.write(self.style.SUCCESS(
            f"{created} véhicules créés. Total catalogue : "
            f"{Vehicle.objects.count()} véhicules."
        ))
