from django.conf import settings
from django.db import models

from vehicles.models import Vehicle


class Reservation(models.Model):
    STATUS_PENDING = "pending"
    STATUS_ACCEPTED = "accepted"
    STATUS_REJECTED = "rejected"
    STATUS_DEPOSIT_PAID = "deposit_paid"
    STATUS_CANCELLED = "cancelled"

    STATUS_CHOICES = [
        (STATUS_PENDING, "En attente"),
        (STATUS_ACCEPTED, "Acceptee"),
        (STATUS_REJECTED, "Refusee"),
        (STATUS_DEPOSIT_PAID, "Acompte paye"),
        (STATUS_CANCELLED, "Annulee"),
    ]

    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="reservations"
    )
    vehicle = models.ForeignKey(
        Vehicle,
        on_delete=models.PROTECT,
        related_name="reservations"
    )
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default=STATUS_PENDING
    )
    message = models.TextField(blank=True, null=True)
    appointment_date = models.DateTimeField(blank=True, null=True)
    user_status_read = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "Reservation"
        verbose_name_plural = "Reservations"
        indexes = [
            models.Index(fields=["status"]),
            models.Index(fields=["created_at"]),
        ]

    def __str__(self):
        return f"Reservation de {self.user.username} pour {self.vehicle.title}"
