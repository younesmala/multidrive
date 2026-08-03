from django.urls import path

from . import views


app_name = "vehicles"

urlpatterns = [
    path("", views.vehicle_list, name="vehicle_list"),
    path("favoris/", views.my_favorites, name="my_favorites"),
    path("<int:vehicle_id>/", views.vehicle_detail, name="vehicle_detail"),
    path("<int:vehicle_id>/review/", views.add_review, name="add_review"),
    path("<int:vehicle_id>/favori/", views.toggle_favorite, name="toggle_favorite"),
    path("cgv/", views.cgv, name="cgv"),
]
