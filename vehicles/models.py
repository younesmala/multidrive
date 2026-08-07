from django.conf import settings
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import models


class VehicleCategory(models.Model):
    name = models.CharField(max_length=60)
    slug = models.SlugField(max_length=120, unique=True)
    description = models.TextField(blank=True, null=True)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Vehicle category"
        verbose_name_plural = "Vehicle categories"

    def __str__(self):
        return self.name


class Vehicle(models.Model):
    STATUS_AVAILABLE = "available"
    STATUS_RESERVED = "reserved"
    STATUS_SOLD = "sold"

    STATUS_CHOICES = [
        (STATUS_AVAILABLE, "Disponible"),
        (STATUS_RESERVED, "Reserve"),
        (STATUS_SOLD, "Vendu"),
    ]

    CARROSSERIE_TRES_BON = "tres_bon"
    CARROSSERIE_BON = "bon"
    CARROSSERIE_ACCIDENTE = "accidente"
    CARROSSERIE_CHOICES = [
        (CARROSSERIE_TRES_BON, "Tres bon"),
        (CARROSSERIE_BON, "Bon"),
        (CARROSSERIE_ACCIDENTE, "Legerement accidente"),
    ]

    MOTEUR_TRES_BON = "tres_bon"
    MOTEUR_BON = "bon"
    MOTEUR_REPARATION = "reparation"
    MOTEUR_CHOICES = [
        (MOTEUR_TRES_BON, "Tres bon"),
        (MOTEUR_BON, "Bon"),
        (MOTEUR_REPARATION, "Roule, reparation mineure a prevoir"),
    ]

    category = models.ForeignKey(
        VehicleCategory,
        on_delete=models.CASCADE,
        related_name="vehicles",
        null=True,
        blank=True
    )
    title = models.CharField(max_length=120)
    description = models.TextField(blank=True, null=True)
    price = models.DecimalField(max_digits=10, decimal_places=2)
    status = models.CharField(
        max_length=20,
        choices=STATUS_CHOICES,
        default=STATUS_AVAILABLE
    )
    carrosserie = models.CharField(
        max_length=20,
        choices=CARROSSERIE_CHOICES,
        blank=True,
        default=""
    )
    moteur = models.CharField(
        max_length=20,
        choices=MOTEUR_CHOICES,
        blank=True,
        default=""
    )
    condition_notes = models.TextField(blank=True, default="")
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        indexes = [
            models.Index(fields=["status"]),
            models.Index(fields=["price"]),
            models.Index(fields=["created_at"]),
        ]

    def __str__(self):
        return self.title


class VehicleImage(models.Model):
    vehicle = models.ForeignKey(
        Vehicle,
        on_delete=models.CASCADE,
        related_name="images"
    )
    image = models.ImageField(upload_to="vehicles/")
    is_main = models.BooleanField(default=False)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        verbose_name = "Vehicle image"
        verbose_name_plural = "Vehicle images"

    def __str__(self):
        return f"Image de {self.vehicle.title}"


class Favorite(models.Model):
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="favorites",
    )
    vehicle = models.ForeignKey(
        Vehicle,
        on_delete=models.CASCADE,
        related_name="favorited_by",
    )
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        constraints = [
            models.UniqueConstraint(fields=["user", "vehicle"], name="unique_favorite_per_user")
        ]
        ordering = ["-created_at"]

    def __str__(self):
        return f"{self.user.username} → {self.vehicle.title}"


class Review(models.Model):
    vehicle = models.ForeignKey(
        Vehicle,
        on_delete=models.CASCADE,
        related_name="reviews"
    )
    user = models.ForeignKey(
        settings.AUTH_USER_MODEL,
        on_delete=models.CASCADE,
        related_name="vehicle_reviews"
    )
    rating = models.PositiveSmallIntegerField(
        validators=[MinValueValidator(1), MaxValueValidator(5)]
    )
    comment = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    class Meta:
        ordering = ["-created_at"]
        constraints = [
            models.UniqueConstraint(
                fields=["vehicle", "user"],
                name="unique_vehicle_review_per_user",
            ),
        ]
        indexes = [
            models.Index(fields=["vehicle", "created_at"]),
        ]

    def __str__(self):
        return f"Avis de {self.user.username} sur {self.vehicle.title}"
