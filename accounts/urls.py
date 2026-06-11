from django.urls import path

from . import views


app_name = "accounts"

urlpatterns = [
    path("admin-dashboard/", views.admin_dashboard, name="admin_dashboard"),
    path("login/", views.AccountLoginView.as_view(), name="login"),
    path("logout/", views.logout_view, name="logout"),
    path("register/", views.register, name="register"),
    path("profile/", views.profile, name="profile"),
    path("payments/", views.payment_list, name="payment_list"),
    path("change-password/", views.change_password, name="change_password"),
    path("delete-request/", views.delete_request, name="delete_request"),
    path("delete-request/done/", views.delete_request_done, name="delete_request_done"),
]
