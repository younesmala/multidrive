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


_SIGNATURE_DATA_URI = "data:image/png;base64,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"


def _payment_pdf_context(payment):
    reservation = payment.reservation
    vehicle = reservation.vehicle
    buyer = reservation.user
    remaining = (vehicle.price - payment.amount).quantize(Decimal("0.01"))
    paid_at = localtime(payment.paid_at).strftime("%d/%m/%Y %H:%M") if payment.paid_at else "—"
    issued_date = localtime(timezone.now()).strftime("%d/%m/%Y")
    year_ref = payment.paid_at.year if payment.paid_at else timezone.now().year
    invoice_number = f"MULTI-{year_ref}-{payment.id:04d}"
    year_token = next(
        (t for t in reversed(vehicle.title.split()) if t.isdigit() and len(t) == 4),
        "N/A",
    )
    tokens = [t for t in vehicle.title.split() if not t.startswith("#")]
    brand = tokens[0] if tokens else ""
    non_year = [t for t in tokens[1:] if not (t.isdigit() and len(t) == 4)]
    model = " ".join(non_year)
    return {
        "invoice_number": invoice_number,
        "recu_number": f"ACOMPTE-{year_ref}-{payment.id:04d}",
        "specimen_ref": f"SPEC-{reservation.id:04d}",
        "cession_ref": f"CESS-{reservation.id:04d}",
        "issued_date": issued_date,
        "cession_date": issued_date,
        "buyer_name": f"{buyer.first_name} {buyer.last_name}".strip() or buyer.username,
        "buyer_email": buyer.email,
        "buyer_id": buyer.id,
        "vehicle_title": vehicle.title,
        "vehicle_brand": brand,
        "vehicle_model": model,
        "vehicle_category": vehicle.category.name if vehicle.category else "—",
        "vehicle_price": vehicle.price,
        "vehicle_year": year_token,
        "amount_paid": payment.amount,
        "remaining": str(remaining),
        "is_full_payment": remaining <= Decimal("0.00"),
        "transaction_ref": payment.transaction_reference or "—",
        "paid_at": paid_at,
        "reservation_id": reservation.id,
        "signature_url": _SIGNATURE_DATA_URI,
    }


def _get_paid_payment(payment_id, user):
    return get_object_or_404(
        Payment.objects.select_related("reservation__vehicle__category", "reservation__user"),
        id=payment_id,
        reservation__user=user,
        status=Payment.STATUS_PAID,
    )


@login_required
def download_recu_acompte(request, payment_id):
    payment = _get_paid_payment(payment_id, request.user)
    context = _payment_pdf_context(payment)
    pdf = _render_pdf("payments/pdf_recu_acompte.html", context)
    filename = f"recu_acompte_{context['recu_number']}.pdf"
    response = HttpResponse(pdf, content_type="application/pdf")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'
    return response


@login_required
def download_facture(request, payment_id):
    payment = _get_paid_payment(payment_id, request.user)
    context = _payment_pdf_context(payment)
    if not context["is_full_payment"]:
        return HttpResponse("Document disponible apres paiement integral.", status=403)
    pdf = _render_pdf("payments/pdf_facture.html", context)
    filename = f"facture_{context['invoice_number']}.pdf"
    response = HttpResponse(pdf, content_type="application/pdf")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'
    return response


@login_required
def download_cession(request, payment_id):
    payment = _get_paid_payment(payment_id, request.user)
    context = _payment_pdf_context(payment)
    if not context["is_full_payment"]:
        return HttpResponse("Document disponible apres paiement integral.", status=403)
    pdf = _render_pdf("payments/pdf_cession.html", context)
    filename = f"acte_cession_{context['cession_ref']}.pdf"
    response = HttpResponse(pdf, content_type="application/pdf")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'
    return response


@login_required
def download_specimen(request, payment_id):
    payment = _get_paid_payment(payment_id, request.user)
    context = _payment_pdf_context(payment)
    if not context["is_full_payment"]:
        return HttpResponse("Document disponible apres paiement integral.", status=403)
    pdf = _render_pdf("payments/pdf_specimen_immatriculation.html", context)
    filename = f"specimen_immatriculation_{context['specimen_ref']}.pdf"
    response = HttpResponse(pdf, content_type="application/pdf")
    response["Content-Disposition"] = f'attachment; filename="{filename}"'
    return response
