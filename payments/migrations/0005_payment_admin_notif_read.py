from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('payments', '0004_payment_user_status_read'),
    ]

    operations = [
        migrations.AddField(
            model_name='payment',
            name='admin_notif_read',
            field=models.BooleanField(default=True),
        ),
    ]
