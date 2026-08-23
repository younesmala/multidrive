from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('payments', '0009_testimonial_pending_by_default'),
    ]

    operations = [
        migrations.AddField(
            model_name='testimonial',
            name='comment_en',
            field=models.TextField(blank=True, default=''),
        ),
        migrations.AddField(
            model_name='testimonial',
            name='comment_nl',
            field=models.TextField(blank=True, default=''),
        ),
    ]
