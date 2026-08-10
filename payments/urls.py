from django.urls import path

from . import views

app_name = "payments"

urlpatterns = [
    path("paiement/", views.checkout, name="checkout"),
    path("paiement/success/", views.stripe_success, name="stripe_success"),
    path("paiement/cancel/", views.stripe_cancel, name="stripe_cancel"),
    path("paiement/<int:payment_id>/recu-acompte.pdf",  views.download_recu_acompte, name="download_recu_acompte"),
    path("paiement/<int:payment_id>/facture.pdf",       views.download_facture,      name="download_facture"),
    path("paiement/<int:payment_id>/cession.pdf",       views.download_cession,      name="download_cession"),
    path("paiement/<int:payment_id>/specimen.pdf",      views.download_specimen,     name="download_specimen"),
    path("paiement/<int:payment_id>/temoignage/",       views.add_testimonial,        name="add_testimonial"),
    path("temoignages/", views.testimonial_list, name="testimonial_list"),
]
