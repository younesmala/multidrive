from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string


def _admin_bcc():
    addr = getattr(settings, "EMAIL_HOST_USER", "")
    return [addr] if addr else []


def send_payment_confirmation(payment, chosen_amount):
    recipient = payment.reservation.user.email
    if not recipient:
        return
    reservation = payment.reservation
    vehicle = reservation.vehicle
    remaining = vehicle.price - payment.amount

    subject = f"Confirmation de paiement — {vehicle.title}"
    html_body = render_to_string(
        "payments/email_payment_confirmation.html",
        {
            "payment": payment,
            "chosen_amount": chosen_amount,
            "remaining": remaining,
            "is_full": remaining <= 0,
        },
    )
    user = reservation.user
    text_body = (
        f"Bonjour {user.first_name or user.username},\n\n"
        f"Votre paiement de {chosen_amount} EUR a bien ete confirme pour le vehicule {vehicle.title}.\n"
        f"Total verse : {payment.amount} EUR sur {vehicle.price} EUR.\n"
        + (f"Solde restant : {remaining} EUR.\n" if remaining > 0 else "Paiement integral confirme.\n")
        + f"\nReference : {payment.transaction_reference}\n\n"
        "L'equipe MultiDrive"
    )
    email = EmailMultiAlternatives(
        subject=subject,
        body=text_body,
        to=[recipient],
        bcc=_admin_bcc(),
    )
    email.attach_alternative(html_body, "text/html")
    try:
        email.send()
    except Exception:
        pass
