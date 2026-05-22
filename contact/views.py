from django.contrib.auth.decorators import login_required
from django.shortcuts import redirect, render

from .forms import ContactMessageForm
from .models import ContactMessage


def contact_form(request):
    initial = {}
    if request.user.is_authenticated:
        initial = {
            "full_name": request.user.get_username(),
            "email": request.user.email,
        }

    if request.method == "POST":
        form = ContactMessageForm(request.POST)
        if form.is_valid():
            contact_message = form.save(commit=False)
            if request.user.is_authenticated:
                contact_message.user = request.user
            contact_message.save()
            request.session["contact_subject"] = contact_message.subject
            return redirect("contact:contact_success")
    else:
        form = ContactMessageForm(initial=initial)

    return render(request, "contact/contact_form.html", {"form": form})


def contact_success(request):
    subject = request.session.pop("contact_subject", None)
    return render(request, "contact/contact_success.html", {"subject": subject})


@login_required
def my_messages(request):
    messages = ContactMessage.objects.filter(user=request.user).order_by("-created_at")
    messages.filter(admin_response__gt="", user_response_read=False).update(user_response_read=True)
    return render(request, "contact/my_messages.html", {"messages": messages})
