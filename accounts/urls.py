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
    path("refund/<int:payment_id>/process/", views.process_refund, name="process_refund"),
    path("review/<int:review_id>/delete/", views.delete_review, name="delete_review"),
    path("export/stats.csv", views.export_stats_csv, name="export_stats_csv"),
    path("admins/create/", views.create_admin, name="create_admin"),
    path("admins/<int:user_id>/demote/", views.demote_admin, name="demote_admin"),
    path("admins/<int:user_id>/deactivate/", views.deactivate_admin, name="deactivate_admin"),
]
