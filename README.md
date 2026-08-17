# MultiDrive

Plateforme web de vente de vehicules d'occasion, realisee dans le cadre d'un Travail de Fin d'Etudes (TFE). MultiDrive couvre un large spectre de vehicules accessibles : velos, trottinettes, scooters, motos legeres, citadines et petits utilitaires.

## Stack technique

| Categorie | Technologie |
|---|---|
| Backend | Django 6.0.4 (Python 3.14) |
| Frontend | Bootstrap 5.3 + CSS sur mesure (Poppins, #1E3A8A) + Font Awesome 6.5 |
| Base de donnees | SQLite (dev) |
| Paiement | Stripe Checkout (PCI-DSS, hosted page) |
| PDF | xhtml2pdf |
| Email | Django SMTP (Gmail — multidrive25@gmail.com) |
| API | Django REST Framework + JWT (simplejwt) + Swagger (drf-spectacular) |
| Filtres API | django-filter |
| Images | Pillow |

## Fonctionnalites implementees

### Catalogue et fiches vehicules
- Catalogue avec filtres (categorie, statut, recherche texte) et pagination (12 vehicules/page)
- Fiches vehicules avec galerie photos, lightbox, vehicules similaires
- Fiche technique detaillee : marque, modele, annee, etat carrosserie (tres bon / bon / legerement accidente), etat moteur (tres bon / bon / reparation mineure a prevoir), notes de condition
- Systeme de favoris (etoile AJAX, page "Mes favoris")

### Parcours membre complet
- Inscription / connexion / deconnexion
- Changement de mot de passe depuis le profil
- Reinitialisation du mot de passe par email (lien Gmail, valable 24h)
- Profil, suppression de compte (soft delete)
- Notifications en temps reel (bulles rouges) pour reservations et paiements
- Mes reservations, Paiements et achats, Mes messages, Mes favoris

### Reservation
- Demande de reservation avec creneau horaire (validation metier semaine/weekend)
- Workflow : pending → accepted / rejected → deposit_paid → cancelled
- Annulation a 3 niveaux (libre, libre, ou avec demande de remboursement)
- Email HTML de confirmation automatique a chaque reservation (Gmail SMTP)

### Paiement Stripe
- Acompte : 20 % du prix (min 20 EUR, max 250 EUR)
- Paiement du solde restant depuis l'espace membre
- Redirection vers Stripe Checkout (hosted page, PCI-DSS)
- Confirmation et mise a jour automatique apres paiement (session_id)
- Protection anti-doublon via session_id Stripe

### Documents PDF (telechargement depuis espace membre)
- **Recu d'acompte** : disponible apres tout paiement confirme (meme partiel)
- **Facture finale** : disponible uniquement apres paiement integral
- **Acte de cession** : disponible uniquement apres paiement integral
- **Specimen d'immatriculation** : document pedagogique rose, disponible apres paiement integral
- Signature MultiDrive integree en base64 sur tous les documents
- Generation via xhtml2pdf, telechargement direct sans stockage serveur

### Temoignages clients
- Page publique `/temoignages/` accessible a tous (visiteurs et membres), lien dans nav et footer
- Formulaire de temoignage declenche depuis "Paiements et achats" uniquement apres paiement integral
- Un seul temoignage par achat (OneToOneField Payment → Testimonial)
- **Moderation** : tout nouveau temoignage est en attente (`is_visible=False`) jusqu'a validation admin
- Dashboard admin : section "En attente" (fond jaune, bouton Publier/Supprimer) + section "Publies"
- **Traduction automatique** : a la soumission, l'avis est traduit FR→EN et FR→NL via l'API MyMemory (gratuite, sans cle) et stocke dans `comment_en` / `comment_nl`
- Affichage dynamique selon la langue active du visiteur

### Administration
- **Dashboard admin** restructure : KPI → fil d'activite cliquable → actions rapides → remboursements → moderation temoignages → statistiques
- **Fil d'activite** : 10 derniers evenements (paiements, reservations, messages) avec lien direct vers admin Django
- **Statistiques ventes** : revenus totaux, revenus du mois, ventes finalisees, acomptes en cours, vehicules vendus, top categories avec barres de progression
- **Export CSV** des statistiques (revenus + detail des paiements + ventes par categorie)
- **Moderation des temoignages** : validation avant publication, suppression directe depuis le dashboard
- **Remboursements via Stripe** : appel automatique `stripe.Refund.create()` depuis le dashboard — l'argent revient sur la carte originale du membre sans intervention manuelle. Calcul de retenue rapide (0 / 10 / 20 / 30 / 50 %). Badge vert "STRIPE" si paiement Stripe valide, alerte jaune sinon. ID du remboursement (`re_xxx`) stocké en base et visible dans l'historique. Si Stripe échoue (montant dépassé, session expirée), le remboursement est quand même enregistré avec une note d'erreur et un avertissement admin.
- **Gestion des admins (superadmin uniquement)** :
  - Creer un compte administrateur (username, email, mot de passe provisoire)
  - Retirer les droits admin (redevient client)
  - Desactiver un compte admin
  - Protections : impossible de se modifier soi-meme
- Actions rapides avec compteurs en temps reel (reservations en attente, messages sans reponse)

### Roles et securite
- **Visiteur** : consultation catalogue uniquement
- **Client** : inscription publique, parcours reservation/paiement/avis
- **Admin** (is_staff) : acces dashboard, gestion vehicules/reservations/paiements/avis
- **Superadmin** (is_superuser) : tout + creation et gestion des comptes admin
- Toutes les protections appliquees cote backend (decorateurs Django), jamais uniquement cote template

Mesures de securite implementees :
- 4 validateurs de mot de passe Django (longueur, similarite, mots courants, numerique)
- Reset mot de passe par email avec token HMAC a usage unique (24h)
- Blocage connexion compte supprime/banni via `confirm_login_allowed`
- Email unique verifie a l'inscription
- CSRF token sur tous les formulaires POST (`CsrfViewMiddleware`)
- Protection clickjacking (`XFrameOptionsMiddleware`)
- Headers HTTPS securises en production : `SECURE_SSL_REDIRECT`, `SESSION_COOKIE_SECURE`, `CSRF_COOKIE_SECURE`, `SECURE_HSTS_SECONDS`
- Secrets (SECRET_KEY, Stripe, SMTP) lus depuis variables d'environnement, jamais en dur
- Session maintenue apres changement de mot de passe (`update_session_auth_hash`)

### API REST
- Authentification double : **JWT Bearer token** (`POST /api/v1/token/` → access + refresh) et **session Django** (navigateur)
- Renouvellement du token sans reconnexion : `POST /api/v1/token/refresh/`
- Documentation interactive Swagger UI : `/api/docs/`

| Endpoint | Lecture | Ecriture |
|---|---|---|
| `/api/v1/vehicles/` | Publique (sans auth) | Staff only |
| `/api/v1/categories/` | Publique (sans auth) | Staff only |
| `/api/v1/reservations/` | Utilisateur connecte (ses donnees) | Utilisateur connecte |
| `/api/v1/payments/` | Utilisateur connecte (ses donnees) | Staff only |
| `/api/v1/invoices/` | Utilisateur connecte (ses donnees) | Staff only |
| `/api/v1/contact-messages/` | Staff only | Publique (formulaire contact) |
| `/api/v1/me/` | Utilisateur connecte | — |

Permissions custom (3 classes) : `IsAdminOrReadOnly`, `IsAdminOrCreateOnly`, `IsAdminWriteOrAuthenticatedRead`

Isolation des donnees par propriétaire : `get_queryset` filtre automatiquement les reservations, paiements et factures au profil connecte.

Filtres actifs sur les vehicules : `?status=available&category=1&search=peugeot&ordering=-price`

Pagination : 20 resultats par page (`?page=N`)

### Juridique et conformite
- Page Conditions Generales 10 sections (CGV, RGPD, cookies, propriete intellectuelle, Stripe PCI-DSS)
- Bandeau cookies (cookies techniques uniquement, sans tracking)
- Pages d'erreur 404 et 500 personnalisees

### Multilingue
- Switcher FR / NL / EN dans la navbar
- Traduction complete de toutes les pages en anglais et en neerlandais (templates, formulaires, messages flash, pages mot de passe oublie)
- Fichiers .po / .mo compiles pour EN et NL
- Locale Stripe dynamique : la page de paiement Stripe s'affiche dans la langue active
- Documents PDF generes dans la langue active (xhtml2pdf herite du thread-local Django)
- Descriptions vehicules en 3 langues (FR / EN / NL) — traduction automatique via MyMemory si champs EN/NL vides lors de la sauvegarde admin
- Temoignages traduits automatiquement FR→EN et FR→NL via MyMemory a la soumission
- Format date rendezvous traduit (FR : "a", EN : "at", NL : "om")

---

## Lancer le projet en local

```powershell
cd C:\Users\elmal\OneDrive\Desktop\TFE_MultiDrive\multidrive
..\venv\Scripts\python.exe manage.py runserver 127.0.0.1:8001
```

URLs utiles :

```
http://127.0.0.1:8001/          Site principal
http://127.0.0.1:8001/admin/    Administration Django
http://127.0.0.1:8001/api/docs/ Documentation Swagger
```

## Comptes de test

| Role | Username | Password |
|---|---|---|
| Client | Younes | Multidrive1 |
| Superadmin | admin | admin1234 |
| Clients generes (seeder) | client_adam_001 ... | client1234 |

## Variables d'environnement (.env)

```
DJANGO_SECRET_KEY=...
DJANGO_DEBUG=True
DJANGO_ALLOWED_HOSTS=127.0.0.1,localhost
DJANGO_DB_PATH=...
STRIPE_PUBLIC_KEY=pk_test_...
STRIPE_SECRET_KEY=sk_test_...
EMAIL_BACKEND=django.core.mail.backends.smtp.EmailBackend
EMAIL_HOST=smtp.gmail.com
EMAIL_PORT=587
EMAIL_USE_TLS=True
EMAIL_HOST_USER=multidrive25@gmail.com
EMAIL_HOST_PASSWORD=...
DEFAULT_FROM_EMAIL=MultiDrive <multidrive25@gmail.com>
PEXELS_API_KEY=...
```

## Commandes utiles

```powershell
# Verifier le projet
..\venv\Scripts\python.exe manage.py check

# Creer et appliquer les migrations
..\venv\Scripts\python.exe manage.py makemigrations
..\venv\Scripts\python.exe manage.py migrate

# Remplir la base avec des donnees de test
..\venv\Scripts\python.exe manage.py seed_multidrive

# Mettre a jour les descriptions des vehicules
..\venv\Scripts\python.exe manage.py update_descriptions

# Generer des temoignages de demonstration
..\venv\Scripts\python.exe manage.py seed_testimonials

# Generer des donnees de test reservations (acceptees, refusees, remboursees)
..\venv\Scripts\python.exe manage.py seed_test_reservations

# Peupler l'historique du dashboard (comptes supprimes, annulations, remboursements, avis masques)
..\venv\Scripts\python.exe manage.py seed_history

# Nettoyer le dashboard (accepter reservations en attente + repondre aux messages)
..\venv\Scripts\python.exe manage.py cleanup_dashboard

# Compiler les fichiers de traduction (apres modification des .po)
..\venv\Scripts\python.exe manage.py compilemessages
```
