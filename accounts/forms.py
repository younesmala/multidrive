from django import forms
from django.contrib.auth.forms import AuthenticationForm, UserCreationForm
from django.contrib.auth.models import User

from .models import AccountDeletionRequest


class CreateAdminForm(forms.Form):
    username = forms.CharField(
        max_length=150,
        label="Nom d'utilisateur",
        widget=forms.TextInput(attrs={"placeholder": "ex: jean.dupont"}),
    )
    email = forms.EmailField(
        label="Adresse email",
        widget=forms.EmailInput(attrs={"placeholder": "jean@example.com"}),
    )
    password = forms.CharField(
        label="Mot de passe provisoire",
        widget=forms.PasswordInput(attrs={"placeholder": "Min. 8 caracteres"}),
        min_length=8,
    )
    password_confirm = forms.CharField(
        label="Confirmer le mot de passe",
        widget=forms.PasswordInput(attrs={"placeholder": "Retaper le mot de passe"}),
    )

    def clean_username(self):
        username = self.cleaned_data["username"]
        if User.objects.filter(username=username).exists():
            raise forms.ValidationError("Ce nom d'utilisateur est deja utilise.")
        return username

    def clean_email(self):
        email = self.cleaned_data["email"]
        if User.objects.filter(email=email).exists():
            raise forms.ValidationError("Cette adresse email est deja associee a un compte.")
        return email

    def clean(self):
        cleaned_data = super().clean()
        p1 = cleaned_data.get("password")
        p2 = cleaned_data.get("password_confirm")
        if p1 and p2 and p1 != p2:
            self.add_error("password_confirm", "Les mots de passe ne correspondent pas.")
        return cleaned_data


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
