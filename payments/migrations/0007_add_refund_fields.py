from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('payments', '0006_add_refund_requested_status'),
    ]

    operations = [
        migrations.AddField(
            model_name='payment',
            name='refund_amount',
            field=models.DecimalField(blank=True, decimal_places=2, max_digits=10, null=True),
        ),
        migrations.AddField(
            model_name='payment',
            name='refund_note',
            field=models.TextField(blank=True, null=True),
        ),
    ]
