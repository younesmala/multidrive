from django.contrib import admin, messages
from django.contrib.auth.admin import UserAdmin
from django.contrib.auth.models import User
from django.utils import timezone

from .models import AccountDeletionRequest, AccountStatus


@admin.action(description="Desactiver les comptes selectionnes pour abus")
def deactivate_users_for_abuse(modeladmin, request, queryset):
    updated_count = 0

    for user in queryset:
        if user.is_superuser:
            continue

        account_status, _ = AccountStatus.objects.get_or_create(user=user)
        account_status.is_deleted = True
        account_status.deleted_at = timezone.now()
        account_status.deletion_label = f"id_{user.id}_DELETE"
        account_status.deletion_reason_type = AccountStatus.REASON_ADMIN_BLOCK
        account_status.admin_note = (
            "Compte desactive par l'administration suite a un comportement non conforme."
        )
        account_status.save()

        if user.is_active:
            user.is_active = False
            user.save(update_fields=["is_active"])

        updated_count += 1

    if updated_count:
        modeladmin.message_user(
            request,
            f"{updated_count} compte(s) ont ete desactives pour abus.",
            level=messages.SUCCESS,
        )
    else:
        modeladmin.message_user(
            request,
            "Aucun compte n'a ete desactive.",
            level=messages.WARNING,
        )


class MultiDriveUserAdmin(UserAdmin):
    actions = [deactivate_users_for_abuse]
    list_display = UserAdmin.list_display + ("is_active", "is_staff")


try:
    admin.site.unregister(User)
except admin.sites.NotRegistered:
    pass

admin.site.register(User, MultiDriveUserAdmin)


@admin.register(AccountStatus)
class AccountStatusAdmin(admin.ModelAdmin):
    list_display = (
        "user",
        "is_deleted",
        "deletion_reason_type",
        "deletion_label",
        "deleted_at",
    )
    list_filter = ("is_deleted", "deletion_reason_type", "deleted_at")
    search_fields = ("user__username", "deletion_label", "admin_note")


@admin.register(AccountDeletionRequest)
class AccountDeletionRequestAdmin(admin.ModelAdmin):
    list_display = ("user", "created_at", "processed", "processed_at")
    list_filter = ("processed", "created_at")
    search_fields = ("user__username", "reason")
