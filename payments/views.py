import json
from decimal import Decimal, InvalidOperation
from uuid import uuid4

from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect, render
from django.utils import timezone

from payments.models import Payment
from reservations.models import Reservation
from vehicles.models import Vehicle


def _deposit_for(vehicle):
    return max(
        Decimal("20.00"),
        min(
            (vehicle.price * Decimal("0.20")).quantize(Decimal("0.01")),
            Decimal("250.00"),
        ),
    )


@login_required
def checkout(request):
    pending_reservations = list(
        Reservation.objects.filter(
            user=request.user,
            status=Reservation.STATUS_ACCEPTED,
        )
        .exclude(payment__status=Payment.STATUS_PAID)
        .select_related("vehicle", "vehicle__category")
        .prefetch_related("vehicle__images")
        .order_by("created_at")
    )

    reservations_data = []
    for r in pending_reservations:
        deposit = _deposit_for(r.vehicle)
        main_image = r.vehicle.images.filter(is_main=True).first()
        reservations_data.append({
            "reservation": r,
            "deposit_amount": deposit,
            "total_price": r.vehicle.price,
            "main_image": main_image,
        })

    if request.method == "POST":
        reservation_id = request.POST.get("reservation_id")
        reservation = next(
            (rd["reservation"] for rd in reservations_data if str(rd["reservation"].id) == reservation_id),
            None,
        )

        if not reservation:
            messages.error(request, "Réservation introuvable. Veuillez réessayer.")
            return redirect("payments:checkout")

        deposit_amount = _deposit_for(reservation.vehicle)
        total_price = reservation.vehicle.price
        amount_type = request.POST.get("amount_type", "deposit")

        if amount_type == "full":
            chosen_amount = total_price
        elif amount_type == "custom":
            raw = request.POST.get("custom_amount", "").replace(",", ".").strip()
            try:
                chosen_amount = Decimal(raw).quantize(Decimal("0.01"))
                if chosen_amount <= Decimal("0"):
                    raise ValueError
            except (InvalidOperation, ValueError):
                messages.error(request, "Montant invalide. Veuillez saisir un montant supérieur à 0 €.")
                return redirect("payments:checkout")
        else:
            chosen_amount = deposit_amount

        Payment.objects.update_or_create(
            reservation=reservation,
            defaults={
                "amount": chosen_amount,
                "status": Payment.STATUS_PAID,
                "payment_method": "card",
                "transaction_reference": uuid4().hex,
                "paid_at": timezone.now(),
                "user_status_read": False,
                "admin_notif_read": False,
            },
        )

        reservation.status = Reservation.STATUS_DEPOSIT_PAID
        reservation.user_status_read = False
        reservation.save(update_fields=["status", "user_status_read", "updated_at"])

        vehicle = reservation.vehicle
        vehicle.status = Vehicle.STATUS_SOLD
        vehicle.save(update_fields=["status"])

        messages.success(
            request,
            f"Paiement de {chosen_amount} € enregistré. "
            f"Véhicule : {reservation.vehicle.title}.",
        )
        return redirect("accounts:payment_list")

    # Build JSON payload for JS (amounts per reservation id)
    js_data = {
        str(rd["reservation"].id): {
            "deposit": str(rd["deposit_amount"]),
            "total": str(rd["total_price"]),
            "label": rd['reservation'].vehicle.title,
        }
        for rd in reservations_data
    }

    return render(
        request,
        "payments/checkout.html",
        {
            "reservations_data": reservations_data,
            "js_data": json.dumps(js_data),
            "has_reservations": bool(reservations_data),
        },
    )
