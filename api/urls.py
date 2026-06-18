from rest_framework.routers import DefaultRouter

from django.urls import path

from .views import (
    ContactMessageViewSet,
    CurrentUserView,
    InvoiceViewSet,
    PaymentViewSet,
    ReservationViewSet,
    ReviewViewSet,
    VehicleCategoryViewSet,
    VehicleViewSet,
)


router = DefaultRouter()
router.register("categories", VehicleCategoryViewSet, basename="api-category")
router.register("vehicles", VehicleViewSet, basename="api-vehicle")
router.register("reservations", ReservationViewSet, basename="api-reservation")
router.register("payments", PaymentViewSet, basename="api-payment")
router.register("invoices", InvoiceViewSet, basename="api-invoice")
router.register("reviews", ReviewViewSet, basename="api-review")
router.register("contact-messages", ContactMessageViewSet, basename="api-contact-message")

urlpatterns = router.urls + [
    path("me/", CurrentUserView.as_view(), name="api-me"),
]
