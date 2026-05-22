from django.contrib import admin
from django.utils import timezone

from .models import ContactMessage


@admin.register(ContactMessage)
class ContactMessageAdmin(admin.ModelAdmin):
    list_display = ("full_name", "email", "user", "subject", "is_read", "responded_at", "created_at")
    list_filter = ("is_read", "created_at", "responded_at")
    search_fields = ("full_name", "email", "subject", "message", "admin_response", "user__username")
    ordering = ("-created_at",)

    fieldsets = (
        ("Message client", {
            "fields": ("user", "full_name", "email", "phone", "subject", "message"),
        }),
        ("Traitement admin", {
            "fields": ("is_read", "admin_response", "responded_at"),
        }),
    )

    def save_model(self, request, obj, form, change):
        previous_response = ""
        if change and obj.pk:
            previous_response = (
                ContactMessage.objects.filter(pk=obj.pk)
                .values_list("admin_response", flat=True)
                .first()
                or ""
            )
        if obj.admin_response and obj.responded_at is None:
            obj.responded_at = timezone.now()
        if obj.admin_response:
            obj.is_read = True
        if obj.admin_response and obj.admin_response != previous_response:
            obj.user_response_read = False
        super().save_model(request, obj, form, change)
