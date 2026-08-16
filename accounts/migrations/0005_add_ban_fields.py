from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ("accounts", "0004_accountstatus_phone"),
    ]

    operations = [
        migrations.AddField(
            model_name="accountstatus",
            name="no_show_count",
            field=models.PositiveSmallIntegerField(default=0),
        ),
        migrations.AddField(
            model_name="accountstatus",
            name="banned_until",
            field=models.DateTimeField(blank=True, null=True),
        ),
    ]
