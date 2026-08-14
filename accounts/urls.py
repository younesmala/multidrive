from django.contrib.auth import views as auth_views
from django.urls import path

from . import views


app_name = "accounts"

urlpatterns = [
    path("admin-dashboard/", views.admin_dashboard, name="admin_dashboard"),
    path("login/", views.AccountLoginView.as_view(), name="login"),
    path("logout/", views.logout_view, name="logout"),
    path("password-reset/", auth_views.PasswordResetView.as_view(
        template_name="accounts/password_reset_form.html",
        email_template_name="accounts/password_reset_email.txt",
        html_email_template_name="accounts/password_reset_email.html",
        subject_template_name="accounts/password_reset_subject.txt",
        success_url="/accounts/password-reset/done/",
    ), name="password_reset"),
    path("password-reset/done/", auth_views.PasswordResetDoneView.as_view(
        template_name="accounts/password_reset_done.html",
    ), name="password_reset_done"),
    path("password-reset/confirm/<uidb64>/<token>/", auth_views.PasswordResetConfirmView.as_view(
        template_name="accounts/password_reset_confirm.html",
        success_url="/accounts/password-reset/complete/",
    ), name="password_reset_confirm"),
    path("password-reset/complete/", auth_views.PasswordResetCompleteView.as_view(
        template_name="accounts/password_reset_complete.html",
    ), name="password_reset_complete"),
    path("register/", views.register, name="register"),
    path("profile/", views.profile, name="profile"),
    path("payments/", views.payment_list, name="payment_list"),
    path("update-phone/", views.update_phone, name="update_phone"),
    path("change-password/", views.change_password, name="change_password"),
    path("delete-request/", views.delete_request, name="delete_request"),
    path("delete-request/done/", views.delete_request_done, name="delete_request_done"),
    path("refund/<int:payment_id>/process/", views.process_refund, name="process_refund"),
    path("temoignage/<int:testimonial_id>/delete/", views.delete_testimonial, name="delete_testimonial"),
    path("temoignage/<int:testimonial_id>/valider/", views.validate_testimonial, name="validate_testimonial"),
    path("temoignage/<int:testimonial_id>/repondre/", views.reply_testimonial, name="reply_testimonial"),
    path("export/stats.csv", views.export_stats_csv, name="export_stats_csv"),
    path("export/historique.csv", views.export_history_csv, name="export_history_csv"),
    path("admins/create/", views.create_admin, name="create_admin"),
    path("admins/<int:user_id>/demote/", views.demote_admin, name="demote_admin"),
    path("admins/<int:user_id>/deactivate/", views.deactivate_admin, name="deactivate_admin"),
]
