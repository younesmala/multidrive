import requests


def translate_text(text, source="fr", target="en", timeout=5):
    if not text or not text.strip():
        return ""
    try:
        resp = requests.get(
            "https://api.mymemory.translated.net/get",
            params={"q": text, "langpair": f"{source}|{target}"},
            timeout=timeout,
        )
        data = resp.json()
        if data.get("responseStatus") == 200:
            translated = data["responseData"]["translatedText"]
            if translated and translated.upper() != text.upper():
                return translated
    except Exception:
        pass
    return ""


def auto_translate(text_fr):
    """Retourne (text_en, text_nl) traduits depuis le français."""
    return translate_text(text_fr, "fr", "en"), translate_text(text_fr, "fr", "nl")
