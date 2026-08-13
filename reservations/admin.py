from django.contrib import admin

from .emails import send_reservation_status_email
from .models import Reservation


@admin.register(Reservation)
class ReservationAdmin(admin.ModelAdmin):
    list_display = ("id", "user", "vehicle", "status", "phone", "appointment_date", "created_at")
    list_filter = ("status", "created_at", "appointment_date")
    search_fields = ("user__username", "user__email", "vehicle__title", "message", "phone")
    ordering = ("-created_at",)

    def save_model(self, request, obj, form, change):
        previous_status = None
        previous_appointment = None
        if change and obj.pk:
            previous = Reservation.objects.get(pk=obj.pk)
            previous_status = previous.status
            previous_appointment = previous.appointment_date

        if change and (
            obj.status != previous_status or obj.appointment_date != previous_appointment
        ):
            obj.user_status_read = False

        super().save_model(request, obj, form, change)

        if change and obj.status != previous_status:
            if previous_status == Reservation.STATUS_PENDING and obj.status in (
                Reservation.STATUS_ACCEPTED,
                Reservation.STATUS_REJECTED,
            ):
                status_key = "accepted" if obj.status == Reservation.STATUS_ACCEPTED else "rejected"
                send_reservation_status_email(obj, status_key)
