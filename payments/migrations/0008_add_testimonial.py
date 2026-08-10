from django.conf import settings
from django.core.validators import MaxValueValidator, MinValueValidator
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    dependencies = [
        ("payments", "0007_add_refund_fields"),
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name="Testimonial",
            fields=[
                ("id", models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name="ID")),
                ("rating", models.PositiveSmallIntegerField(validators=[MinValueValidator(1), MaxValueValidator(5)])),
                ("comment", models.TextField()),
                ("is_visible", models.BooleanField(default=True)),
                ("created_at", models.DateTimeField(auto_now_add=True)),
                ("payment", models.OneToOneField(on_delete=django.db.models.deletion.CASCADE, related_name="testimonial", to="payments.payment")),
                ("user", models.ForeignKey(on_delete=django.db.models.deletion.CASCADE, related_name="testimonials", to=settings.AUTH_USER_MODEL)),
            ],
            options={
                "verbose_name": "Temoignage",
                "verbose_name_plural": "Temoignages",
                "ordering": ["-created_at"],
            },
        ),
    ]
