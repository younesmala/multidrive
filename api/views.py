from drf_spectacular.utils import extend_schema, extend_schema_view
from rest_framework import viewsets
from rest_framework.permissions import IsAuthenticated

from contact.models import ContactMessage
from payments.models import Invoice, Payment
from reservations.models import Reservation
from vehicles.models import Vehicle, VehicleCategory

from .permissions import IsAdminOrCreateOnly, IsAdminOrReadOnly
from .serializers import (
    ContactMessageSerializer,
    InvoiceSerializer,
    PaymentSerializer,
    ReservationSerializer,
    VehicleCategorySerializer,
    VehicleSerializer,
)


@extend_schema_view(
    list=extend_schema(description="Retourne la liste des categories de vehicules."),
    retrieve=extend_schema(description="Retourne le detail d'une categorie."),
)
class VehicleCategoryViewSet(viewsets.ModelViewSet):
    queryset = VehicleCategory.objects.all().order_by("name")
    serializer_class = VehicleCategorySerializer
    permission_classes = [IsAdminOrReadOnly]


@extend_schema_view(
    list=extend_schema(description="Retourne la liste des vehicules."),
    retrieve=extend_schema(description="Retourne le detail d'un vehicule."),
)
class VehicleViewSet(viewsets.ModelViewSet):
    queryset = Vehicle.objects.select_related("category").prefetch_related("images").order_by("price", "title")
    serializer_class = VehicleSerializer
    permission_classes = [IsAdminOrReadOnly]


@extend_schema_view(
    list=extend_schema(description="Retourne les reservations de l'utilisateur connecte."),
    create=extend_schema(description="Cree une nouvelle reservation pour l'utilisateur connecte."),
)
class ReservationViewSet(viewsets.ModelViewSet):
    queryset = Reservation.objects.select_related("vehicle", "user").all()
    serializer_class = ReservationSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        queryset = Reservation.objects.select_related("vehicle", "user").order_by("-created_at")
        if self.request.user.is_staff:
            return queryset
        return queryset.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user, status=Reservation.STATUS_PENDING)


@extend_schema_view(
    list=extend_schema(description="Retourne les paiements de l'utilisateur connecte."),
)
class PaymentViewSet(viewsets.ModelViewSet):
    queryset = Payment.objects.select_related("reservation", "reservation__user", "reservation__vehicle").all()
    serializer_class = PaymentSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        queryset = Payment.objects.select_related("reservation", "reservation__user", "reservation__vehicle").order_by(
            "-created_at"
        )
        if self.request.user.is_staff:
            return queryset
        return queryset.filter(reservation__user=self.request.user)


@extend_schema_view(
    list=extend_schema(description="Retourne les factures de l'utilisateur connecte."),
)
class InvoiceViewSet(viewsets.ModelViewSet):
    queryset = Invoice.objects.select_related("payment", "payment__reservation", "payment__reservation__user").all()
    serializer_class = InvoiceSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        queryset = Invoice.objects.select_related("payment", "payment__reservation", "payment__reservation__user").order_by(
            "-issued_at"
        )
        if self.request.user.is_staff:
            return queryset
        return queryset.filter(payment__reservation__user=self.request.user)


@extend_schema_view(
    create=extend_schema(description="Permet d'envoyer un message de contact sans etre connecte."),
    list=extend_schema(description="Retourne les messages de contact. Acces staff uniquement."),
)
class ContactMessageViewSet(viewsets.ModelViewSet):
    queryset = ContactMessage.objects.all().order_by("-created_at")
    serializer_class = ContactMessageSerializer
    permission_classes = [IsAdminOrCreateOnly]
