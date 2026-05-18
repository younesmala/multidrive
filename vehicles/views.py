from django.contrib.auth.decorators import login_required
from django.shortcuts import get_object_or_404, redirect, render
from django.db.models import Avg

from .forms import ReviewForm
from .models import Review, Vehicle, VehicleCategory


def attach_main_images(vehicles):
    for vehicle in vehicles:
        vehicle.main_image = (
            vehicle.images.filter(is_main=True).first()
            or vehicle.images.first()
        )
    return vehicles


def home(request):
    latest_vehicles = attach_main_images(
        Vehicle.objects.select_related("category")
        .prefetch_related("images")
        .filter(status=Vehicle.STATUS_AVAILABLE)
        .order_by("-created_at")[:8]
    )
    categories = VehicleCategory.objects.order_by("name")

    return render(
        request,
        "vehicles/home.html",
        {
            "latest_vehicles": latest_vehicles,
            "categories": categories,
        },
    )


def vehicle_list(request):
    selected_category = request.GET.get("category")
    selected_status = request.GET.get("status", Vehicle.STATUS_AVAILABLE)

    vehicles = (
        Vehicle.objects.select_related("category")
        .prefetch_related("images")
        .order_by("price", "title")
    )

    if selected_category:
        vehicles = vehicles.filter(category__slug=selected_category)

    if selected_status:
        vehicles = vehicles.filter(status=selected_status)

    vehicles = attach_main_images(vehicles)
    categories = VehicleCategory.objects.order_by("name")

    return render(
        request,
        "vehicles/vehicle_list.html",
        {
            "vehicles": vehicles,
            "categories": categories,
            "selected_category": selected_category,
            "selected_status": selected_status,
            "status_choices": Vehicle.STATUS_CHOICES,
        },
    )


def vehicle_detail(request, vehicle_id):
    vehicle = get_object_or_404(
        Vehicle.objects.select_related("category").prefetch_related("images", "reviews__user"),
        id=vehicle_id,
    )
    reviews = vehicle.reviews.select_related("user").all()
    review_stats = reviews.aggregate(average_rating=Avg("rating"))
    user_review = None
    review_form = None

    if request.user.is_authenticated:
        user_review = reviews.filter(user=request.user).first()
        review_form = ReviewForm(instance=user_review)

    related_vehicles = attach_main_images(
        Vehicle.objects.select_related("category")
        .prefetch_related("images")
        .filter(category=vehicle.category, status=Vehicle.STATUS_AVAILABLE)
        .exclude(id=vehicle.id)
        .order_by("price")[:4]
    )

    return render(
        request,
        "vehicles/vehicle_detail.html",
        {
            "vehicle": vehicle,
            "images": vehicle.images.all(),
            "reviews": reviews,
            "review_form": review_form,
            "user_review": user_review,
            "review_count": reviews.count(),
            "average_rating": review_stats["average_rating"],
            "related_vehicles": related_vehicles,
        },
    )


@login_required
def add_review(request, vehicle_id):
    vehicle = get_object_or_404(Vehicle, id=vehicle_id)
    review = Review.objects.filter(vehicle=vehicle, user=request.user).first()

    if request.method == "POST":
        form = ReviewForm(request.POST, instance=review)
        if form.is_valid():
            review = form.save(commit=False)
            review.vehicle = vehicle
            review.user = request.user
            review.save()

    return redirect("vehicles:vehicle_detail", vehicle_id=vehicle.id)
