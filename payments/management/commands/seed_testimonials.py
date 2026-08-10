import uuid
from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from django.utils import timezone

from payments.models import Payment, Testimonial
from reservations.models import Reservation
from vehicles.models import Vehicle


DATA = [
    (1252, 1968, 5,
     "Super experience du debut a la fin ! La Renault Clio etait exactement comme decrite, tres bien entretenue. Le processus de reservation est simple et clair. Je recommande MultiDrive sans hesitation.",
     "Amazing experience from start to finish! The Renault Clio was exactly as described, very well maintained. The booking process is simple and clear. I recommend MultiDrive without hesitation.",
     "Geweldige ervaring van begin tot eind! De Renault Clio was precies zoals beschreven, zeer goed onderhouden. Het reserveringsproces is eenvoudig en duidelijk. Ik beveel MultiDrive absoluut aan."),
    (1253, 1973, 4,
     "Tres bonne plateforme pour acheter une voiture d occasion. La Peugeot 206 tourne parfaitement. Petit bemol sur les delais de reponse mais tout s est bien passe au final.",
     "Very good platform to buy a used car. The Peugeot 206 runs perfectly. Minor issue with response times but everything went well in the end.",
     "Heel goed platform om een tweedehands auto te kopen. De Peugeot 206 rijdt perfect. Kleine opmerking over de reactietijden maar uiteindelijk is alles goed verlopen."),
    (1254, 1971, 5,
     "Vraiment impressionnant ! La Renault Twingo est en excellent etat, bien mieux que ce a quoi je m attendais pour ce prix. Le suivi du paiement en ligne est tres pratique.",
     "Really impressive! The Renault Twingo is in excellent condition, much better than I expected for this price. The online payment tracking is very convenient.",
     "Echt indrukwekkend! De Renault Twingo is in uitstekende staat, veel beter dan ik verwachtte voor deze prijs. De online betalingsopvolging is heel handig."),
    (1255, 1977, 3,
     "Experience correcte dans l ensemble. La Citroen C2 correspond a la description mais j ai eu quelques difficultes a joindre le support. Le vehicule roule bien, ca reste l essentiel.",
     "Overall decent experience. The Citroen C2 matches the description but I had some difficulty reaching support. The vehicle runs well, which is the main thing.",
     "Over het algemeen een behoorlijke ervaring. De Citroen C2 klopt met de beschrijving maar ik had moeite om de klantenservice te bereiken. Het voertuig rijdt goed, dat is het belangrijkste."),
    (1256, 1974, 5,
     "Achat parfait ! La Peugeot 207 est nickel, propre et bien entretenue. Le site est tres facile a utiliser et toutes les informations sont claires. Je reviendrai sans hesiter pour mon prochain vehicule.",
     "Perfect purchase! The Peugeot 207 is spotless, clean and well maintained. The website is very easy to use and all information is clear. I will return without hesitation for my next vehicle.",
     "Perfecte aankoop! De Peugeot 207 is vlekkeloos, schoon en goed onderhouden. De website is heel gemakkelijk te gebruiken en alle informatie is duidelijk. Ik kom zeker terug voor mijn volgende voertuig."),
    (1257, 1978, 4,
     "Bonne experience globale. La Citroen C3 roule comme une horloge. J aurais aime avoir plus de photos mais le vehicule est a la hauteur. Prix honnete pour la qualite proposee.",
     "Good overall experience. The Citroen C3 runs like clockwork. I would have liked more photos but the vehicle delivers. Honest price for the quality offered.",
     "Goede algemene ervaring. De Citroen C3 rijdt als een klok. Ik had graag meer fotos gehad maar het voertuig stelt niet teleur. Eerlijke prijs voor de aangeboden kwaliteit."),
    (1258, 1972, 2,
     "Decevu par la communication. Le vehicule en lui-meme est correct mais j ai du relancer plusieurs fois pour obtenir des informations. Esperons que ce soit un cas isole.",
     "Disappointed by the communication. The vehicle itself is fine but I had to follow up several times to get information. Hopefully this is an isolated case.",
     "Teleurgesteld door de communicatie. Het voertuig zelf is in orde maar ik moest meerdere keren opvolgen om informatie te krijgen. Hopelijk is dit een uitzonderlijk geval."),
    (1259, 1975, 4,
     "Tres satisfaite de mon achat ! La Peugeot 207 est dans un etat impeccable. Le systeme de paiement en ligne est securise et simple. Je recommande a tous ceux qui cherchent un vehicule fiable.",
     "Very satisfied with my purchase! The Peugeot 207 is in impeccable condition. The online payment system is secure and simple. I recommend it to everyone looking for a reliable vehicle.",
     "Heel tevreden met mijn aankoop! De Peugeot 207 is in onberispelijke staat. Het online betaalsysteem is veilig en eenvoudig. Ik beveel het aan voor iedereen die op zoek is naar een betrouwbaar voertuig."),
]


class Command(BaseCommand):
    help = "Cree des temoignages de demonstration"

    def handle(self, *args, **options):
        User = get_user_model()
        count = 0
        for user_id, vehicle_id, rating, cfr, cen, cnl in DATA:
            try:
                user = User.objects.get(id=user_id)
                vehicle = Vehicle.objects.get(id=vehicle_id)
            except (User.DoesNotExist, Vehicle.DoesNotExist):
                self.stdout.write(self.style.WARNING(f"  SKIP | user#{user_id} ou vehicle#{vehicle_id} introuvable"))
                continue

            reservation = Reservation.objects.create(
                user=user,
                vehicle=vehicle,
                status=Reservation.STATUS_ACCEPTED,
                message="Reservation de demonstration.",
            )
            payment = Payment.objects.create(
                reservation=reservation,
                amount=vehicle.price,
                status=Payment.STATUS_PAID,
                payment_method="card",
                transaction_reference=f"DEMO-{uuid.uuid4().hex[:10].upper()}",
                paid_at=timezone.now(),
            )
            Testimonial.objects.create(
                payment=payment,
                user=user,
                rating=rating,
                comment=cfr,
                comment_en=cen,
                comment_nl=cnl,
                is_visible=True,
            )
            self.stdout.write(self.style.SUCCESS(f"  OK | {user.username} | {vehicle.title} | {rating}*"))
            count += 1

        self.stdout.write(self.style.SUCCESS(f"\n{count} temoignages crees et publies."))
