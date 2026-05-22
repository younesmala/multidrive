from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import LoginView
from django.db import transaction
from django.shortcuts import redirect, render
from django.utils import timezone

from payments.models import Payment
from reservations.models import Reservation

from .forms import AccountDeletionRequestForm, AccountLoginForm, RegisterForm
from .models import AccountDeletionRequest, AccountStatus


class AccountLoginView(LoginView):
    authentication_form = AccountLoginForm
    template_name = "accounts/login.html"
    redirect_authenticated_user = True


def register(request):
    if request.user.is_authenticated:
        return redirect("home")

    if request.method == "POST":
        form = RegisterForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.email = form.cleaned_data["email"]
            user.save()
            login(request, user)
            return redirect("home")
    else:
        form = RegisterForm()

    return render(request, "accounts/register.html", {"form": form})


def logout_view(request):
    logout(request)
    return redirect("home")


@login_required
def profile(request):
    reservations = Reservation.objects.filter(user=request.user)
    payments = Payment.objects.filter(reservation__user=request.user)
    account_status, _ = AccountStatus.objects.get_or_create(user=request.user)

    context = {
        "reservation_count": reservations.count(),
        "payment_count": payments.count(),
        "paid_payment_count": payments.filter(status=Payment.STATUS_PAID).count(),
        "account_status": account_status,
    }
    return render(request, "accounts/profile.html", context)


@login_required
def payment_list(request):
    payments = (
        Payment.objects.select_related("reservation", "reservation__vehicle")
        .filter(reservation__user=request.user)
        .order_by("-created_at")
    )
    return render(request, "accounts/payment_list.html", {"payments": payments})


@login_required
def delete_request(request):
    account_status, _ = AccountStatus.objects.get_or_create(user=request.user)

    if account_status.is_deleted:
        return render(
            request,
            "accounts/delete_request_done.html",
            {"account_status": account_status},
        )

    if request.method == "POST":
        form = AccountDeletionRequestForm(request.POST)
        if form.is_valid():
            with transaction.atomic():
                deletion_request = form.save(commit=False)
                deletion_request.user = request.user
                deletion_request.save()

                account_status.is_deleted = True
                account_status.deleted_at = timezone.now()
                account_status.deletion_label = f"id_{request.user.id}_DELETE"
                account_status.deletion_reason_type = AccountStatus.REASON_USER_REQUEST
                account_status.admin_note = ""
                account_status.save()

                request.user.is_active = False
                request.user.save(update_fields=["is_active"])

            request.session["deleted_account_label"] = account_status.deletion_label
            request.session["deleted_account_date"] = account_status.deleted_at.strftime("%d/%m/%Y %H:%M")
            logout(request)
            return redirect("accounts:delete_request_done")
    else:
        form = AccountDeletionRequestForm()

    return render(request, "accounts/delete_request.html", {"form": form})


def delete_request_done(request):
    account_status = None
    if request.user.is_authenticated:
        account_status = getattr(request.user, "account_status", None)
    deletion_label = request.session.pop("deleted_account_label", None)
    deletion_date = request.session.pop("deleted_account_date", None)

    return render(
        request,
        "accounts/delete_request_done.html",
        {
            "account_status": account_status,
            "deletion_label": deletion_label,
            "deletion_date": deletion_date,
        },
    )
