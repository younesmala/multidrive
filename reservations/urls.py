from django.urls import path

from . import views


app_name = "reservations"

urlpatterns = [
    path("vehicle/<int:vehicle_id>/", views.reserve_vehicle, name="reserve_vehicle"),
    path("success/<int:reservation_id>/", views.reservation_success, name="reservation_success"),
    path("mine/", views.my_reservations, name="my_reservations"),
    path("<int:reservation_id>/update-status/", views.update_reservation_status, name="update_status"),
]
