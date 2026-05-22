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

    def save_model(self, request, obj, form, change):
        previous_values = None
        if change and obj.pk:
            previous = Payment.objects.get(pk=obj.pk)
            previous_values = (
                previous.status,
                previous.payment_method,
                previous.transaction_reference,
                previous.paid_at,
                previous.amount,
            )

        current_values = (
            obj.status,
            obj.payment_method,
            obj.transaction_reference,
            obj.paid_at,
            obj.amount,
        )

        if change and previous_values != current_values:
            obj.user_status_read = False

        super().save_model(request, obj, form, change)


@admin.register(Invoice)
class InvoiceAdmin(admin.ModelAdmin):
    list_display = ("invoice_number", "payment", "total_amount", "vat_amount", "issued_at")
    list_filter = ("issued_at",)
    search_fields = ("invoice_number", "payment__transaction_reference")
    ordering = ("-issued_at",)
