from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('payments', '0008_add_testimonial'),
    ]

    operations = [
        migrations.AlterField(
            model_name='testimonial',
            name='is_visible',
            field=models.BooleanField(default=False),
        ),
    ]
