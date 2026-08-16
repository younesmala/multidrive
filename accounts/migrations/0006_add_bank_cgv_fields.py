from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("accounts", "0005_add_ban_fields"),
    ]

    operations = [
        migrations.AddField(
            model_name="accountstatus",
            name="bank_iban",
            field=models.CharField(blank=True, default="", max_length=34),
        ),
        migrations.AddField(
            model_name="accountstatus",
            name="bank_holder",
            field=models.CharField(blank=True, default="", max_length=100),
        ),
        migrations.AddField(
            model_name="accountstatus",
            name="accepted_cgv",
            field=models.BooleanField(default=False),
        ),
    ]
