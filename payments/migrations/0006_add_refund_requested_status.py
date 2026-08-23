from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('payments', '0005_payment_admin_notif_read'),
    ]

    operations = [
        migrations.AlterField(
            model_name='payment',
            name='status',
            field=models.CharField(choices=[('pending', 'En attente'), ('paid', 'Paye'), ('failed', 'Echoue'), ('refunded', 'Rembourse'), ('refund_requested', 'Remboursement demande')], default='pending', max_length=20),
        ),
    ]
