from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ("vehicles", "0008_add_description_translations"),
    ]

    operations = [
        migrations.DeleteModel(
            name="Review",
        ),
    ]
