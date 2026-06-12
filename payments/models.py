from django.db import models

from reservations.models import Reservation


class Payment(models.Model):
    STATUS_PENDING = "pending"
    STATUS_PAID = "paid"
    STATUS_FAILED = "failed"
    STATUS_REFUNDED = "refunded"
    STATUS_REFUND_REQUESTED = "refund_requested"

    STATUS_CHOICES = [
        (STATUS_PENDING, "En attente"),
        (STATUS_PAID, "Paye"),
        (STATUS_FAILED, "Echoue"),
        (STATUS_REFUNDED, "Rembourse"),
        (STATUS_REFUND_REQUESTED, "Remboursement demande"),
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
