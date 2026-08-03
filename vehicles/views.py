from django.contrib import messages
from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.db.models import Avg
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.views.decorators.http import require_POST

from .forms import ReviewForm
from .models import Favorite, Review, Vehicle, VehicleCategory
from reservations.models import Reservation


def attach_main_images(vehicles):
    for vehicle in vehicles:
        vehicle.main_image = (
            vehicle.images.filter(is_main=True).first()
            or vehicle.images.first()
        )
        vehicle.display_year = extract_vehicle_year(vehicle.title)
        vehicle.deposit_amount = round(float(vehicle.price) * 0.2, 2)
    return vehicles


def extract_vehicle_year(title):
    for token in reversed(title.split()):
        if token.isdigit() and len(token) == 4:
            return token
    return "N/A"


def cgv(request):
    return render(request, "vehicles/cgv.html")


def _attach_favorites(vehicles, user):
    if user.is_authenticated:
        ids = set(Favorite.objects.filter(user=user).values_list("vehicle_id", flat=True))
    else:
        ids = set()
    for v in vehicles:
        v.is_favorite = v.id in ids


def home(request):
    latest_vehicles = list(attach_main_images(
        Vehicle.objects.select_related("category")
        .prefetch_related("images")
        .filter(status=Vehicle.STATUS_AVAILABLE)
        .order_by("-created_at")[:8]
    ))
    popular_vehicles = list(attach_main_images(
        Vehicle.objects.select_related("category")
        .prefetch_related("images")
        .filter(status=Vehicle.STATUS_AVAILABLE)
        .order_by("price", "-created_at")[:4]
    ))
    _attach_favorites(latest_vehicles, request.user)
    _attach_favorites(popular_vehicles, request.user)
    categories = VehicleCategory.objects.order_by("name")

    return render(
        request,
        "vehicles/home.html",
        {
            "latest_vehicles": latest_vehicles,
            "popular_vehicles": popular_vehicles,
            "categories": categories,
            "available_count": Vehicle.objects.filter(status=Vehicle.STATUS_AVAILABLE).count(),
        },
    )


def vehicle_list(request):
    selected_category = request.GET.get("category")
    selected_status = request.GET.get("status", Vehicle.STATUS_AVAILABLE)
    selected_query = request.GET.get("q", "").strip()

    vehicles = (
        Vehicle.objects.select_related("category")
        .prefetch_related("images")
        .order_by("price", "title")
    )

    if selected_category:
        vehicles = vehicles.filter(category__slug=selected_category)

    if selected_status:
        vehicles = vehicles.filter(status=selected_status)

    if selected_query:
        vehicles = vehicles.filter(title__icontains=selected_query)

    paginator = Paginator(vehicles, 12)
    page_number = request.GET.get("page")
    page_obj = paginator.get_page(page_number)
    attach_main_images(page_obj.object_list)
    _attach_favorites(page_obj.object_list, request.user)

    categories = VehicleCategory.objects.order_by("name")

    return render(
        request,
        "vehicles/vehicle_list.html",
        {
            "vehicles": page_obj.object_list,
            "page_obj": page_obj,
            "categories": categories,
            "selected_category": selected_category,
            "selected_status": selected_status,
            "selected_query": selected_query,
            "status_choices": Vehicle.STATUS_CHOICES,
        },
    )


def vehicle_detail(request, vehicle_id):
    vehicle = get_object_or_404(
        Vehicle.objects.select_related("category").prefetch_related("images", "reviews__user"),
        id=vehicle_id,
    )
    return render(
        request,
        "vehicles/vehicle_detail.html",
        build_vehicle_detail_context(request, vehicle),
    )


@login_required
def add_review(request, vehicle_id):
    vehicle = get_object_or_404(Vehicle, id=vehicle_id)
    review = Review.objects.filter(vehicle=vehicle, user=request.user).first()
    review_form = ReviewForm(request.POST or None, instance=review)
    can_review = user_can_review_vehicle(request.user, vehicle, existing_review=review)

    if not can_review:
        messages.warning(
            request,
            "Vous devez avoir une reservation acceptee sur ce vehicule avant de laisser un avis.",
        )
        return redirect("vehicles:vehicle_detail", vehicle_id=vehicle.id)

    if request.method == "POST":
        if review_form.is_valid():
            review = review_form.save(commit=False)
            review.vehicle = vehicle
            review.user = request.user
            review.save()
            messages.success(request, "Votre avis a bien ete enregistre.")
            return redirect("vehicles:vehicle_detail", vehicle_id=vehicle.id)

        messages.error(request, "Merci de corriger le formulaire avant de publier votre avis.")

    return render(
        request,
        "vehicles/vehicle_detail.html",
        build_vehicle_detail_context(request, vehicle, review_form=review_form),
    )


def build_vehicle_detail_context(request, vehicle, review_form=None):
    reviews = vehicle.reviews.select_related("user").all()
    review_stats = reviews.aggregate(average_rating=Avg("rating"))
    user_review = None
    can_review = False
    review_gate_message = ""

    images = list(vehicle.images.all().order_by("-is_main", "created_at"))
    vehicle.main_image = next((image for image in images if image.is_main), images[0] if images else None)
    vehicle.display_year = extract_vehicle_year(vehicle.title)
    vehicle.deposit_amount = round(float(vehicle.price) * 0.2, 2)

    if request.user.is_authenticated:
        user_review = reviews.filter(user=request.user).first()
        can_review = user_can_review_vehicle(request.user, vehicle, existing_review=user_review)
        vehicle.is_favorite = Favorite.objects.filter(user=request.user, vehicle=vehicle).exists()

        if review_form is None and can_review:
            review_form = ReviewForm(instance=user_review)

        if not can_review:
            review_gate_message = (
                "Vous pourrez laisser un avis apres une reservation acceptee sur ce vehicule."
            )
    else:
        vehicle.is_favorite = False
        review_gate_message = "Connectez-vous pour laisser un avis sur ce vehicule."

    related_vehicles = attach_main_images(
        Vehicle.objects.select_related("category")
        .prefetch_related("images")
        .filter(category=vehicle.category, status=Vehicle.STATUS_AVAILABLE)
        .exclude(id=vehicle.id)
        .order_by("price")[:4]
    )

    return {
        "vehicle": vehicle,
        "images": images,
        "reviews": reviews,
        "review_form": review_form,
        "user_review": user_review,
        "can_review": can_review,
        "review_gate_message": review_gate_message,
        "review_count": reviews.count(),
        "average_rating": review_stats["average_rating"],
        "related_vehicles": related_vehicles,
    }


@login_required
@require_POST
def toggle_favorite(request, vehicle_id):
    vehicle = get_object_or_404(Vehicle, id=vehicle_id)
    fav, created = Favorite.objects.get_or_create(user=request.user, vehicle=vehicle)
    if not created:
        fav.delete()
        is_favorite = False
    else:
        is_favorite = True
    return JsonResponse({"is_favorite": is_favorite})


@login_required
def my_favorites(request):
    favs = (
        Favorite.objects.filter(user=request.user)
        .select_related("vehicle", "vehicle__category")
        .prefetch_related("vehicle__images")
    )
    vehicles = []
    for fav in favs:
        fav.vehicle.is_favorite = True
        vehicles.append(fav.vehicle)
    attach_main_images(vehicles)
    return render(request, "vehicles/my_favorites.html", {"vehicles": vehicles})


def user_can_review_vehicle(user, vehicle, existing_review=None):
    if existing_review:
        return True

    return Reservation.objects.filter(
        user=user,
        vehicle=vehicle,
        status__in=[
            Reservation.STATUS_ACCEPTED,
            Reservation.STATUS_DEPOSIT_PAID,
        ],
    ).exists()
