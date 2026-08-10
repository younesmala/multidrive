from django.contrib.auth.decorators import login_required
from django.core.paginator import Paginator
from django.http import JsonResponse
from django.shortcuts import get_object_or_404, redirect, render
from django.views.decorators.http import require_POST

from .models import Favorite, Vehicle, VehicleCategory


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


def extract_vehicle_info(title):
    """Extrait brand, model, year depuis 'Renault Clio 2004 #001'."""
    tokens = [t for t in title.split() if not t.startswith("#")]
    year = None
    for i, token in enumerate(reversed(tokens)):
        if token.isdigit() and len(token) == 4:
            year = token
            tokens = tokens[:len(tokens) - i - 1]
            break
    brand = tokens[0] if tokens else ""
    model = " ".join(tokens[1:]) if len(tokens) > 1 else ""
    return brand, model, year


def vehicle_condition(year_str):
    try:
        y = int(year_str)
    except (TypeError, ValueError):
        return "Bon"
    if y >= 2018:
        return "Tres bon"
    elif y >= 2013:
        return "Bon"
    elif y >= 2008:
        return "Correct"
    else:
        return "D'usage"


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
        Vehicle.objects.select_related("category").prefetch_related("images"),
        id=vehicle_id,
    )
    images = list(vehicle.images.all().order_by("-is_main", "created_at"))
    vehicle.main_image = next((img for img in images if img.is_main), images[0] if images else None)
    vehicle.display_year = extract_vehicle_year(vehicle.title)
    vehicle.deposit_amount = round(float(vehicle.price) * 0.2, 2)
    brand, model, year = extract_vehicle_info(vehicle.title)
    vehicle.display_brand = brand
    vehicle.display_model = model
    vehicle.display_condition = vehicle_condition(year)
    vehicle.is_favorite = (
        Favorite.objects.filter(user=request.user, vehicle=vehicle).exists()
        if request.user.is_authenticated else False
    )
    related_vehicles = attach_main_images(
        Vehicle.objects.select_related("category")
        .prefetch_related("images")
        .filter(category=vehicle.category, status=Vehicle.STATUS_AVAILABLE)
        .exclude(id=vehicle.id)
        .order_by("price")[:4]
    )
    return render(request, "vehicles/vehicle_detail.html", {
        "vehicle": vehicle,
        "images": images,
        "related_vehicles": related_vehicles,
    })


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
