from django.db.models import Q

from contact.models import ContactMessage
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
