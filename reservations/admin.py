from django.contrib import admin

from .models import Reservation


@admin.register(Reservation)
class ReservationAdmin(admin.ModelAdmin):
    list_display = ("id", "user", "vehicle", "status", "appointment_date", "created_at")
    list_filter = ("status", "created_at", "appointment_date")
    search_fields = ("user__username", "user__email", "vehicle__title", "message")
    ordering = ("-created_at",)
