from datetime import timedelta
from decimal import Decimal
import random

from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone

from contact.models import ContactMessage
from payments.models import Invoice, Payment
from reservations.models import Reservation
from vehicles.models import Vehicle, VehicleCategory, VehicleImage


class Command(BaseCommand):
    help = "Create realistic test data for the MultiDrive database."

    def handle(self, *args, **options):
        random.seed(42)

        with transaction.atomic():
            self.clear_existing_data()
            categories = self.create_categories()
            users = self.create_users()
            vehicles = self.create_vehicles(categories)
            self.create_vehicle_images(vehicles)
            reservations = self.create_reservations(users, vehicles)
            payments = self.create_payments(reservations)
            self.create_invoices(payments)
            self.create_contact_messages()

        self.stdout.write(self.style.SUCCESS("MultiDrive test data created successfully."))
        self.stdout.write(f"Categories: {VehicleCategory.objects.count()}")
        self.stdout.write(f"Vehicles: {Vehicle.objects.count()}")
        self.stdout.write(f"Vehicle images: {VehicleImage.objects.count()}")
        self.stdout.write(f"Users: {get_user_model().objects.count()}")
        self.stdout.write(f"Reservations: {Reservation.objects.count()}")
        self.stdout.write(f"Payments: {Payment.objects.count()}")
        self.stdout.write(f"Invoices: {Invoice.objects.count()}")
        self.stdout.write(f"Contact messages: {ContactMessage.objects.count()}")

    def clear_existing_data(self):
        User = get_user_model()
        Invoice.objects.all().delete()
        Payment.objects.all().delete()
        Reservation.objects.all().delete()
        ContactMessage.objects.all().delete()
        VehicleImage.objects.all().delete()
        Vehicle.objects.all().delete()
        VehicleCategory.objects.all().delete()
        User.objects.filter(is_superuser=False).delete()

    def create_categories(self):
        data = [
            ("Velo", "velo", "Velos d'occasion pour trajets quotidiens ou loisirs."),
            ("Trottinette", "trottinette", "Trottinettes classiques et electriques d'occasion."),
            ("Scooter", "scooter", "Scooters abordables pour la ville."),
            ("Moto legere", "moto-legere", "Petites motos et 50cc d'occasion."),
            ("Citadine", "citadine", "Petites voitures economiques pour la ville."),
            ("Compacte", "compacte", "Voitures pratiques pour tous les jours."),
            ("Break", "break", "Vehicules avec plus de coffre."),
            ("Utilitaire leger", "utilitaire-leger", "Petits utilitaires pour livraison ou travaux."),
            ("Monospace", "monospace", "Vehicules familiaux abordables."),
            ("SUV compact", "suv-compact", "Petits SUV d'occasion accessibles."),
        ]

        categories = []
        for name, slug, description in data:
            category, _ = VehicleCategory.objects.update_or_create(
                slug=slug,
                defaults={"name": name, "description": description},
            )
            categories.append(category)
        return categories

    def create_users(self):
        User = get_user_model()
        first_names = [
            "adam", "sarah", "mehdi", "lina", "nicolas", "emma", "yanis",
            "julie", "thomas", "ines", "samir", "lucie", "maxime", "nora",
            "quentin", "amina", "hugo", "lea", "karim", "clara", "sofiane",
            "camille", "ilias", "zoe", "mathis", "mila", "ilyes", "eva",
            "arthur", "sana", "noah", "jade", "enzo", "mariam", "liam",
            "inesa", "louis", "maya", "ayoub", "anna",
        ]

        users = []
        for index in range(1, 121):
            name = first_names[(index - 1) % len(first_names)]
            username = f"client_{name}_{index:03d}"
            user, created = User.objects.get_or_create(
                username=username,
                defaults={
                    "email": f"{username}@example.com",
                    "first_name": name.capitalize(),
                    "last_name": f"Client{index}",
                },
            )
            if created:
                user.set_password("client1234")
                user.save()
            users.append(user)
        return users

    def create_vehicles(self, categories):
        category_by_slug = {category.slug: category for category in categories}
        catalog = [
            ("velo", "Decathlon", "Rockrider 340", 2016, 70, 180, "velo musculaire", 0),
            ("velo", "Btwin", "Original 500", 2018, 90, 220, "velo de ville", 0),
            ("velo", "Trek", "FX 1", 2017, 140, 350, "velo fitness", 0),
            ("velo", "Giant", "Escape 3", 2019, 160, 420, "velo polyvalent", 0),
            ("velo", "Nakamura", "Cliff Lite", 2020, 120, 300, "VTT", 0),
            ("trottinette", "Xiaomi", "Mi Electric Scooter", 2019, 130, 320, "trottinette electrique", 1200),
            ("trottinette", "Ninebot", "ES2", 2018, 160, 380, "trottinette electrique", 1800),
            ("trottinette", "Wispeed", "T850", 2021, 180, 450, "trottinette electrique", 900),
            ("trottinette", "Oxelo", "Town 7", 2017, 45, 120, "trottinette classique", 0),
            ("scooter", "Peugeot", "Kisbee 50", 2013, 550, 1200, "scooter 50cc essence", 18500),
            ("scooter", "Yamaha", "Aerox 50", 2011, 650, 1400, "scooter 50cc essence", 22000),
            ("scooter", "Piaggio", "Zip 50", 2014, 500, 1150, "scooter 50cc essence", 16000),
            ("scooter", "Kymco", "Agility 50", 2015, 600, 1300, "scooter 50cc essence", 14000),
            ("moto-legere", "Honda", "CBF 125", 2010, 900, 1900, "moto 125cc essence", 32000),
            ("moto-legere", "Yamaha", "YBR 125", 2012, 850, 1800, "moto 125cc essence", 28000),
            ("moto-legere", "Mash", "Seventy 125", 2016, 950, 2200, "moto 125cc essence", 17000),
            ("citadine", "Peugeot", "206", 2005, 900, 1900, "citadine essence", 145000),
            ("citadine", "Renault", "Clio", 2007, 1000, 2300, "citadine diesel", 155000),
            ("citadine", "Citroen", "C3", 2008, 1100, 2400, "citadine essence", 138000),
            ("citadine", "Fiat", "Panda", 2009, 950, 2200, "citadine essence", 125000),
            ("citadine", "Toyota", "Yaris", 2006, 1200, 2450, "citadine essence", 160000),
            ("compacte", "Opel", "Astra", 2008, 1300, 2450, "compacte diesel", 175000),
            ("compacte", "Ford", "Focus", 2007, 1150, 2350, "compacte essence", 168000),
            ("compacte", "Volkswagen", "Golf", 2005, 1400, 2500, "compacte diesel", 210000),
            ("break", "Peugeot", "307 SW", 2006, 1300, 2450, "break diesel", 190000),
            ("break", "Renault", "Megane Estate", 2008, 1350, 2500, "break diesel", 185000),
            ("utilitaire-leger", "Citroen", "Berlingo", 2005, 1500, 2500, "utilitaire diesel", 220000),
            ("utilitaire-leger", "Renault", "Kangoo", 2006, 1450, 2450, "utilitaire diesel", 205000),
            ("monospace", "Renault", "Scenic", 2007, 1300, 2400, "monospace diesel", 195000),
            ("suv-compact", "Dacia", "Duster", 2011, 1900, 2500, "SUV compact essence", 185000),
        ]
        statuses = [Vehicle.STATUS_AVAILABLE, Vehicle.STATUS_RESERVED, Vehicle.STATUS_SOLD]

        vehicles = []
        for index in range(150):
            slug, brand, model, base_year, min_price, max_price, vehicle_type, base_mileage = catalog[index % len(catalog)]
            year = base_year + random.randint(0, 3)
            price = Decimal(random.randrange(min_price, max_price + 1, 10))
            mileage = base_mileage + random.randrange(0, 55000, 2500) if base_mileage else 0
            title = f"{brand} {model} {year} #{index + 1:03d}"
            category = category_by_slug[slug]
            description = (
                f"{brand} {model} d'occasion, type {vehicle_type}, "
                f"prix accessible pour MultiDrive."
            )
            if mileage:
                description += f" Kilometrage indicatif: {mileage} km."

            vehicle, _ = Vehicle.objects.update_or_create(
                title=title,
                defaults={
                    "category": category,
                    "description": description,
                    "price": price,
                    "status": statuses[index % len(statuses)],
                },
            )
            vehicles.append(vehicle)
        return vehicles

    def create_vehicle_images(self, vehicles):
        for vehicle in vehicles:
            slug = vehicle.title.lower().replace(" ", "-")
            for image_number in range(1, 3):
                VehicleImage.objects.update_or_create(
                    vehicle=vehicle,
                    image=f"vehicles/demo/{slug}-{image_number}.jpg",
                    defaults={"is_main": image_number == 1},
                )

    def create_reservations(self, users, vehicles):
        messages = [
            "Je souhaite venir voir le vehicule cette semaine.",
            "Le prix est-il negociable ?",
            "Je suis interesse pour une visite rapide.",
            "Pouvez-vous confirmer que le vehicule est disponible ?",
        ]

        reservations = []
        reservable_vehicles = vehicles[:150]
        for index, vehicle in enumerate(reservable_vehicles, start=1):
            user = users[index % len(users)]
            if index <= 55:
                status = Reservation.STATUS_ACCEPTED
            elif index <= 110:
                status = Reservation.STATUS_DEPOSIT_PAID
            elif index <= 130:
                status = Reservation.STATUS_PENDING
            else:
                status = Reservation.STATUS_REJECTED
            reservation, _ = Reservation.objects.update_or_create(
                user=user,
                vehicle=vehicle,
                defaults={
                    "status": status,
                    "message": random.choice(messages),
                    "appointment_date": timezone.now() + timedelta(days=random.randint(1, 21)),
                },
            )
            reservations.append(reservation)
        return reservations

    def create_payments(self, reservations):
        payment_methods = ["bank_transfer", "cash", "card"]
        payments = []

        eligible_reservations = [
            reservation
            for reservation in reservations
            if reservation.status in [Reservation.STATUS_ACCEPTED, Reservation.STATUS_DEPOSIT_PAID]
        ][:110]

        for index, reservation in enumerate(eligible_reservations, start=1):
            amount = reservation.vehicle.price * Decimal("0.20")
            amount = max(Decimal("20.00"), min(amount, Decimal("250.00")))
            amount = amount.quantize(Decimal("0.01"))
            payment, _ = Payment.objects.update_or_create(
                reservation=reservation,
                defaults={
                    "amount": amount,
                    "status": Payment.STATUS_PAID,
                    "payment_method": random.choice(payment_methods),
                    "transaction_reference": f"MD-PAY-{index:04d}",
                    "paid_at": timezone.now() - timedelta(days=random.randint(0, 20)),
                },
            )
            payments.append(payment)
        return payments

    def create_invoices(self, payments):
        for index, payment in enumerate(payments[:105], start=1):
            Invoice.objects.update_or_create(
                payment=payment,
                defaults={
                    "invoice_number": f"MD-INV-2026-{index:04d}",
                    "total_amount": payment.amount,
                    "vat_amount": Decimal("0.00"),
                    "due_date": timezone.now().date() + timedelta(days=14),
                    "notes": "Facture d'acompte pour reservation de vehicule d'occasion.",
                },
            )

    def create_contact_messages(self):
        subjects = [
            "Disponibilite vehicule",
            "Demande de reprise",
            "Question financement",
            "Visite du showroom",
            "Informations controle technique",
        ]
        first_names = [
            "Jean", "Sophie", "Lucas", "Nadia", "Marc", "Camille", "Youssef",
            "Laura", "Tom", "Sarah", "Amine", "Eva", "Noah", "Chloe",
            "Romain", "Mina", "Alexandre", "Elisa", "Mehdi", "Julie",
        ]
        last_names = [
            "Martin", "Bernard", "Dubois", "Leroy", "Lambert", "Moreau",
            "Benali", "Simon", "Petit", "Laurent", "Garcia", "Robert",
        ]

        for index in range(1, 121):
            full_name = f"{first_names[index % len(first_names)]} {last_names[index % len(last_names)]}"
            email_name = full_name.lower().replace(" ", ".")
            ContactMessage.objects.update_or_create(
                email=f"{email_name}.{index:03d}@example.com",
                subject=subjects[index % len(subjects)],
                defaults={
                    "full_name": full_name,
                    "phone": f"0470{index:06d}",
                    "message": "Bonjour, je souhaite recevoir plus d'informations.",
                    "is_read": index % 3 == 0,
                },
            )
