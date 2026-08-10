from django import forms
from django.utils.translation import gettext_lazy as _

from .models import ContactMessage


class ContactMessageForm(forms.ModelForm):
    class Meta:
        model = ContactMessage
        fields = ["full_name", "email", "phone", "subject", "message"]
        widgets = {
            "message": forms.Textarea(
                attrs={
                    "rows": 5,
                    "placeholder": _("Expliquez votre demande, votre question ou votre besoin de rendez-vous."),
                }
            )
        }
        labels = {
            "full_name": _("Nom complet"),
            "email": _("Adresse email"),
            "phone": _("Telephone"),
            "subject": _("Sujet"),
            "message": _("Message"),
        }
