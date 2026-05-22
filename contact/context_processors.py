from .models import ContactMessage


def contact_notifications(request):
    unread_contact_responses = 0

    if request.user.is_authenticated:
        unread_contact_responses = ContactMessage.objects.filter(
            user=request.user,
            admin_response__gt="",
            user_response_read=False,
        ).count()

    return {
        "unread_contact_responses": unread_contact_responses,
    }
