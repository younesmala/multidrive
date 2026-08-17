from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("payments", "0013_add_refund_reason"),
    ]

    operations = [
        migrations.AddField(
            model_name="payment",
            name="stripe_refund_id",
            field=models.CharField(blank=True, default="", max_length=50),
        ),
    ]
