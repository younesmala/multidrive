import csv
from decimal import Decimal, InvalidOperation

from django.contrib import messages
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth import get_user_model, login, logout, update_session_auth_hash
from django.contrib.auth.decorators import login_required
from django.contrib.auth.forms import PasswordChangeForm
from django.contrib.auth.views import LoginView
from django.db import transaction
from django.db.models import Count, F, Q, Sum
from django.http import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.utils import timezone
from django.views.decorators.http import require_POST

from contact.models import ContactMessage
from payments.models import Payment
from reservations.models import Reservation
from vehicles.models import Review, Vehicle

from .forms import AccountDeletionRequestForm, AccountLoginForm, CreateAdminForm, RegisterForm
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
        p.remaining = p.reservation.vehicle.price - p.amount

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


def _superuser_required(view_func):
    """Decorator: réserve la vue aux superusers uniquement, côté backend."""
    from functools import wraps

    @wraps(view_func)
    def wrapper(request, *args, **kwargs):
        if not request.user.is_authenticated or not request.user.is_superuser:
            from django.http import HttpResponseForbidden
            return HttpResponseForbidden()
        return view_func(request, *args, **kwargs)

    return wrapper


@_superuser_required
def create_admin(request):
    form = CreateAdminForm(request.POST or None)
    if request.method == "POST" and form.is_valid():
        User = get_user_model()
        user = User.objects.create_user(
            username=form.cleaned_data["username"],
            email=form.cleaned_data["email"],
            password=form.cleaned_data["password"],
            is_staff=True,
            is_superuser=False,
            is_active=True,
        )
        messages.success(
            request,
            f"Administrateur « {user.username} » cree. Il peut maintenant se connecter et changer son mot de passe.",
        )
        return redirect("accounts:admin_dashboard")
    User = get_user_model()
    admin_users = User.objects.filter(is_staff=True, is_superuser=False).order_by("username")
    return render(request, "accounts/create_admin.html", {"form": form, "admin_users": admin_users})


@require_POST
@_superuser_required
def demote_admin(request, user_id):
    User = get_user_model()
    target = get_object_or_404(User, id=user_id, is_staff=True, is_superuser=False)
    if target.id == request.user.id:
        messages.error(request, "Vous ne pouvez pas modifier votre propre compte.")
        return redirect("accounts:admin_dashboard")
    target.is_staff = False
    target.save(update_fields=["is_staff"])
    messages.success(request, f"« {target.username} » repasse en compte client.")
    return redirect("accounts:admin_dashboard")


@require_POST
@_superuser_required
def deactivate_admin(request, user_id):
    User = get_user_model()
    target = get_object_or_404(User, id=user_id, is_staff=True, is_superuser=False)
    if target.id == request.user.id:
        messages.error(request, "Vous ne pouvez pas desactiver votre propre compte.")
        return redirect("accounts:admin_dashboard")
    target.is_staff = False
    target.is_active = False
    target.save(update_fields=["is_staff", "is_active"])
    messages.success(request, f"Compte admin « {target.username} » desactive.")
    return redirect("accounts:admin_dashboard")


@staff_member_required
def export_stats_csv(request):
    now = timezone.now()
    filename = f"multidrive_stats_{now.strftime('%Y%m%d_%H%M')}.csv"

    response = HttpResponse(content_type="text/csv; charset=utf-8-sig")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'

    writer = csv.writer(response, delimiter=";")

    # --- Resume financier ---
    paid_qs = Payment.objects.filter(status=Payment.STATUS_PAID)
    total_revenue = paid_qs.aggregate(t=Sum("amount"))["t"] or Decimal("0.00")
    monthly_revenue = paid_qs.filter(
        paid_at__year=now.year, paid_at__month=now.month
    ).aggregate(t=Sum("amount"))["t"] or Decimal("0.00")
    full_paid_qs = paid_qs.filter(amount__gte=F("reservation__vehicle__price"))
    full_payment_count = full_paid_qs.count()
    full_payment_revenue = full_paid_qs.aggregate(t=Sum("amount"))["t"] or Decimal("0.00")
    deposit_only_count = paid_qs.filter(amount__lt=F("reservation__vehicle__price")).count()
    sold_count = Vehicle.objects.filter(status=Vehicle.STATUS_SOLD).count()

    writer.writerow(["MULTIDRIVE — EXPORT STATISTIQUES", now.strftime("%d/%m/%Y %H:%M")])
    writer.writerow([])
    writer.writerow(["RESUME FINANCIER"])
    writer.writerow(["Indicateur", "Valeur"])
    writer.writerow(["Revenus totaux (EUR)", f"{total_revenue:.2f}"])
    writer.writerow([f"Revenus {now.strftime('%B %Y')} (EUR)", f"{monthly_revenue:.2f}"])
    writer.writerow(["Ventes finalisees (paiement integral)", full_payment_count])
    writer.writerow(["Revenus ventes finalisees (EUR)", f"{full_payment_revenue:.2f}"])
    writer.writerow(["Dossiers acompte en cours", deposit_only_count])
    writer.writerow(["Vehicules statut Vendu", sold_count])

    # --- Ventes par categorie ---
    from vehicles.models import VehicleCategory
    top_categories = (
        VehicleCategory.objects.annotate(
            sold=Count("vehicles", filter=Q(vehicles__status=Vehicle.STATUS_SOLD))
        ).filter(sold__gt=0).order_by("-sold")
    )
    writer.writerow([])
    writer.writerow(["VENTES PAR CATEGORIE"])
    writer.writerow(["Categorie", "Vehicules vendus"])
    for cat in top_categories:
        writer.writerow([cat.name, cat.sold])

    # --- Detail des paiements ---
    writer.writerow([])
    writer.writerow(["DETAIL DES PAIEMENTS (paiements encaisses)"])
    writer.writerow(["Date", "Client", "Email", "Vehicule", "Montant (EUR)", "Prix vehicule (EUR)", "Type"])
    payments = (
        paid_qs.select_related("reservation__user", "reservation__vehicle")
        .order_by("-paid_at")
    )
    for p in payments:
        is_full = p.amount >= p.reservation.vehicle.price
        writer.writerow([
            p.paid_at.strftime("%d/%m/%Y %H:%M") if p.paid_at else "",
            p.reservation.user.username,
            p.reservation.user.email,
            p.reservation.vehicle.title,
            f"{p.amount:.2f}",
            f"{p.reservation.vehicle.price:.2f}",
            "Paiement integral" if is_full else "Acompte",
        ])

    return response


@require_POST
@staff_member_required
def delete_review(request, review_id):
    review = get_object_or_404(Review, id=review_id)
    vehicle_title = review.vehicle.title
    review.delete()
    messages.success(request, f"Avis sur {vehicle_title} supprime.")
    return redirect("accounts:admin_dashboard")


@require_POST
@staff_member_required
def process_refund(request, payment_id):
    payment = get_object_or_404(Payment, id=payment_id, status=Payment.STATUS_REFUND_REQUESTED)

    raw = request.POST.get("refund_amount", "").replace(",", ".").strip()
    note = request.POST.get("refund_note", "").strip()

    try:
        refund_amount = Decimal(raw).quantize(Decimal("0.01"))
        if refund_amount < Decimal("0"):
            raise ValueError
    except (InvalidOperation, ValueError):
        messages.error(request, "Montant de remboursement invalide.")
        return redirect("accounts:admin_dashboard")

    payment.refund_amount = refund_amount
    payment.refund_note = note if note else None
    payment.status = Payment.STATUS_REFUNDED
    payment.user_status_read = False
    payment.admin_notif_read = True
    payment.save(update_fields=["refund_amount", "refund_note", "status", "user_status_read", "admin_notif_read", "updated_at"])

    messages.success(
        request,
        f"Remboursement de {refund_amount} EUR enregistre pour {payment.reservation.user.username}.",
    )
    return redirect("accounts:admin_dashboard")


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
    refund_requests = (
        Payment.objects.select_related("reservation", "reservation__user", "reservation__vehicle")
        .filter(status=Payment.STATUS_REFUND_REQUESTED)
        .order_by("-updated_at")
    )

    # Fil d'activite recente (10 derniers evenements toutes sources confondues)
    recent_payments = list(
        Payment.objects.select_related("reservation__user", "reservation__vehicle")
        .filter(status=Payment.STATUS_PAID)
        .order_by("-paid_at")[:10]
    )
    recent_reservations = list(
        Reservation.objects.select_related("user", "vehicle")
        .exclude(status=Reservation.STATUS_PENDING)
        .order_by("-updated_at")[:10]
    )
    recent_contacts = list(
        ContactMessage.objects.order_by("-created_at")[:10]
    )

    activity_feed = []
    from django.urls import reverse as _reverse
    for p in recent_payments:
        activity_feed.append({
            "type": "payment",
            "icon": "fa-credit-card",
            "color": "#2F855A",
            "label": f"Paiement de {p.amount} EUR",
            "detail": f"{p.reservation.user.username} — {p.reservation.vehicle.title}",
            "date": p.paid_at,
            "url": _reverse("admin:payments_payment_change", args=[p.id]),
        })
    for r in recent_reservations:
        color = {"accepted": "#1E3A8A", "rejected": "#B91C1C", "deposit_paid": "#2F855A"}.get(r.status, "#666")
        icon = {"accepted": "fa-check", "rejected": "fa-xmark", "deposit_paid": "fa-coins"}.get(r.status, "fa-calendar")
        activity_feed.append({
            "type": "reservation",
            "icon": icon,
            "color": color,
            "label": f"Reservation {r.get_status_display()}",
            "detail": f"{r.user.username} — {r.vehicle.title}",
            "date": r.updated_at,
            "url": _reverse("admin:reservations_reservation_change", args=[r.id]),
        })
    for m in recent_contacts:
        activity_feed.append({
            "type": "message",
            "icon": "fa-envelope",
            "color": "#B7791F",
            "label": f"Message : {m.subject[:40]}",
            "detail": m.full_name or (m.user.username if m.user else "Anonyme"),
            "date": m.created_at,
            "url": _reverse("admin:contact_contactmessage_change", args=[m.id]),
        })
    activity_feed.sort(key=lambda x: x["date"] or timezone.now(), reverse=True)
    activity_feed = activity_feed[:10]

    now = timezone.now()
    paid_qs = Payment.objects.filter(status=Payment.STATUS_PAID)

    total_revenue = paid_qs.aggregate(t=Sum("amount"))["t"] or Decimal("0.00")
    monthly_revenue = paid_qs.filter(
        paid_at__year=now.year, paid_at__month=now.month
    ).aggregate(t=Sum("amount"))["t"] or Decimal("0.00")

    full_paid_qs = paid_qs.filter(amount__gte=F("reservation__vehicle__price"))
    full_payment_count = full_paid_qs.count()
    full_payment_revenue = full_paid_qs.aggregate(t=Sum("amount"))["t"] or Decimal("0.00")

    deposit_only_count = paid_qs.filter(
        amount__lt=F("reservation__vehicle__price")
    ).count()

    sold_count = Vehicle.objects.filter(status=Vehicle.STATUS_SOLD).count()

    from vehicles.models import VehicleCategory
    top_categories = list(
        VehicleCategory.objects.annotate(
            sold=Count("vehicles", filter=Q(vehicles__status=Vehicle.STATUS_SOLD))
        ).filter(sold__gt=0).order_by("-sold")[:5]
    )
    max_sold = top_categories[0].sold if top_categories else 1

    admin_users = User.objects.filter(is_staff=True, is_superuser=False).order_by("username")

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
        "refund_requests": refund_requests,
        "refund_request_count": refund_requests.count(),
        # Stats ventes
        "total_revenue": total_revenue,
        "monthly_revenue": monthly_revenue,
        "full_payment_count": full_payment_count,
        "full_payment_revenue": full_payment_revenue,
        "deposit_only_count": deposit_only_count,
        "sold_count": sold_count,
        "top_categories": top_categories,
        "max_sold": max_sold,
        "current_month": now.strftime("%B %Y"),
        "activity_feed": activity_feed,
        "recent_reviews": Review.objects.select_related("user", "vehicle").order_by("-created_at")[:10],
        "admin_users": admin_users,
        "create_admin_form": CreateAdminForm(),
    }
    return render(request, "accounts/admin_dashboard.html", context)
