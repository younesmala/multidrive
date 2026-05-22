from django.contrib.auth.decorators import login_required
from django.db.models import Count, Q
from django.shortcuts import get_object_or_404, redirect, render

from vehicles.models import Vehicle

from .forms import ReservationForm
from .models import Reservation


@login_required
def reserve_vehicle(request, vehicle_id):
    vehicle = get_object_or_404(Vehicle, id=vehicle_id)

    if request.method == "POST":
        form = ReservationForm(request.POST)
        if form.is_valid():
            reservation = form.save(commit=False)
            reservation.user = request.user
            reservation.vehicle = vehicle
            reservation.status = Reservation.STATUS_PENDING
            reservation.save()
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
        .filter(user=request.user)
        .order_by("-created_at")
    )
    reservations.filter(user_status_read=False).update(user_status_read=True)

    reservation_summary = reservations.aggregate(
        total=Count("id"),
        pending=Count("id", filter=Q(status=Reservation.STATUS_PENDING)),
        accepted=Count("id", filter=Q(status=Reservation.STATUS_ACCEPTED)),
        rejected=Count("id", filter=Q(status=Reservation.STATUS_REJECTED)),
        deposit_paid=Count("id", filter=Q(status=Reservation.STATUS_DEPOSIT_PAID)),
    )

    return render(
        request,
        "reservations/my_reservations.html",
        {
            "reservations": reservations,
            "reservation_summary": reservation_summary,
        },
    )
