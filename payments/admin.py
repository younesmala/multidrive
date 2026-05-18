from django.contrib import admin

from .models import Invoice, Payment


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = (
        "id",
        "reservation",
        "amount",
        "status",
        "payment_method",
        "paid_at",
        "created_at",
    )
    list_filter = ("status", "payment_method", "created_at")
    search_fields = (
        "transaction_reference",
        "reservation__user__username",
        "reservation__vehicle__title",
    )
    ordering = ("-created_at",)


@admin.register(Invoice)
class InvoiceAdmin(admin.ModelAdmin):
    list_display = ("invoice_number", "payment", "total_amount", "vat_amount", "issued_at")
    list_filter = ("issued_at",)
    search_fields = ("invoice_number", "payment__transaction_reference")
    ordering = ("-issued_at",)
