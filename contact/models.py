from django.conf import settings
from django.db import models


class ContactMessage(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.SET_NULL,
        related_name="contact_messages",
        blank=True,
        null=True,
    )
    full_name = models.CharField(max_length=120)
    email = models.EmailField()
    phone = models.CharField(max_length=30, blank=True, null=True)
    subject = models.CharField(max_length=150)
    message = models.TextField()
    admin_response = models.TextField(blank=True)
    is_read = models.BooleanField(default=False)
    user_response_read = models.BooleanField(default=True)
    responded_at = models.DateTimeField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Contact message"
        verbose_name_plural = "Contact messages"
        indexes = [
            models.Index(fields=["email"]),
            models.Index(fields=["is_read"]),
            models.Index(fields=["created_at"]),
        ]

    def __str__(self):
        return f"Message de {self.full_name} - {self.subject}"
