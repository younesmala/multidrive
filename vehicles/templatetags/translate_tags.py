import hashlib

from django import template
from django.core.cache import cache

from config.translate import translate_text

register = template.Library()


@register.filter
def autotranslate(text, lang):
    """Traduit automatiquement un texte FR vers la langue cible si besoin.
    Met en cache le résultat pour éviter des appels répétés à l'API.
    Usage : {{ message|autotranslate:request.LANGUAGE_CODE }}
    """
    if not text or not text.strip():
        return text
    if not lang or lang == "fr":
        return text

    cache_key = "autotrans_" + lang + "_" + hashlib.md5(text.encode()).hexdigest()
    cached = cache.get(cache_key)
    if cached is not None:
        return cached

    translated = translate_text(text, source="fr", target=lang, timeout=5)
    result = translated if translated else text
    cache.set(cache_key, result, timeout=86400)  # cache 24h
    return result
