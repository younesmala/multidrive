from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("payments", "0012_add_admin_reply_testimonial"),
    ]

    operations = [
        migrations.AddField(
            model_name="payment",
            name="refund_reason",
            field=models.TextField(blank=True, default=""),
        ),
    ]
