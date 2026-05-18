from django import forms

from .models import Review


class ReviewForm(forms.ModelForm):
    class Meta:
        model = Review
        fields = ["rating", "comment"]
        widgets = {
            "rating": forms.Select(
                choices=[(5, "5/5"), (4, "4/5"), (3, "3/5"), (2, "2/5"), (1, "1/5")]
            ),
            "comment": forms.Textarea(
                attrs={
                    "rows": 5,
                    "placeholder": "Partagez votre avis sur ce vehicule.",
                }
            ),
        }
        labels = {
            "rating": "Note",
            "comment": "Commentaire",
        }
