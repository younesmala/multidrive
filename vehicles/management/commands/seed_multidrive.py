from datetime import timedelta
from decimal import Decimal
import json
import random
import shutil
import time
import urllib.parse
import urllib.request
from pathlib import Path

from django.conf import settings
from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from django.db import transaction
from django.utils import timezone

from contact.models import ContactMessage
from payments.models import Invoice, Payment
from reservations.models import Reservation
from vehicles.models import Vehicle, VehicleCategory, VehicleImage

try:
    from PIL import Image, ImageDraw, ImageFont
    PILLOW_AVAILABLE = True
except ImportError:
    PILLOW_AVAILABLE = False


VEHICLE_WIKIPEDIA_MAP_2 = {
    ("Decathlon", "Rockrider 340"): "Bicycle",
    ("Btwin", "Original 500"): "Mountain_bike",
    ("Trek", "FX 1"): "Road_bicycle",
    ("Giant", "Escape 3"): "City_bicycle",
    ("Nakamura", "Cliff Lite"): "Road_bicycle",
    ("Xiaomi", "Mi Electric Scooter"): "Electric_kick_scooter",
    ("Ninebot", "ES2"): "Electric_kick_scooter",
    ("Wispeed", "T850"): "Electric_kick_scooter",
    ("Oxelo", "Town 7"): "Electric_kick_scooter",
    ("Peugeot", "Kisbee 50"): "Piaggio_Zip",
    ("Yamaha", "Aerox 50"): "Motor_scooter",
    ("Piaggio", "Zip 50"): "Motor_scooter",
    ("Kymco", "Agility 50"): "Motor_scooter",
    ("Honda", "CBF 125"): "Yamaha_YBR125",
    ("Yamaha", "YBR 125"): "Honda_CBF125",
    ("Mash", "Seventy 125"): "Cafe_racer",
    ("Peugeot", "206"): "Renault_Clio",
    ("Renault", "Clio"): "Peugeot_206",
    ("Citroen", "C3"): "Toyota_Yaris",
    ("Fiat", "Panda"): "Citroen_C3",
    ("Toyota", "Yaris"): "Supermini_car",
    ("Opel", "Astra"): "Volkswagen_Golf",
    ("Ford", "Focus"): "Opel_Astra",
    ("Volkswagen", "Golf"): "Ford_Focus",
    ("Peugeot", "307 SW"): "Renault_Megane",
    ("Renault", "Megane Estate"): "Peugeot_307",
    ("Citroen", "Berlingo"): "Renault_Kangoo",
    ("Renault", "Kangoo"): "Citroen_Berlingo",
    ("Renault", "Scenic"): "Dacia_Duster",
    ("Dacia", "Duster"): "Renault_Scenic",
}

VEHICLE_WIKIPEDIA_MAP = {
    ("Decathlon", "Rockrider 340"): "Mountain_bike",
    ("Btwin", "Original 500"): "Bicycle",
    ("Trek", "FX 1"): "City_bicycle",
    ("Giant", "Escape 3"): "Road_bicycle",
    ("Nakamura", "Cliff Lite"): "Mountain_bike",
    ("Xiaomi", "Mi Electric Scooter"): "Electric_kick_scooter",
    ("Ninebot", "ES2"): "Electric_kick_scooter",
    ("Wispeed", "T850"): "Electric_kick_scooter",
    ("Oxelo", "Town 7"): "Kick_scooter",
    ("Peugeot", "Kisbee 50"): "Motor_scooter",
    ("Yamaha", "Aerox 50"): "Motor_scooter",
    ("Piaggio", "Zip 50"): "Piaggio_Zip",
    ("Kymco", "Agility 50"): "Motor_scooter",
    ("Honda", "CBF 125"): "Honda_CBF125",
    ("Yamaha", "YBR 125"): "Yamaha_YBR125",
    ("Mash", "Seventy 125"): "Cafe_racer",
    ("Peugeot", "206"): "Peugeot_206",
    ("Renault", "Clio"): "Renault_Clio",
    ("Citroen", "C3"): "Citroen_C3",
    ("Fiat", "Panda"): "Supermini_car",
    ("Toyota", "Yaris"): "Toyota_Yaris",
    ("Opel", "Astra"): "Opel_Astra",
    ("Ford", "Focus"): "Ford_Focus",
    ("Volkswagen", "Golf"): "Volkswagen_Golf",
    ("Peugeot", "307 SW"): "Peugeot_307",
    ("Renault", "Megane Estate"): "Renault_Megane",
    ("Citroen", "Berlingo"): "Citroen_Berlingo",
    ("Renault", "Kangoo"): "Renault_Kangoo",
    ("Renault", "Scenic"): "Renault_Scenic",
    ("Dacia", "Duster"): "Dacia_Duster",
}

CATEGORY_COLORS = {
    "velo": (34, 139, 34),
    "trottinette": (0, 119, 190),
    "scooter": (200, 100, 0),
    "moto-legere": (128, 0, 128),
    "citadine": (30, 58, 138),
    "compacte": (25, 100, 160),
    "break": (0, 100, 80),
    "utilitaire-leger": (140, 70, 0),
    "monospace": (70, 50, 160),
    "suv-compact": (100, 50, 20),
}


class Command(BaseCommand):
    help = "Create realistic test data for the MultiDrive database."

    def handle(self, *args, **options):
        random.seed(42)

        with transaction.atomic():
            self.clear_existing_data()
            self.clear_model_images()
            categories = self.create_categories()
            users = self.create_users()
            vehicles, vehicle_info = self.create_vehicles(categories)
            self.create_vehicle_images(vehicles, vehicle_info)
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
        vehicle_info = {}
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
            vehicle_info[vehicle.id] = {
                "brand": brand,
                "model": model,
                "category_slug": slug,
            }
        return vehicles, vehicle_info

    def clear_model_images(self):
        models_dir = Path(settings.MEDIA_ROOT) / "vehicles" / "models"
        if models_dir.exists():
            shutil.rmtree(str(models_dir))
        models_dir.mkdir(parents=True, exist_ok=True)

    def _model_slug(self, brand, model):
        raw = f"{brand}-{model}".lower()
        for char, rep in {" ": "-", "é": "e", "è": "e", "ê": "e", "à": "a", "â": "a", "ô": "o", "û": "u", "ç": "c"}.items():
            raw = raw.replace(char, rep)
        return raw

    def _download_wikipedia_image(self, wikipedia_title, dest_path):
        import io

        for attempt in range(3):
            try:
                if attempt > 0:
                    time.sleep(1.0)
                encoded = urllib.parse.quote(wikipedia_title, safe="")
                api_url = f"https://en.wikipedia.org/api/rest_v1/page/summary/{encoded}"
                req = urllib.request.Request(
                    api_url,
                    headers={"User-Agent": "MultiDrive-TFE/1.0 (student educational project)"},
                )
                with urllib.request.urlopen(req, timeout=15) as resp:
                    data = json.loads(resp.read().decode("utf-8"))
                thumb_src = data.get("thumbnail", {}).get("source", "")
                if not thumb_src:
                    return False
                parsed_path = urllib.parse.urlparse(thumb_src).path.lower()
                if not any(parsed_path.endswith(ext) for ext in (".jpg", ".jpeg", ".png", ".webp")):
                    return False
                img_req = urllib.request.Request(
                    thumb_src,
                    headers={"User-Agent": "MultiDrive-TFE/1.0 (student educational project)"},
                )
                with urllib.request.urlopen(img_req, timeout=20) as img_resp:
                    raw = img_resp.read()
                if not PILLOW_AVAILABLE:
                    dest_path.write_bytes(raw)
                    return True
                img = Image.open(io.BytesIO(raw)).convert("RGB")
                img.save(str(dest_path), "JPEG", quality=88)
                img.close()
                return True
            except Exception:
                continue
        return False

    def _safe_copy(self, src, dest, retries=5):
        for i in range(retries):
            try:
                shutil.copy2(str(src), str(dest))
                return
            except PermissionError:
                time.sleep(0.3 * (i + 1))

    def _generate_placeholder_image(self, dest_path, brand, model, category_slug):
        if not PILLOW_AVAILABLE:
            return False
        try:
            color = CATEGORY_COLORS.get(category_slug, (30, 58, 138))
            dark = tuple(max(0, c - 60) for c in color)

            img = Image.new("RGB", (800, 533), color=color)
            draw = ImageDraw.Draw(img)
            draw.rectangle([(0, 373), (800, 533)], fill=dark)

            font_large = ImageFont.load_default()
            font_small = ImageFont.load_default()
            try:
                font_large = ImageFont.truetype("arialbd.ttf", 52)
                font_small = ImageFont.truetype("arial.ttf", 32)
            except Exception:
                try:
                    font_large = ImageFont.truetype("DejaVuSans-Bold.ttf", 52)
                    font_small = ImageFont.truetype("DejaVuSans.ttf", 32)
                except Exception:
                    pass

            draw.text((40, 390), brand, fill=(255, 255, 255), font=font_large)
            draw.text((40, 458), model, fill=(200, 220, 255), font=font_small)
            img.save(str(dest_path), "JPEG", quality=88)
            return True
        except Exception:
            return False

    def _get_or_create_model_image(self, brand, model, category_slug):
        models_dir = Path(settings.MEDIA_ROOT) / "vehicles" / "models"
        models_dir.mkdir(parents=True, exist_ok=True)

        slug = self._model_slug(brand, model)
        wikipedia_title = VEHICLE_WIKIPEDIA_MAP.get((brand, model))
        downloaded_paths = []

        article1 = VEHICLE_WIKIPEDIA_MAP.get((brand, model))
        article2 = VEHICLE_WIKIPEDIA_MAP_2.get((brand, model))

        if article1:
            time.sleep(0.5)
            dest1 = models_dir / f"{slug}-1.jpg"
            if self._download_wikipedia_image(article1, dest1):
                downloaded_paths.append(dest1)

        if article2:
            time.sleep(0.8)
            dest2 = models_dir / f"{slug}-2.jpg"
            if self._download_wikipedia_image(article2, dest2):
                downloaded_paths.append(dest2)

        if downloaded_paths:
            self.stdout.write(f"  [image x{len(downloaded_paths)}] {brand} {model}")
        else:
            self.stdout.write(self.style.WARNING(f"  [placeholder] {brand} {model}"))
            dest = models_dir / f"{slug}-1.jpg"
            self._generate_placeholder_image(dest, brand, model, category_slug)
            downloaded_paths = [dest]

        if len(downloaded_paths) == 1:
            dest = models_dir / f"{slug}-2.jpg"
            self._safe_copy(downloaded_paths[0], dest)
            downloaded_paths.append(dest)

        return [f"vehicles/models/{p.name}" for p in downloaded_paths[:2]]

    def create_vehicle_images(self, vehicles, vehicle_info):
        self.stdout.write("Downloading vehicle images from Wikipedia...")
        image_cache = {}
        model_counters = {}

        for vehicle in vehicles:
            info = vehicle_info.get(vehicle.id, {})
            brand = info.get("brand", "Unknown")
            model = info.get("model", "")
            category_slug = info.get("category_slug", "")

            cache_key = (brand, model)
            if cache_key not in image_cache:
                image_cache[cache_key] = self._get_or_create_model_image(brand, model, category_slug)

            paths = image_cache[cache_key]
            counter = model_counters.get(cache_key, 0)
            model_counters[cache_key] = counter + 1

            # Alternate main/secondary for each vehicle of the same model
            if counter % 2 == 0:
                path_main, path_sec = paths[0], paths[1]
            else:
                path_main, path_sec = paths[1], paths[0]

            VehicleImage.objects.create(vehicle=vehicle, image=path_main, is_main=True)
            VehicleImage.objects.create(vehicle=vehicle, image=path_sec, is_main=False)

    def create_reservations(self, users, vehicles):
        messages_list = [
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
                    "message": random.choice(messages_list),
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
