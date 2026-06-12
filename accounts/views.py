from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth import get_user_model, login, logout, update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth.views import LoginView
from django.db import transaction
from django.db.models import Count, Q, Sum
from django.shortcuts import redirect, render
from django.utils import timezone

from contact.models import ContactMessage
from payments.models import Payment
from reservations.models import Reservation
from vehicles.models import Vehicle

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
        Payment.objects.select_related(
            "reservation",
            "reservation__vehicle",
            "reservation__vehicle__category",
            "invoice",
        )
        .prefetch_related("reservation__vehicle__images")
        .filter(reservation__user=request.user)
        .order_by("-created_at")
    )
    payments.filter(user_status_read=False).update(user_status_read=True)

    paid_amount = payments.filter(status=Payment.STATUS_PAID).aggregate(
        total=Sum("amount")
    )["total"] or 0

    for p in payments:
        p.main_image = (
            p.reservation.vehicle.images.filter(is_main=True).first()
            or p.reservation.vehicle.images.first()
        )

    return render(
        request,
        "accounts/payment_list.html",
        {
            "payments": payments,
            "paid_amount": paid_amount,
            "paid_count": payments.filter(status=Payment.STATUS_PAID).count(),
            "total_count": payments.count(),
        },
    )


@login_required
def change_password(request):
    if request.method == "POST":
        form = PasswordChangeForm(request.user, request.POST)
        if form.is_valid():
            user = form.save()
            update_session_auth_hash(request, user)
            messages.success(request, "Votre mot de passe a bien ete modifie.")
            return redirect("accounts:profile")
        messages.error(request, "Merci de corriger les erreurs ci-dessous.")
    else:
        form = PasswordChangeForm(request.user)

    return render(request, "accounts/change_password.html", {"form": form})


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


@staff_member_required
def admin_dashboard(request):
    User = get_user_model()

    Payment.objects.filter(admin_notif_read=False).update(admin_notif_read=True)

    reservations = Reservation.objects.select_related("user", "vehicle").order_by("-created_at")
    contact_messages = ContactMessage.objects.select_related("user").order_by("-created_at")
    disabled_accounts = (
        AccountStatus.objects.select_related("user")
        .filter(is_deleted=True)
        .order_by("-deleted_at")
    )

    context = {
        "vehicle_count": Vehicle.objects.count(),
        "available_vehicle_count": Vehicle.objects.filter(status=Vehicle.STATUS_AVAILABLE).count(),
        "pending_reservation_count": Reservation.objects.filter(
            status=Reservation.STATUS_PENDING
        ).count(),
        "contact_pending_count": ContactMessage.objects.filter(
            Q(admin_response="") | Q(admin_response__isnull=True)
        ).count(),
        "disabled_account_count": AccountStatus.objects.filter(is_deleted=True).count(),
        "pending_payment_count": Payment.objects.filter(status=Payment.STATUS_PENDING).count(),
        "user_count": User.objects.filter(is_active=True).count(),
        "recent_reservations": reservations[:5],
        "recent_messages": contact_messages[:5],
        "recent_disabled_accounts": disabled_accounts[:5],
        "pending_deletion_requests": AccountDeletionRequest.objects.filter(processed=False).count(),
    }
    return render(request, "accounts/admin_dashboard.html", context)
