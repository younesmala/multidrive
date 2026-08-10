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
- Fiches vehicules avec galerie photos, lightbox, note moyenne, vehicules similaires
- Fiche technique detaillee : marque, modele, annee, etat carrosserie (tres bon / bon / legerement accidente), etat moteur (tres bon / bon / reparation mineure a prevoir), notes de condition
- Systeme de favoris (etoile AJAX, page "Mes favoris")
- Avis membres : uniquement apres reservation acceptee, un seul avis par vehicule

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

### Administration
- **Dashboard admin** restructure : KPI → fil d'activite cliquable → actions rapides → remboursements → moderation avis → statistiques
- **Fil d'activite** : 10 derniers evenements (paiements, reservations, messages) avec lien direct vers admin Django
- **Statistiques ventes** : revenus totaux, revenus du mois, ventes finalisees, acomptes en cours, vehicules vendus, top categories avec barres de progression
- **Export CSV** des statistiques (revenus + detail des paiements + ventes par categorie)
- **Moderation des avis** : suppression d'un avis directement depuis le dashboard
- **Remboursements** : traitement avec montant + message pour le membre
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

### API REST
- Endpoints : `/api/v1/categories/`, `/api/v1/vehicles/`, `/api/v1/reservations/`, `/api/v1/payments/`, `/api/v1/invoices/`, `/api/v1/reviews/`, `/api/v1/contact-messages/`, `/api/v1/me/`
- Authentification JWT (simplejwt) + session
- Filtres, recherche, tri, pagination (20/page)
- Documentation Swagger : `/api/docs/`

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
- Descriptions vehicules en 3 langues (FR / EN / NL) saisies directement dans l'admin Django
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

# Compiler les fichiers de traduction (apres modification des .po)
..\venv\Scripts\python.exe manage.py compilemessages
```
