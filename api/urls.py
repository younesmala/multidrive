from rest_framework.routers import DefaultRouter

from .views import (
    ContactMessageViewSet,
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

urlpatterns = router.urls
