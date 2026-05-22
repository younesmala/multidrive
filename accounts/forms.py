from django import forms
from django.contrib.auth.forms import AuthenticationForm
from django.contrib.auth.forms import UserCreationForm
from django.contrib.auth.models import User

from .models import AccountDeletionRequest


class RegisterForm(UserCreationForm):
    email = forms.EmailField(required=True)

    class Meta:
        model = User
        fields = ["username", "email", "password1", "password2"]


class AccountLoginForm(AuthenticationForm):
    def confirm_login_allowed(self, user):
        account_status = getattr(user, "account_status", None)
        if account_status and account_status.is_deleted:
            if account_status.deletion_reason_type == account_status.REASON_ADMIN_BLOCK:
                raise forms.ValidationError(
                    "Ce compte a ete desactive suite a une activite non conforme aux regles de la plateforme.",
                    code="account_blocked",
                )
            raise forms.ValidationError(
                "Ce compte a ete desactive suite a une demande de suppression.",
                code="account_deleted",
            )
        if not user.is_active:
            raise forms.ValidationError(
                "Ce compte est desactive.",
                code="inactive",
            )


class AccountDeletionRequestForm(forms.ModelForm):
    confirm_deletion = forms.BooleanField(
        required=True,
        label="Je confirme vouloir desactiver mon compte",
    )

    class Meta:
        model = AccountDeletionRequest
        fields = ["reason"]
        widgets = {
            "reason": forms.Textarea(
                attrs={
                    "rows": 4,
                    "placeholder": "Raison facultative de votre demande.",
                }
            )
        }
        labels = {
            "reason": "Raison (optionnelle)",
        }
