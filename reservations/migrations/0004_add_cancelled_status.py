from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('reservations', '0003_reservation_user_status_read'),
    ]

    operations = [
        migrations.AlterField(
            model_name='reservation',
            name='status',
            field=models.CharField(choices=[('pending', 'En attente'), ('accepted', 'Acceptee'), ('rejected', 'Refusee'), ('deposit_paid', 'Acompte paye'), ('cancelled', 'Annulee')], default='pending', max_length=20),
        ),
    ]
