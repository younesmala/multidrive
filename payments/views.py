import io
import json
from decimal import Decimal, InvalidOperation

import stripe
from django.conf import settings
from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.http import HttpResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.template.loader import render_to_string
from django.urls import reverse
from django.utils import timezone
from django.utils.timezone import localtime
from xhtml2pdf import pisa

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
    # Réservations acceptées sans paiement (premier paiement)
    first_payment_qs = list(
        Reservation.objects.filter(
            user=request.user,
            status=Reservation.STATUS_ACCEPTED,
        )
        .exclude(payment__status=Payment.STATUS_PAID)
        .select_related("vehicle", "vehicle__category")
        .prefetch_related("vehicle__images")
        .order_by("created_at")
    )

    # Réservations deposit_paid avec solde restant (second paiement)
    balance_qs = list(
        Reservation.objects.filter(
            user=request.user,
            status=Reservation.STATUS_DEPOSIT_PAID,
        )
        .select_related("vehicle", "vehicle__category", "payment")
        .prefetch_related("vehicle__images")
        .order_by("created_at")
    )
    balance_qs = [r for r in balance_qs if r.vehicle.price - r.payment.amount > Decimal("0")]

    reservations_data = []
    for r in first_payment_qs:
        deposit = _deposit_for(r.vehicle)
        main_image = r.vehicle.images.filter(is_main=True).first()
        reservations_data.append({
            "reservation": r,
            "deposit_amount": deposit,
            "total_price": r.vehicle.price,
            "already_paid": Decimal("0"),
            "remaining": r.vehicle.price,
            "main_image": main_image,
            "is_balance": False,
        })

    for r in balance_qs:
        already_paid = r.payment.amount
        remaining = r.vehicle.price - already_paid
        main_image = r.vehicle.images.filter(is_main=True).first()
        reservations_data.append({
            "reservation": r,
            "deposit_amount": remaining,
            "total_price": r.vehicle.price,
            "already_paid": already_paid,
            "remaining": remaining,
            "main_image": main_image,
            "is_balance": True,
        })

    if request.method == "POST":
        reservation_id = request.POST.get("reservation_id")
        rd = next(
            (rd for rd in reservations_data if str(rd["reservation"].id) == reservation_id),
            None,
        )

        if not rd:
            messages.error(request, "Réservation introuvable. Veuillez réessayer.")
            return redirect("payments:checkout")

        reservation = rd["reservation"]
        total_price = rd["total_price"]
        already_paid = rd["already_paid"]
        remaining = rd["remaining"]
        amount_type = request.POST.get("amount_type", "deposit")

        if rd["is_balance"]:
            chosen_amount = remaining
        elif amount_type == "full":
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
            chosen_amount = rd["deposit_amount"]

        new_total = already_paid + chosen_amount

        stripe.api_key = settings.STRIPE_SECRET_KEY
        try:
            session = stripe.checkout.Session.create(
                payment_method_types=["card"],
                line_items=[{
                    "price_data": {
                        "currency": "eur",
                        "product_data": {
                            "name": reservation.vehicle.title,
                            "description": f"Réservation MultiDrive #{reservation.id}",
                        },
                        "unit_amount": int(chosen_amount * 100),
                    },
                    "quantity": 1,
                }],
                mode="payment",
                customer_email=request.user.email or None,
                success_url=(
                    request.build_absolute_uri(reverse("payments:stripe_success"))
                    + "?session_id={CHECKOUT_SESSION_ID}"
                ),
                cancel_url=request.build_absolute_uri(reverse("payments:checkout")),
                metadata={
                    "reservation_id": str(reservation.id),
                    "chosen_amount": str(chosen_amount),
                    "already_paid": str(already_paid),
                    "new_total": str(new_total),
                },
            )
        except stripe.StripeError as e:
            messages.error(request, f"Erreur Stripe : {e.user_message or str(e)}")
            return redirect("payments:checkout")

        return redirect(session.url)

    js_data = {
        str(rd["reservation"].id): {
            "deposit": str(rd["deposit_amount"]),
            "total": str(rd["remaining"]),
            "label": rd["reservation"].vehicle.title,
            "already_paid": str(rd["already_paid"]),
            "is_balance": rd["is_balance"],
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
            "stripe_public_key": settings.STRIPE_PUBLIC_KEY,
        },
    )


@login_required
def stripe_success(request):
    session_id = request.GET.get("session_id")
    if not session_id:
        return redirect("payments:checkout")

    # Anti-doublon : si ce session_id est déjà en base, on ne retraite pas
    if Payment.objects.filter(transaction_reference=session_id).exists():
        messages.info(request, "Ce paiement a déjà été enregistré.")
        return redirect("accounts:payment_list")

    stripe.api_key = settings.STRIPE_SECRET_KEY
    try:
        session = stripe.checkout.Session.retrieve(session_id)
    except stripe.StripeError:
        messages.error(request, "Impossible de vérifier le paiement. Contactez le support.")
        return redirect("payments:checkout")

    if session.payment_status != "paid":
        messages.warning(request, "Le paiement n'a pas été complété.")
        return redirect("payments:checkout")

    reservation_id = session.metadata["reservation_id"]
    chosen_amount = Decimal(session.metadata["chosen_amount"])
    new_total = Decimal(session.metadata["new_total"])

    reservation = get_object_or_404(Reservation, id=reservation_id, user=request.user)

    Payment.objects.update_or_create(
        reservation=reservation,
        defaults={
            "amount": new_total,
            "status": Payment.STATUS_PAID,
            "payment_method": "card",
            "transaction_reference": session_id,
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
        f"Paiement de {chosen_amount} € confirmé. Total versé : {new_total} € sur {reservation.vehicle.price} €.",
    )
    return redirect("accounts:payment_list")


@login_required
def stripe_cancel(request):
    messages.warning(request, "Paiement annulé. Vous pouvez réessayer quand vous voulez.")
    return redirect("payments:checkout")


def _render_pdf(template_name, context):
    html = render_to_string(template_name, context)
    buffer = io.BytesIO()
    pisa.CreatePDF(io.StringIO(html), dest=buffer)
    return buffer.getvalue()


def _payment_pdf_context(payment):
    reservation = payment.reservation
    vehicle = reservation.vehicle
    buyer = reservation.user
    remaining = (vehicle.price - payment.amount).quantize(Decimal("0.01"))
    paid_at = localtime(payment.paid_at).strftime("%d/%m/%Y %H:%M") if payment.paid_at else "—"
    issued_date = localtime(timezone.now()).strftime("%d/%m/%Y")
    invoice_number = f"MULTI-{payment.paid_at.year if payment.paid_at else timezone.now().year}-{payment.id:04d}"
    year_token = next(
        (t for t in reversed(vehicle.title.split()) if t.isdigit() and len(t) == 4),
        "N/A",
    )
    return {
        "invoice_number": invoice_number,
        "cession_ref": f"CESS-{reservation.id:04d}",
        "issued_date": issued_date,
        "cession_date": issued_date,
        "buyer_name": f"{buyer.first_name} {buyer.last_name}".strip() or buyer.username,
        "buyer_email": buyer.email,
        "buyer_id": buyer.id,
        "vehicle_title": vehicle.title,
        "vehicle_category": vehicle.category.name if vehicle.category else "—",
        "vehicle_price": vehicle.price,
        "vehicle_year": year_token,
        "amount_paid": payment.amount,
        "remaining": str(remaining),
        "transaction_ref": payment.transaction_reference or "—",
        "paid_at": paid_at,
        "reservation_id": reservation.id,
    }


@login_required
def download_facture(request, payment_id):
    payment = get_object_or_404(
        Payment.objects.select_related("reservation__vehicle__category", "reservation__user"),
        id=payment_id,
        reservation__user=request.user,
        status=Payment.STATUS_PAID,
    )
    context = _payment_pdf_context(payment)
    pdf = _render_pdf("payments/pdf_facture.html", context)
    filename = f"facture_{context['invoice_number']}.pdf"
    response = HttpResponse(pdf, content_type="application/pdf")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'
    return response


@login_required
def download_cession(request, payment_id):
    payment = get_object_or_404(
        Payment.objects.select_related("reservation__vehicle__category", "reservation__user"),
        id=payment_id,
        reservation__user=request.user,
        status=Payment.STATUS_PAID,
    )
    context = _payment_pdf_context(payment)
    pdf = _render_pdf("payments/pdf_cession.html", context)
    filename = f"acte_cession_{context['cession_ref']}.pdf"
    response = HttpResponse(pdf, content_type="application/pdf")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'
    return response
