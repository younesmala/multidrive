from django import forms

from .models import Reservation


class ReservationForm(forms.ModelForm):
    class Meta:
        model = Reservation
        fields = ["message", "appointment_date"]
        widgets = {
            "message": forms.Textarea(
                attrs={
                    "rows": 5,
                    "placeholder": "Expliquez votre demande ou vos disponibilites.",
                }
            ),
            "appointment_date": forms.DateTimeInput(
                attrs={
                    "type": "datetime-local",
                }
            ),
        }
