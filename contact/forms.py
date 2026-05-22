from django import forms

from .models import ContactMessage


class ContactMessageForm(forms.ModelForm):
    class Meta:
        model = ContactMessage
        fields = ["full_name", "email", "phone", "subject", "message"]
        widgets = {
            "message": forms.Textarea(
                attrs={
                    "rows": 5,
                    "placeholder": "Expliquez votre demande, votre question ou votre besoin de rendez-vous.",
                }
            )
        }
        labels = {
            "full_name": "Nom complet",
            "email": "Adresse email",
            "phone": "Telephone",
            "subject": "Sujet",
            "message": "Message",
        }
