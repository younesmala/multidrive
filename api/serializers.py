from rest_framework import serializers

from contact.models import ContactMessage
from payments.models import Invoice, Payment
from reservations.models import Reservation
from vehicles.models import Review, Vehicle, VehicleCategory, VehicleImage


class VehicleImageSerializer(serializers.ModelSerializer):
    class Meta:
        model = VehicleImage
        fields = ["id", "image", "is_main", "created_at"]


class VehicleCategorySerializer(serializers.ModelSerializer):
    class Meta:
        model = VehicleCategory
        fields = ["id", "name", "slug", "description", "created_at"]


class VehicleSerializer(serializers.ModelSerializer):
    category_name = serializers.CharField(source="category.name", read_only=True)
    images = VehicleImageSerializer(many=True, read_only=True)

    class Meta:
        model = Vehicle
        fields = [
            "id",
            "category",
            "category_name",
            "title",
            "description",
            "price",
            "status",
            "created_at",
            "images",
        ]


class ReservationSerializer(serializers.ModelSerializer):
    user = serializers.StringRelatedField(read_only=True)
    vehicle_title = serializers.CharField(source="vehicle.title", read_only=True)

    class Meta:
        model = Reservation
        fields = [
            "id",
            "user",
            "vehicle",
            "vehicle_title",
            "status",
            "message",
            "appointment_date",
            "created_at",
            "updated_at",
        ]
        read_only_fields = ["status", "created_at", "updated_at"]


class PaymentSerializer(serializers.ModelSerializer):
    reservation_user = serializers.CharField(source="reservation.user.username", read_only=True)
    reservation_vehicle = serializers.CharField(source="reservation.vehicle.title", read_only=True)

    class Meta:
        model = Payment
        fields = [
            "id",
            "reservation",
            "reservation_user",
            "reservation_vehicle",
            "amount",
            "status",
            "payment_method",
            "transaction_reference",
            "paid_at",
            "created_at",
            "updated_at",
        ]


class InvoiceSerializer(serializers.ModelSerializer):
    payment_reference = serializers.CharField(source="payment.transaction_reference", read_only=True)

    class Meta:
        model = Invoice
        fields = [
            "id",
            "payment",
            "payment_reference",
            "invoice_number",
            "total_amount",
            "vat_amount",
            "issued_at",
            "due_date",
            "notes",
        ]


class ReviewSerializer(serializers.ModelSerializer):
    user = serializers.StringRelatedField(read_only=True)
    vehicle_title = serializers.CharField(source="vehicle.title", read_only=True)

    class Meta:
        model = Review
        fields = [
            "id",
            "vehicle",
            "vehicle_title",
            "user",
            "rating",
            "comment",
            "created_at",
            "updated_at",
        ]
        read_only_fields = ["created_at", "updated_at"]


class ContactMessageSerializer(serializers.ModelSerializer):
    class Meta:
        model = ContactMessage
        fields = [
            "id",
            "full_name",
            "email",
            "phone",
            "subject",
            "message",
            "is_read",
            "created_at",
        ]
        read_only_fields = ["is_read", "created_at"]
