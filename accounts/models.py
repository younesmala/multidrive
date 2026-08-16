from datetime import timedelta

from django.conf import settings
from django.db import models
from django.utils import timezone
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
    phone = models.CharField(max_length=20, blank=True, default="")
    is_deleted = models.BooleanField(default=False)
    deleted_at = models.DateTimeField(blank=True, null=True)
    deletion_label = models.CharField(max_length=80, blank=True)
    deletion_reason_type = models.CharField(
        max_length=20,
        choices=REASON_CHOICES,
        default=REASON_USER_REQUEST,
    )
    admin_note = models.TextField(blank=True)
    no_show_count = models.PositiveSmallIntegerField(default=0)
    banned_until = models.DateTimeField(null=True, blank=True)
    bank_iban = models.CharField(max_length=34, blank=True, default="")
    bank_holder = models.CharField(max_length=100, blank=True, default="")
    accepted_cgv = models.BooleanField(default=False)

    @property
    def is_currently_banned(self):
        return self.banned_until is not None and self.banned_until > timezone.now()

    class Meta:
        verbose_name = "Account status"
        verbose_name_plural = "Account statuses"

    def __str__(self):
        return f"Statut du compte {self.user.username}"


class AdminNote(models.Model):
    author = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="admin_notes",
    )
    content = models.TextField()
    created_at = models.DateTimeField(default=timezone.now)

    class Meta:
        verbose_name = "Note admin"
        verbose_name_plural = "Notes admin"
        ordering = ["-created_at"]

    def __str__(self):
        return f"Note de {self.author.username} — {self.created_at.strftime('%d/%m/%Y %H:%M')}"


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
