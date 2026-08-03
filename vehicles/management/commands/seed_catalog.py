from django.core.management.base import BaseCommand
from django.db import transaction

from payments.models import Payment
from reservations.models import Reservation
from vehicles.models import Favorite, Review, Vehicle, VehicleCategory


VEHICLES = [
    # (slug_categorie, marque, modele, annee, prix)

    # ── Citadines (petits budgets) ──────────────────────────────────────────
    ("citadine", "Renault",   "Clio",        2012, 1800),
    ("citadine", "Renault",   "Clio",        2015, 2900),
    ("citadine", "Renault",   "Clio",        2018, 4200),
    ("citadine", "Peugeot",   "208",         2013, 2100),
    ("citadine", "Peugeot",   "208",         2016, 3200),
    ("citadine", "Peugeot",   "208",         2019, 5500),
    ("citadine", "Citroen",   "C3",          2012, 1900),
    ("citadine", "Citroen",   "C3",          2015, 2800),
    ("citadine", "Citroen",   "C3",          2019, 5200),
    ("citadine", "Ford",      "Fiesta",      2013, 2200),
    ("citadine", "Ford",      "Fiesta",      2017, 3800),
    ("citadine", "Volkswagen","Polo",        2014, 2600),
    ("citadine", "Volkswagen","Polo",        2018, 4800),
    ("citadine", "Toyota",    "Yaris",       2013, 2400),
    ("citadine", "Toyota",    "Yaris",       2017, 4000),
    ("citadine", "Fiat",      "500",         2012, 2000),
    ("citadine", "Fiat",      "500",         2016, 3500),
    ("citadine", "Opel",      "Corsa",       2013, 1900),
    ("citadine", "Opel",      "Corsa",       2018, 3600),
    ("citadine", "Dacia",     "Sandero",     2014, 1500),
    ("citadine", "Dacia",     "Sandero",     2018, 2800),
    ("citadine", "Seat",      "Ibiza",       2014, 2300),
    ("citadine", "Seat",      "Ibiza",       2019, 5000),
    ("citadine", "Hyundai",   "i20",         2015, 2700),
    ("citadine", "Hyundai",   "i20",         2019, 4600),
    ("citadine", "Kia",       "Picanto",     2013, 1800),
    ("citadine", "Kia",       "Picanto",     2018, 3800),
    ("citadine", "Suzuki",    "Swift",       2016, 3000),
    ("citadine", "Skoda",     "Fabia",       2015, 2500),
    ("citadine", "Skoda",     "Fabia",       2019, 4400),

    # ── Compactes ───────────────────────────────────────────────────────────
    ("compacte", "Renault",   "Megane",      2013, 3500),
    ("compacte", "Renault",   "Megane",      2017, 6200),
    ("compacte", "Peugeot",   "308",         2014, 4000),
    ("compacte", "Peugeot",   "308",         2018, 7500),
    ("compacte", "Volkswagen","Golf",        2013, 5000),
    ("compacte", "Volkswagen","Golf",        2017, 8500),
    ("compacte", "Ford",      "Focus",       2013, 3800),
    ("compacte", "Ford",      "Focus",       2017, 6500),
    ("compacte", "Toyota",    "Auris",       2014, 4200),
    ("compacte", "Hyundai",   "i30",         2015, 4500),
    ("compacte", "Kia",       "Ceed",        2016, 4800),
    ("compacte", "Seat",      "Leon",        2014, 4300),
    ("compacte", "Seat",      "Leon",        2018, 7000),
    ("compacte", "Opel",      "Astra",       2014, 4000),
    ("compacte", "Opel",      "Astra",       2018, 6800),

    # ── SUV compact ─────────────────────────────────────────────────────────
    ("suv-compact", "Renault",  "Captur",       2014, 5500),
    ("suv-compact", "Renault",  "Captur",       2018, 9000),
    ("suv-compact", "Peugeot",  "2008",         2014, 5800),
    ("suv-compact", "Peugeot",  "2008",         2019, 10500),
    ("suv-compact", "Citroen",  "C3 Aircross",  2018, 8500),
    ("suv-compact", "Dacia",    "Duster",       2013, 4500),
    ("suv-compact", "Dacia",    "Duster",       2018, 8000),
    ("suv-compact", "Nissan",   "Juke",         2013, 5000),
    ("suv-compact", "Nissan",   "Juke",         2017, 8500),
    ("suv-compact", "Kia",      "Stonic",       2018, 9000),
    ("suv-compact", "Hyundai",  "Kona",         2018, 9500),
    ("suv-compact", "Ford",     "Puma",         2020, 12000),

    # ── Break ───────────────────────────────────────────────────────────────
    ("break", "Peugeot",   "308 SW",          2014, 5000),
    ("break", "Peugeot",   "308 SW",          2018, 8000),
    ("break", "Renault",   "Megane Estate",   2013, 4200),
    ("break", "Renault",   "Megane Estate",   2017, 7000),
    ("break", "Volkswagen","Golf Variant",    2014, 6000),
    ("break", "Ford",      "Focus Estate",    2014, 4500),
    ("break", "Opel",      "Astra Sports Tourer", 2015, 5200),
    ("break", "Skoda",     "Octavia Combi",   2015, 6500),

    # ── Velo ────────────────────────────────────────────────────────────────
    ("velo", "Giant",      "Escape 3",        2018, 350),
    ("velo", "Giant",      "Escape 3",        2021, 480),
    ("velo", "Trek",       "FX 3",            2019, 420),
    ("velo", "Trek",       "FX 3",            2021, 550),
    ("velo", "Cannondale", "Quick 4",         2019, 390),
    ("velo", "Decathlon",  "Rockrider 340",   2018, 180),
    ("velo", "Decathlon",  "Rockrider 520",   2020, 280),
    ("velo", "Scott",      "Aspect 50",       2019, 320),
    ("velo", "Specialized","Crossroads 2",    2020, 440),
    ("velo", "Btwin",      "Riverside 500",   2020, 260),
    ("velo", "Cube",       "Nature Pro",      2019, 380),
    ("velo", "Orbea",      "Vector 30",       2020, 450),

    # ── Moto legere ─────────────────────────────────────────────────────────
    ("moto-legere", "Yamaha",   "MT-07",      2016, 4800),
    ("moto-legere", "Yamaha",   "MT-07",      2019, 6500),
    ("moto-legere", "Honda",    "CB500F",     2015, 3800),
    ("moto-legere", "Honda",    "CB500F",     2019, 5500),
    ("moto-legere", "Kawasaki", "Z650",       2017, 5200),
    ("moto-legere", "Kawasaki", "Z400",       2019, 4500),
    ("moto-legere", "Suzuki",   "SV650",      2017, 4900),
    ("moto-legere", "Royal Enfield", "Meteor 350", 2021, 5500),

    # ── Scooter ─────────────────────────────────────────────────────────────
    ("scooter", "Yamaha",  "Aerox 50",        2016, 950),
    ("scooter", "Yamaha",  "NMAX 125",        2019, 2800),
    ("scooter", "Honda",   "PCX 125",         2018, 2500),
    ("scooter", "Piaggio", "Vespa Primavera", 2017, 2200),
    ("scooter", "Kymco",   "Agility 125",     2016, 1400),
    ("scooter", "Peugeot", "Django 125",      2018, 1900),

    # ── Trottinette ─────────────────────────────────────────────────────────
    ("trottinette", "Xiaomi",  "Mi Electric Scooter 3", 2021, 280),
    ("trottinette", "Xiaomi",  "Mi Pro 2",              2020, 380),
    ("trottinette", "Segway",  "Ninebot Max G30",       2021, 550),
    ("trottinette", "Kaabo",   "Mantis 10",             2021, 850),
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
