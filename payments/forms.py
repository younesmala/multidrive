from django import forms
from django.utils.translation import gettext_lazy as _

from .models import Testimonial


class TestimonialForm(forms.ModelForm):
    class Meta:
        model = Testimonial
        fields = ["rating", "comment"]
        widgets = {
            "rating": forms.Select(
                choices=[(5, "5/5"), (4, "4/5"), (3, "3/5"), (2, "2/5"), (1, "1/5")],
                attrs={"class": "form-select"},
            ),
            "comment": forms.Textarea(
                attrs={"rows": 5, "placeholder": _("Decrivez votre experience d'achat...")}
            ),
        }
        labels = {
            "rating": _("Note"),
            "comment": _("Votre temoignage"),
        }
