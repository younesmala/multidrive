from django.conf import settings
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models
from django.utils.translation import gettext_lazy as _

from reservations.models import Reservation


class Payment(models.Model):
    STATUS_PENDING = "pending"
    STATUS_PAID = "paid"
    STATUS_FAILED = "failed"
    STATUS_REFUNDED = "refunded"
    STATUS_REFUND_REQUESTED = "refund_requested"

    STATUS_CHOICES = [
        (STATUS_PENDING, _("En attente")),
        (STATUS_PAID, _("Paye")),
        (STATUS_FAILED, _("Echoue")),
        (STATUS_REFUNDED, _("Rembourse")),
        (STATUS_REFUND_REQUESTED, _("Remboursement demande")),
    ]

    reservation = models.OneToOneField(
        Reservation,
        on_delete=models.CASCADE,
        related_name="payment"
    )
    amount = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default=STATUS_PENDING
    )
    payment_method = models.CharField(max_length=50, blank=True, null=True)
    transaction_reference = models.CharField(
        max_length=120,
        unique=True,
        blank=True,
        null=True
    )
    paid_at = models.DateTimeField(blank=True, null=True)
    refund_amount = models.DecimalField(max_digits=10, decimal_places=2, blank=True, null=True)
    refund_note = models.TextField(blank=True, null=True)
    user_status_read = models.BooleanField(default=True)
    admin_notif_read = models.BooleanField(default=True)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        verbose_name = "Payment"
        verbose_name_plural = "Payments"
        indexes = [
            models.Index(fields=["status"]),
            models.Index(fields=["created_at"]),
        ]

    def __str__(self):
        return f"Payment {self.amount} EUR for reservation #{self.reservation.id}"


class Invoice(models.Model):
    payment = models.OneToOneField(
        Payment,
        on_delete=models.CASCADE,
        related_name="invoice"
    )
    invoice_number = models.CharField(max_length=50, unique=True)
    total_amount = models.DecimalField(max_digits=10, decimal_places=2)
    vat_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
    issued_at = models.DateTimeField(auto_now_add=True)
    due_date = models.DateField(blank=True, null=True)
    notes = models.TextField(blank=True, null=True)

    class Meta:
        verbose_name = "Invoice"
        verbose_name_plural = "Invoices"
        indexes = [
            models.Index(fields=["invoice_number"]),
            models.Index(fields=["issued_at"]),
        ]

    def __str__(self):
        return f"Invoice {self.invoice_number}"


class Testimonial(models.Model):
    payment = models.OneToOneField(
        Payment,
        on_delete=models.CASCADE,
        related_name="testimonial"
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="testimonials"
    )
    rating = models.PositiveSmallIntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(5)]
    )
    comment = models.TextField()
    comment_en = models.TextField(blank=True, default="")
    comment_nl = models.TextField(blank=True, default="")
    is_visible = models.BooleanField(default=False)
    is_deleted = models.BooleanField(default=False)
    deleted_at = models.DateTimeField(null=True, blank=True)
    admin_reply = models.TextField(blank=True, default="")
    admin_reply_at = models.DateTimeField(null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Temoignage"
        verbose_name_plural = "Temoignages"
        ordering = ["-created_at"]

    def __str__(self):
        return f"Temoignage de {self.user.username} — paiement #{self.payment.id}"
