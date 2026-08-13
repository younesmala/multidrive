from django.conf import settings
from django.core.mail import EmailMultiAlternatives
from django.template.loader import render_to_string


def _admin_bcc():
    addr = getattr(settings, "EMAIL_HOST_USER", "")
    return [addr] if addr else []


def send_reservation_status_email(reservation, status):
    recipient = reservation.user.email
    if not recipient:
        return
    if status == "accepted":
        subject = f"Votre reservation est confirmee — {reservation.vehicle.title}"
        template = "reservations/email_reservation_accepted.html"
    else:
        subject = f"Mise a jour de votre reservation — {reservation.vehicle.title}"
        template = "reservations/email_reservation_rejected.html"
    html_body = render_to_string(template, {"reservation": reservation})
    text_body = (
        f"Bonjour {reservation.user.first_name or reservation.user.username},\n\n"
        + (
            f"Votre reservation pour {reservation.vehicle.title} a ete acceptee.\n"
            if status == "accepted"
            else f"Votre reservation pour {reservation.vehicle.title} n'a pas pu etre acceptee.\n"
        )
        + "\nL'equipe MultiDrive"
    )
    email = EmailMultiAlternatives(
        subject=subject, body=text_body, to=[recipient], bcc=_admin_bcc()
    )
    email.attach_alternative(html_body, "text/html")
    try:
        email.send()
    except Exception:
        pass


def send_reservation_confirmation(reservation):
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
    email = EmailMultiAlternatives(
        subject=subject, body=text_body, to=[recipient], bcc=_admin_bcc()
    )
    email.attach_alternative(html_body, "text/html")
    try:
        email.send()
    except Exception:
        pass


def send_appointment_update_email(reservation):
    recipient = reservation.user.email
    if not recipient or not reservation.appointment_date:
        return
    subject = f"Votre rendez-vous a ete modifie — {reservation.vehicle.title}"
    html_body = render_to_string(
        "reservations/email_appointment_updated.html",
        {"reservation": reservation},
    )
    user = reservation.user
    from django.utils.timezone import localtime
    rdv = localtime(reservation.appointment_date)
    text_body = (
        f"Bonjour {user.first_name or user.username},\n\n"
        f"L'equipe MultiDrive a propose un nouveau creneau pour votre reservation.\n\n"
        f"Vehicule : {reservation.vehicle.title}\n"
        f"Nouveau rendez-vous : {rdv.strftime('%d/%m/%Y a %H:%M')}\n"
        + (f"Telephone : {reservation.phone}\n" if reservation.phone else "")
        + "\nSi ce creneau ne vous convient pas, contactez-nous.\n\nL'equipe MultiDrive"
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


def send_cancellation_admin_notification(reservation):
    admin_emails = _admin_bcc()
    if not admin_emails:
        return
    user = reservation.user
    vehicle = reservation.vehicle
    subject = f"[MultiDrive] Annulation reservation #{reservation.id} — {vehicle.title}"
    body = (
        f"Un membre vient d'annuler sa reservation.\n\n"
        f"Membre   : {user.username} ({user.email})\n"
        + (f"Tel      : {reservation.phone}\n" if reservation.phone else "")
        + f"Vehicule : {vehicle.title} ({vehicle.price} EUR)\n"
        f"Ref      : #{reservation.id}\n"
    )
    try:
        EmailMultiAlternatives(subject=subject, body=body, to=admin_emails).send()
    except Exception:
        pass
