"""
Backfill : ajoute un numero de telephone belge a tous les comptes
qui n'en ont pas encore (AccountStatus existants ou a creer).
"""
import random
from django.contrib.auth import get_user_model
from django.core.management.base import BaseCommand
from accounts.models import AccountStatus

PREFIXES = ["470", "471", "472", "473", "474", "475", "476", "477", "478", "479",
            "480", "481", "482", "483", "484", "485", "486", "487", "488", "489",
            "490", "491", "492", "493", "494", "495", "496", "497", "498", "499"]


def _random_be_phone():
    prefix = random.choice(PREFIXES)
    a = random.randint(10, 99)
    b = random.randint(10, 99)
    c = random.randint(10, 99)
    return f"+32 {prefix} {a} {b} {c}"


class Command(BaseCommand):
    help = "Ajoute un numero de telephone belge aux comptes sans numero"

    def handle(self, *args, **options):
        User = get_user_model()
        updated = 0
        created = 0

        for user in User.objects.all():
            status, was_created = AccountStatus.objects.get_or_create(user=user)
            if not status.phone:
                status.phone = _random_be_phone()
                status.save(update_fields=["phone"])
                if was_created:
                    created += 1
                else:
                    updated += 1

        self.stdout.write(self.style.SUCCESS(
            f"Termine : {updated} comptes mis a jour, {created} AccountStatus crees avec telephone."
        ))
