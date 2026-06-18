from django.urls import path

from . import views

app_name = "payments"

urlpatterns = [
    path("paiement/", views.checkout, name="checkout"),
    path("paiement/success/", views.stripe_success, name="stripe_success"),
    path("paiement/cancel/", views.stripe_cancel, name="stripe_cancel"),
    path("paiement/<int:payment_id>/facture.pdf", views.download_facture, name="download_facture"),
    path("paiement/<int:payment_id>/cession.pdf", views.download_cession, name="download_cession"),
]
