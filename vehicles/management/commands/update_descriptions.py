"""
update_descriptions
===================
Met a jour les descriptions des vehicules avec des textes varies par categorie.
python manage.py update_descriptions
python manage.py update_descriptions --dry-run
"""

from django.core.management.base import BaseCommand
from vehicles.models import Vehicle

DESCRIPTIONS = {
    "citadine": [
        "Citadine compacte et economique, ideale pour la ville et les petits trajets du quotidien. Entretien suivi, interieur bien conserve.",
        "Pratique et facile a garer, ce vehicule est parfait pour une utilisation quotidienne en milieu urbain. Faible consommation.",
        "Un excellent choix pour un premier vehicule ou un usage urbain. Maniable, sobre et fiable au quotidien.",
        "Petite citadine au gabarit ideal pour la ville. Entretien regulier effectue, prete a rouler sans surprises.",
        "Vehicule economique et polyvalent. Parfait pour les petits budgets qui recherchent fiabilite et praticite.",
    ],
    "compacte": [
        "Compacte polyvalente et confortable, aussi a l'aise en ville que sur route. Entretien regulier, bon etat general.",
        "Un bon compromis entre espace interieur et consommation raisonnable. Vehicule fiable, historique d'entretien disponible.",
        "Habitacle spacieux et conduite agreable. Ideale pour une utilisation familiale ou des trajets mixtes.",
        "Compacte bien equipee et robuste. Elle offre un excellent rapport qualite-prix pour les conducteurs exigeants.",
        "Fiable et econome, cette compacte convient aussi bien aux deplacements professionnels qu'aux sorties en famille.",
    ],
    "suv-compact": [
        "SUV compact offrant confort de conduite et position sureelevee. Polyvalent, robuste, adapte a tous les terrains.",
        "Vehicule pratique et spacieux, ideal pour les familles ou les personnes ayant besoin de volume au quotidien.",
        "Crossover au bon rapport habitabilite-consommation. Entretien a jour, pret pour de nouvelles aventures.",
    ],
    "break": [
        "Break au coffre genereux et habitacle modulable. Parfait pour les familles ou le transport de materiel.",
        "Break pratique et econome, ideal pour les longs trajets ou les deplacements professionnels necessitant de l'espace.",
        "Grande capacite de chargement et confort de conduite. Une valeur sure pour les utilisateurs exigeants.",
    ],
    "moto-legere": [
        "Moto legere et maniable, ideale pour debuter ou pour les trajets urbains quotidiens. Entretien a jour.",
        "125cc homologuee, parfaite pour eviter les embouteillages. Consommation reduite et prise en main facile.",
        "Deux-roues fiable et agreable a conduire. Ideal pour les deplacements quotidiens en ville ou en periurbain.",
        "Moto bien entretenue, accessible avec le permis A1. Parfaite pour allier economie et liberte de deplacement.",
    ],
    "scooter": [
        "Scooter pratique et economique pour les deplacements quotidiens en ville. Facile a prendre en main, entretien simple.",
        "50cc ideal pour les jeunes conducteurs ou les trajets courts. Bon etat general, pret a rouler.",
        "Scooter urbain leger, parfait pour le dernier kilometre ou les courses en ville. Faible cout d'entretien.",
    ],
    "velo": [
        "Velo urbain leger et robuste, ideal pour les trajets domicile-travail. Cadre en bon etat, freins revises.",
        "Mobilite douce et economique. Parfait pour circuler en ville sans se soucier du trafic ni du stationnement.",
        "Velo polyvalent adapte aussi bien a la ville qu'aux chemins de campagne. Bon etat general, peu utilise.",
    ],
    "trottinette": [
        "Trottinette electrique legere et maniable, ideale pour le dernier kilometre ou les courts trajets urbains.",
        "Mobilite electrique accessible et eco-responsable. Autonomie suffisante pour les trajets quotidiens, recharge rapide.",
        "Solution de mobilite urbaine pratique et economique. Pliable, facile a transporter et simple a utiliser.",
    ],
}

DEFAULT_DESCRIPTIONS = [
    "Vehicule en bon etat general, entretien suivi. Une opportunite a saisir pour un achat malin.",
    "Bonne occasion pour les petits budgets. Vehicule fiable, pret a rouler sans mauvaises surprises.",
]


class Command(BaseCommand):
    help = "Met a jour les descriptions des vehicules avec des textes varies par categorie."

    def add_arguments(self, parser):
        parser.add_argument("--dry-run", action="store_true",
                            help="Affiche les changements sans modifier la DB.")

    def handle(self, *args, **options):
        dry = options["dry_run"]
        prefix = "[DRY-RUN] " if dry else ""

        vehicles = Vehicle.objects.select_related("category").order_by("id")
        updated = 0

        for vehicle in vehicles:
            slug = vehicle.category.slug if vehicle.category else ""
            pool = DESCRIPTIONS.get(slug, DEFAULT_DESCRIPTIONS)
            description = pool[vehicle.id % len(pool)]

            self.stdout.write(f"  [{vehicle.id}] {vehicle.title[:40]}")
            self.stdout.write(f"    -> {description[:70]}...")

            if not dry:
                vehicle.description = description
                vehicle.save(update_fields=["description"])
            updated += 1

        self.stdout.write(self.style.SUCCESS(
            f"\n{prefix}{updated} descriptions mises a jour."
        ))
