from django.conf import settings
from django.db import models
from django.utils.translation import gettext_lazy as _


class AccountStatus(models.Model):
    REASON_USER_REQUEST = "user_request"
    REASON_ADMIN_BLOCK = "admin_block"

    REASON_CHOICES = [
        (REASON_USER_REQUEST, _("Demande utilisateur")),
        (REASON_ADMIN_BLOCK, _("Blocage administrateur")),
    ]

    user = models.OneToOneField(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="account_status",
    )
    is_deleted = models.BooleanField(default=False)
    deleted_at = models.DateTimeField(blank=True, null=True)
    deletion_label = models.CharField(max_length=80, blank=True)
    deletion_reason_type = models.CharField(
        max_length=20,
        choices=REASON_CHOICES,
        default=REASON_USER_REQUEST,
    )
    admin_note = models.TextField(blank=True)

    class Meta:
        verbose_name = "Account status"
        verbose_name_plural = "Account statuses"

    def __str__(self):
        return f"Statut du compte {self.user.username}"


class AccountDeletionRequest(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="deletion_requests",
    )
    reason = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)
    processed = models.BooleanField(default=False)
    processed_at = models.DateTimeField(blank=True, null=True)

    class Meta:
        verbose_name = "Account deletion request"
        verbose_name_plural = "Account deletion requests"
        ordering = ["-created_at"]

    def __str__(self):
        return f"Suppression demandee par {self.user.username}"
