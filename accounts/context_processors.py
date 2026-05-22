from django.db.models import Q

from contact.models import ContactMessage
from payments.models import Payment
from reservations.models import Reservation

from .models import AccountDeletionRequest


def admin_notifications(request):
    admin_pending_notifications = 0

    if request.user.is_authenticated and request.user.is_staff:
        pending_reservations = Reservation.objects.filter(
            status=Reservation.STATUS_PENDING
        ).count()
        pending_messages = ContactMessage.objects.filter(
            Q(admin_response="") | Q(admin_response__isnull=True)
        ).count()
        pending_deletions = AccountDeletionRequest.objects.filter(processed=False).count()

        admin_pending_notifications = (
            pending_reservations + pending_messages + pending_deletions
        )

    return {
        "admin_pending_notifications": admin_pending_notifications,
    }


def member_notifications(request):
    unread_contact_responses = 0
    unread_reservations = 0
    unread_payments = 0

    if request.user.is_authenticated:
        unread_contact_responses = ContactMessage.objects.filter(
            user=request.user,
            admin_response__gt="",
            user_response_read=False,
        ).count()
        unread_reservations = Reservation.objects.filter(
            user=request.user,
            user_status_read=False,
        ).count()
        unread_payments = Payment.objects.filter(
            reservation__user=request.user,
            user_status_read=False,
        ).count()

    return {
        "unread_contact_responses": unread_contact_responses,
        "unread_reservations": unread_reservations,
        "unread_payments": unread_payments,
        "member_total_notifications": (
            unread_contact_responses + unread_reservations + unread_payments
        ),
    }
