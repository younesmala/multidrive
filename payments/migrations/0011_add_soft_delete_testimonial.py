from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('payments', '0010_testimonial_comment_translations'),
    ]

    operations = [
        migrations.AddField(
            model_name='testimonial',
            name='deleted_at',
            field=models.DateTimeField(blank=True, null=True),
        ),
        migrations.AddField(
            model_name='testimonial',
            name='is_deleted',
            field=models.BooleanField(default=False),
        ),
    ]
