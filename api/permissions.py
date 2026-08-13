from rest_framework.permissions import BasePermission, SAFE_METHODS


class IsAdminOrReadOnly(BasePermission):
    """Lecture publique, ecriture staff uniquement."""
    def has_permission(self, request, view):
        if request.method in SAFE_METHODS:
            return True
        return request.user and request.user.is_staff


class IsAdminOrCreateOnly(BasePermission):
    """POST public (formulaire contact), tout le reste staff uniquement."""
    def has_permission(self, request, view):
        if request.method == "POST":
            return True
        return request.user and request.user.is_staff


class IsAdminWriteOrAuthenticatedRead(BasePermission):
    """Lecture : utilisateur connecte (donnees filtrees par get_queryset).
    Ecriture : staff uniquement (paiements et factures crees par le systeme)."""
    def has_permission(self, request, view):
        if not request.user or not request.user.is_authenticated:
            return False
        if request.method in SAFE_METHODS:
            return True
        return request.user.is_staff
