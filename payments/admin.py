from django.contrib import admin

from .models import Invoice, Payment, Testimonial


@admin.register(Payment)
class PaymentAdmin(admin.ModelAdmin):
    list_display = ("reservation", "amount", "status", "paid_at", "created_at")
    list_filter = ("status",)
    search_fields = ("reservation__user__username", "transaction_reference")
    ordering = ("-created_at",)


@admin.register(Invoice)
class InvoiceAdmin(admin.ModelAdmin):
    list_display = ("invoice_number", "payment", "total_amount", "issued_at")
    search_fields = ("invoice_number",)
    ordering = ("-issued_at",)


@admin.register(Testimonial)
class TestimonialAdmin(admin.ModelAdmin):
    list_display = ("user", "rating", "is_visible", "created_at")
    list_filter = ("is_visible", "rating")
    search_fields = ("user__username", "comment")
    ordering = ("-created_at",)
    actions = ["masquer", "afficher"]
    fieldsets = (
        (None, {
            "fields": ("payment", "user", "rating", "is_visible"),
        }),
        ("Commentaire (FR)", {
            "fields": ("comment",),
        }),
        ("Traduction EN", {
            "fields": ("comment_en",),
            "description": "Laisser vide si pas de traduction anglaise.",
        }),
        ("Traduction NL", {
            "fields": ("comment_nl",),
            "description": "Laisser vide si pas de traduction neerlandaise.",
        }),
    )

    @admin.action(description="Masquer les temoignages selectionnes")
    def masquer(self, request, queryset):
        queryset.update(is_visible=False)

    @admin.action(description="Rendre visibles les temoignages selectionnes")
    def afficher(self, request, queryset):
        queryset.update(is_visible=True)
