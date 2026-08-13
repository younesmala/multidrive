from datetime import time as dt_time

from django import forms
from django.utils import timezone

from .models import Reservation

WEEKDAY_HOURS = {
    "week": {"min": dt_time(16, 0), "max": dt_time(21, 30), "label": "16h00 a 21h30"},
    "weekend": {"min": dt_time(9, 0), "max": dt_time(21, 0), "label": "9h00 a 21h00"},
}


class ReservationForm(forms.ModelForm):
    class Meta:
        model = Reservation
        fields = ["phone", "message", "appointment_date"]
        widgets = {
            "phone": forms.TextInput(
                attrs={
                    "placeholder": "Ex : +32 470 12 34 56",
                    "autocomplete": "tel",
                }
            ),
            "message": forms.Textarea(
                attrs={
                    "rows": 5,
                    "placeholder": "Expliquez votre demande ou vos disponibilites.",
                }
            ),
            "appointment_date": forms.DateTimeInput(
                attrs={
                    "type": "datetime-local",
                    "id": "id_appointment_date",
                }
            ),
        }
        labels = {
            "phone": "Numero de telephone (optionnel)",
        }

    def clean_appointment_date(self):
        appointment_date = self.cleaned_data.get("appointment_date")
        if not appointment_date:
            return appointment_date

        if appointment_date <= timezone.now():
            raise forms.ValidationError(
                "La date de rendez-vous doit etre dans le futur."
            )

        weekday = appointment_date.weekday()
        slot = WEEKDAY_HOURS["weekend"] if weekday >= 5 else WEEKDAY_HOURS["week"]
        appt_time = appointment_date.time()

        if not (slot["min"] <= appt_time <= slot["max"]):
            day_label = "le week-end" if weekday >= 5 else "en semaine"
            raise forms.ValidationError(
                f"Les rendez-vous {day_label} sont acceptes de {slot['label']} uniquement."
            )

        return appointment_date
