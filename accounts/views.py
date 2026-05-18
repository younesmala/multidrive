from django.contrib.auth import login, logout
from django.contrib.auth.decorators import login_required
from django.contrib.auth.views import LoginView
from django.shortcuts import redirect, render

from payments.models import Payment
from reservations.models import Reservation

from .forms import RegisterForm


class AccountLoginView(LoginView):
    template_name = "accounts/login.html"
    redirect_authenticated_user = True


def register(request):
    if request.user.is_authenticated:
        return redirect("home")

    if request.method == "POST":
        form = RegisterForm(request.POST)
        if form.is_valid():
            user = form.save(commit=False)
            user.email = form.cleaned_data["email"]
            user.save()
            login(request, user)
            return redirect("home")
    else:
        form = RegisterForm()

    return render(request, "accounts/register.html", {"form": form})


def logout_view(request):
    logout(request)
    return redirect("home")


@login_required
def profile(request):
    reservations = Reservation.objects.filter(user=request.user)
    payments = Payment.objects.filter(reservation__user=request.user)

    context = {
        "reservation_count": reservations.count(),
        "payment_count": payments.count(),
        "paid_payment_count": payments.filter(status=Payment.STATUS_PAID).count(),
    }
    return render(request, "accounts/profile.html", context)


@login_required
def payment_list(request):
    payments = (
        Payment.objects.select_related("reservation", "reservation__vehicle")
        .filter(reservation__user=request.user)
        .order_by("-created_at")
    )
    return render(request, "accounts/payment_list.html", {"payments": payments})
