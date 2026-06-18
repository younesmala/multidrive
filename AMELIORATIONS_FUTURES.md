# MultiDrive — Ameliorations futures

Liste des fonctionnalites non implementees dans le cadre du TFE,
a developper dans une version post-release.

---

## Priorite haute (valeur utilisateur directe)

### 1. Traduction complete NL et EN
- Creer les fichiers de traduction `.po` / `.mo` pour le neerlandais et l'anglais
- Traduire toutes les chaines visibles : menus, formulaires, messages, emails, PDF
- Outils : `django-admin makemessages` + Poedit ou DeepL API
- Note : le mecanisme Django i18n est deja en place (LocaleMiddleware, LANGUAGES, switcher)

### 2. Newsletter / emails marketing
- Permettre aux visiteurs de s'inscrire a une newsletter
- Envoyer des emails periodiques : nouveaux vehicules, promotions, actualites
- Outils possibles : Mailchimp, Brevo (ex-SendinBlue) ou solution Django maison
- RGPD : consentement explicite requis, lien de desinscription obligatoire

### 3. Webhook Stripe
- Implementer un endpoint `/paiement/webhook/` pour recevoir les evenements Stripe
- Gerer : `checkout.session.completed`, `payment_intent.payment_failed`, `charge.refunded`
- Avantage : plus robuste que la verification sur success_url (gere les cas ou l'utilisateur ferme la page)
- Note : necessite de configurer le webhook dans le dashboard Stripe et de verifier la signature

### 4. Recherche avancee et filtres multiples
- Permettre de filtrer par prix min/max, annee, note, plusieurs categories a la fois
- Ajouter un tri par note, par date d'ajout, par prix croissant/decroissant
- Moteur de recherche full-text sur titre + description

---

## Priorite moyenne

### 5. Espace admin ameliore
- Statistiques graphiques : revenus par mois, reservations par categorie, taux d'annulation
- Export CSV des reservations et paiements
- Historique des actions admin (audit log)

### 6. Systeme de favoris
- Permettre aux membres de mettre des vehicules en favoris
- Page "Mes favoris" dans l'espace membre
- Notification si un vehicule favori change de statut

### 7. Messagerie interne membre-admin
- Fil de discussion lie a une reservation specifique
- Alternatives : enrichir le systeme de contact existant avec des threads

### 8. Galerie admin pour les vehicules
- Interface admin pour uploader/supprimer des images directement depuis le dashboard custom
- Drag-and-drop pour reordonner les images

### 9. Migration vers PostgreSQL
- Remplacer SQLite par PostgreSQL pour la production
- Meilleure gestion des concurrences, des transactions, des performances
- Compatible Heroku, Railway, Supabase

---

## Priorite basse (evolution technique)

### 10. Deploiement en production
- Configurer DEBUG=False, ALLOWED_HOSTS, STATIC_ROOT, collectstatic
- Choisir un hebergeur : Railway, Render, PythonAnywhere, VPS
- Configurer un nom de domaine
- Certificat SSL (Let's Encrypt)

### 11. Frontend React (API-first)
- Consommer l'API REST existante depuis un frontend React ou Vue.js
- L'API JWT est deja en place pour supporter ce scenario
- Avantage : separation claire frontend/backend, application mobile possible

### 12. Application mobile
- API REST + JWT deja prete
- Developper une app React Native ou Flutter consommant l'API MultiDrive

### 13. Notifications temps reel (WebSockets)
- Remplacer le systeme de bulles rouges par des notifications push via Django Channels
- L'utilisateur est notifie sans avoir a rafraichir la page

### 14. Rotation des tokens JWT
- Activer le refresh token rotation dans simplejwt
- Ameliore la securite des sessions API longues

### 15. Tests automatises
- Tests unitaires sur les modeles et les vues critiques (pytest-django)
- Tests d'integration sur le workflow reservation -> paiement -> PDF
- CI/CD via GitHub Actions

---

## Deja mentionne comme "en cours" dans la banniere langue

- Traduction neerlandaise complete (NL) → voir point 1
- Traduction anglaise complete (EN) → voir point 1

---

*Ce document sert de roadmap pour les versions futures de MultiDrive.*
*Les points 1 a 4 sont les plus pertinents a mentionner a l'oral du TFE comme "perspectives d'evolution".*
