from django.contrib import admin

from config.translate import auto_translate

from .models import Vehicle, VehicleCategory, VehicleImage


class VehicleImageInline(admin.TabularInline):
    model = VehicleImage
    extra = 1


@admin.register(VehicleCategory)
class VehicleCategoryAdmin(admin.ModelAdmin):
    list_display = ("name", "slug", "created_at")
    search_fields = ("name", "slug")
    prepopulated_fields = {"slug": ("name",)}
    ordering = ("name",)


@admin.register(Vehicle)
class VehicleAdmin(admin.ModelAdmin):
    list_display = ("title", "category", "price", "status", "carrosserie", "moteur", "created_at")
    list_filter = ("status", "category", "carrosserie", "moteur")
    search_fields = ("title", "description")
    ordering = ("title",)
    inlines = [VehicleImageInline]

    def save_model(self, request, obj, form, change):
        if obj.description and (not obj.description_en or not obj.description_nl):
            en, nl = auto_translate(obj.description)
            if not obj.description_en:
                obj.description_en = en
            if not obj.description_nl:
                obj.description_nl = nl
        super().save_model(request, obj, form, change)

    fieldsets = (
        (None, {
            "fields": ("category", "title", "price", "status")
        }),
        ("Description (FR)", {
            "fields": ("description",),
        }),
        ("Description (EN)", {
            "fields": ("description_en",),
        }),
        ("Description (NL)", {
            "fields": ("description_nl",),
        }),
        ("Etat du vehicule", {
            "fields": ("carrosserie", "moteur", "condition_notes"),
            "description": "Renseignez l'etat de la carrosserie, du moteur, et ajoutez un commentaire si necessaire.",
        }),
    )


@admin.register(VehicleImage)
class VehicleImageAdmin(admin.ModelAdmin):
    list_display = ("vehicle", "image", "is_main", "created_at")
    list_filter = ("is_main", "created_at")
    search_fields = ("vehicle__title",)


