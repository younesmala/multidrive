from django.contrib import messages
from django.contrib.admin.views.decorators import staff_member_required
from django.contrib.auth.decorators import login_required
from django.core.mail import EmailMultiAlternatives
from django.db.models import Count, Q
from django.shortcuts import get_object_or_404, redirect, render
from django.template.loader import render_to_string
from django.views.decorators.http import require_POST

from payments.models import Payment
from vehicles.models import Vehicle

from .forms import ReservationForm
from .models import Reservation


@require_POST
@staff_member_required
def update_reservation_status(request, reservation_id):
    reservation = get_object_or_404(Reservation, id=reservation_id)
    action = request.POST.get("action")

    if action == "accept" and reservation.status == Reservation.STATUS_PENDING:
        reservation.status = Reservation.STATUS_ACCEPTED
        reservation.user_status_read = False
        reservation.save(update_fields=["status", "user_status_read", "updated_at"])
        vehicle = reservation.vehicle
        vehicle.status = Vehicle.STATUS_RESERVED
        vehicle.save(update_fields=["status"])
        messages.success(request, f"Reservation de {reservation.user.username} acceptee.")
    elif action == "reject" and reservation.status == Reservation.STATUS_PENDING:
        reservation.status = Reservation.STATUS_REJECTED
        reservation.user_status_read = False
        reservation.save(update_fields=["status", "user_status_read", "updated_at"])
        messages.success(request, f"Reservation de {reservation.user.username} refusee.")

    return redirect("accounts:admin_dashboard")


@login_required
def reserve_vehicle(request, vehicle_id):
    vehicle = get_object_or_404(Vehicle, id=vehicle_id)

    if vehicle.status != Vehicle.STATUS_AVAILABLE:
        messages.error(request, "Ce vehicule n'est plus disponible a la reservation.")
        return redirect("vehicles:vehicle_detail", vehicle_id=vehicle.id)

    existing = Reservation.objects.filter(
        user=request.user,
        vehicle=vehicle,
        status__in=[Reservation.STATUS_PENDING, Reservation.STATUS_ACCEPTED],
    ).first()
    if existing:
        messages.warning(request, "Vous avez deja une reservation en cours pour ce vehicule.")
        return redirect("reservations:my_reservations")

    if request.method == "POST":
        form = ReservationForm(request.POST)
        if form.is_valid():
            reservation = form.save(commit=False)
            reservation.user = request.user
            reservation.vehicle = vehicle
            reservation.status = Reservation.STATUS_PENDING
            reservation.save()
            _send_reservation_confirmation(reservation)
            return redirect("reservations:reservation_success", reservation_id=reservation.id)
    else:
        form = ReservationForm()

    return render(
        request,
        "reservations/reservation_form.html",
        {
            "form": form,
            "vehicle": vehicle,
        },
    )


@login_required
def reservation_success(request, reservation_id):
    reservation = get_object_or_404(
        Reservation.objects.select_related("vehicle", "user"),
        id=reservation_id,
        user=request.user,
    )
    return render(
        request,
        "reservations/reservation_success.html",
        {"reservation": reservation},
    )


@login_required
def my_reservations(request):
    reservations = (
        Reservation.objects.select_related("vehicle", "vehicle__category", "payment")
        .filter(
            user=request.user,
            status__in=[
                Reservation.STATUS_PENDING,
                Reservation.STATUS_ACCEPTED,
                Reservation.STATUS_REJECTED,
                Reservation.STATUS_CANCELLED,
            ],
        )
        .order_by("-created_at")
    )
    reservations.filter(user_status_read=False).update(user_status_read=True)

    reservation_summary = reservations.aggregate(
        total=Count("id"),
        pending=Count("id", filter=Q(status=Reservation.STATUS_PENDING)),
        accepted=Count("id", filter=Q(status=Reservation.STATUS_ACCEPTED)),
        rejected=Count("id", filter=Q(status=Reservation.STATUS_REJECTED)),
    )

    return render(
        request,
        "reservations/my_reservations.html",
        {
            "reservations": reservations,
            "reservation_summary": reservation_summary,
        },
    )


@require_POST
@login_required
def cancel_reservation(request, reservation_id):
    reservation = get_object_or_404(
        Reservation.objects.select_related("vehicle", "payment"),
        id=reservation_id,
        user=request.user,
    )

    if reservation.status == Reservation.STATUS_PENDING:
        reservation.status = Reservation.STATUS_CANCELLED
        reservation.save(update_fields=["status", "updated_at"])
        messages.success(request, "Votre reservation a bien ete annulee.")

    elif reservation.status == Reservation.STATUS_ACCEPTED:
        reservation.status = Reservation.STATUS_CANCELLED
        reservation.save(update_fields=["status", "updated_at"])
        vehicle = reservation.vehicle
        vehicle.status = Vehicle.STATUS_AVAILABLE
        vehicle.save(update_fields=["status"])
        messages.success(request, "Votre reservation a ete annulee. Le vehicule est de nouveau disponible.")

    elif reservation.status == Reservation.STATUS_DEPOSIT_PAID:
        reservation.status = Reservation.STATUS_CANCELLED
        reservation.save(update_fields=["status", "updated_at"])
        vehicle = reservation.vehicle
        vehicle.status = Vehicle.STATUS_AVAILABLE
        vehicle.save(update_fields=["status"])
        payment = getattr(reservation, "payment", None)
        if payment:
            payment.status = Payment.STATUS_REFUND_REQUESTED
            payment.admin_notif_read = False
            payment.user_status_read = False
            payment.save(update_fields=["status", "admin_notif_read", "user_status_read", "updated_at"])
        messages.warning(
            request,
            "Votre annulation a ete enregistree. Un remboursement de votre acompte sera traite "
            "par notre equipe sous 14 jours. Des frais administratifs de 10 % minimum "
            "pourront etre retenus conformement aux conditions generales.",
        )

    else:
        messages.error(request, "Cette reservation ne peut pas etre annulee.")

    return redirect("reservations:my_reservations")


@login_required
def my_purchases(request):
    purchases = (
        Reservation.objects.select_related("vehicle", "vehicle__category", "payment")
        .filter(user=request.user, status=Reservation.STATUS_DEPOSIT_PAID)
        .order_by("-updated_at")
    )
    purchases.filter(user_status_read=False).update(user_status_read=True)

    return render(request, "reservations/my_purchases.html", {"purchases": purchases})


def _send_reservation_confirmation(reservation):
    recipient = reservation.user.email
    if not recipient:
        return
    subject = f"Confirmation de votre demande — {reservation.vehicle.title}"
    html_body = render_to_string(
        "reservations/email_reservation_confirmation.html",
        {"reservation": reservation},
    )
    text_body = (
        f"Bonjour {reservation.user.first_name or reservation.user.username},\n\n"
        f"Votre demande de reservation pour {reservation.vehicle.title} "
        f"({reservation.vehicle.price} EUR) a bien ete enregistree.\n\n"
        "Notre equipe vous contactera pour confirmer votre reservation.\n\n"
        "MultiDrive"
    )
    email = EmailMultiAlternatives(subject=subject, body=text_body, to=[recipient])
    email.attach_alternative(html_body, "text/html")
    try:
        email.send()
    except Exception:
        pass
