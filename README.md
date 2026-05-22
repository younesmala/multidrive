# MultiDrive

Projet Django realise dans le cadre du TFE. MultiDrive est une plateforme de consultation et de reservation de vehicules d'occasion accessibles : velos, trottinettes, scooters, motos legeres et petites voitures.

## Presentation rapide

MultiDrive combine :

- un site web Django ;
- une API REST documentee ;
- une base de donnees relationnelle ;
- une interface d'administration ;
- un parcours membre pour la reservation.

## Technologies utilisees

- Django
- Django REST Framework
- Swagger / OpenAPI via drf-spectacular
- SQLite
- Pillow
- Stripe Checkout (prevu pour l'integration du paiement)

## Fonctionnalites principales

- catalogue de vehicules ;
- detail d'un vehicule ;
- authentification membre ;
- reservations ;
- page de contact ;
- espace membre ;
- paiements (modele et interface prepares) ;
- API REST versionnee ;
- documentation Swagger.

## Lancer le projet en local

Depuis le dossier du projet :

```powershell
cd C:\Users\elmal\OneDrive\Desktop\multidrive\TFE_MultiDrive\multidrive
..\venv\Scripts\python.exe manage.py runserver 127.0.0.1:8001
```

URLs utiles :

```text
http://127.0.0.1:8001/
http://127.0.0.1:8001/admin/
http://127.0.0.1:8001/api/docs/
```

## Comptes de test

Membre :

```text
username: Younes
password: Multidrive1
```

Administrateur :

```text
username: admin
password: admin1234
```

---

# MultiDrive - Suivi de construction de la base de donnees

## 1. Objectif du projet

MultiDrive est un projet Django realise dans le cadre du TFE.

L'objectif du site est de rassembler des vehicules d'occasion accessibles, pas uniquement des voitures. Le projet doit pouvoir gerer plusieurs types de vehicules :

- velos ;
- trottinettes ;
- scooters ;
- motos legeres ;
- voitures citadines ;
- compactes ;
- breaks ;
- petits utilitaires ;
- monospaces ;
- petits SUV.

Le projet est construit en approche **code first** avec Django :

1. On cree les modeles Django en Python.
2. Django genere les migrations.
3. Les migrations construisent la base de donnees.
4. On remplit la base avec des donnees de test realistes.
5. Le dump SQL viendra plus tard, quand la structure et les donnees seront correctes.

Pour le moment, la base utilise SQLite via le fichier :

```text
db.sqlite3
```

---

## 2. Apps Django du projet

Les apps creees dans le projet sont :

```text
accounts
vehicles
reservations
payments
contact
```

Elles sont declarees dans :

```text
multidrive/settings.py
```

Dans `INSTALLED_APPS`, on a ajoute :

```python
'accounts',
'vehicles',
'reservations',
'payments',
'contact',
```

---

## 3. Dependances importantes

Pour gerer les images des vehicules, Django utilise un champ `ImageField`.

Ce champ demande la librairie Python :

```text
Pillow
```

Elle a ete installee avec :

```powershell
..\venv\Scripts\python.exe -m pip install Pillow
```

Version installee au moment du travail :

```text
Pillow 12.2.0
```

---

## 4. Gestion des images

Pour permettre a Django de stocker les images envoyees par l'utilisateur, on a ajoute dans `multidrive/settings.py` :

```python
MEDIA_URL = '/media/'
MEDIA_ROOT = BASE_DIR / 'media'
```

Explication simple :

- `MEDIA_URL` est l'URL utilisee pour acceder aux fichiers uploades.
- `MEDIA_ROOT` est le dossier local ou les fichiers sont stockes.

Dans `multidrive/urls.py`, on a ajoute :

```python
from django.conf import settings
from django.conf.urls.static import static
```

Puis :

```python
if settings.DEBUG:
    urlpatterns += static(settings.MEDIA_URL, document_root=settings.MEDIA_ROOT)
```

Cela permet de consulter les images en mode developpement.

---

## 5. Modeles crees

La structure principale de la base contient maintenant 7 modeles metier :

```text
VehicleCategory
Vehicle
VehicleImage
Reservation
Payment
Invoice
ContactMessage
```

On garde l'utilisateur Django par defaut pour simplifier le projet.

---

## 6. App vehicles

Fichier :

```text
vehicles/models.py
```

### 6.1 VehicleCategory

Ce modele represente une categorie de vehicule.

Exemples :

- Velo ;
- Trottinette ;
- Scooter ;
- Moto legere ;
- Citadine ;
- Compacte.

Champs principaux :

```python
name = models.CharField(max_length=60)
slug = models.SlugField(max_length=120, unique=True)
description = models.TextField(blank=True, null=True)
created_at = models.DateTimeField(auto_now_add=True)
```

Explication :

- `name` : nom visible de la categorie.
- `slug` : version courte unique, utile pour les URLs plus tard.
- `description` : texte facultatif.
- `created_at` : date de creation automatique.

Relation :

```text
VehicleCategory 1 -> N Vehicle
```

Une categorie peut contenir plusieurs vehicules.

---

### 6.2 Vehicle

Ce modele represente un vehicule mis en vente.

Champs principaux :

```python
category = models.ForeignKey(VehicleCategory, ...)
title = models.CharField(max_length=120)
description = models.TextField(blank=True, null=True)
price = models.DecimalField(max_digits=10, decimal_places=2)
status = models.CharField(max_length=20, choices=STATUS_CHOICES, default=STATUS_AVAILABLE)
created_at = models.DateTimeField(auto_now_add=True)
```

Explication :

- `category` : lien vers la categorie du vehicule.
- `title` : nom du vehicule, par exemple `Decathlon Rockrider 340 2016`.
- `description` : description libre.
- `price` : prix avec deux decimales.
- `status` : etat du vehicule.
- `created_at` : date d'ajout automatique.

Statuts prevus :

```text
available
reserved
sold
```

Indexes ajoutes :

```python
models.Index(fields=["status"])
models.Index(fields=["price"])
models.Index(fields=["created_at"])
```

Interet :

- chercher rapidement les vehicules disponibles ;
- filtrer par prix ;
- trier ou filtrer par date d'ajout.

---

### 6.3 VehicleImage

Ce modele represente les images d'un vehicule.

Champs principaux :

```python
vehicle = models.ForeignKey(Vehicle, on_delete=models.CASCADE, related_name="images")
image = models.ImageField(upload_to="vehicles/")
is_main = models.BooleanField(default=False)
created_at = models.DateTimeField(auto_now_add=True)
```

Explication :

- `vehicle` : vehicule auquel l'image appartient.
- `image` : chemin vers l'image.
- `is_main` : indique si c'est l'image principale.
- `created_at` : date d'ajout.

Relation :

```text
Vehicle 1 -> N VehicleImage
```

Un vehicule peut avoir plusieurs images.

Grace a `related_name="images"`, on peut faire :

```python
vehicle.images.all()
```

---

## 7. App reservations

Fichier :

```text
reservations/models.py
```

### 7.1 Reservation

Ce modele represente une reservation faite par un utilisateur pour un vehicule.

Champs principaux :

```python
user = models.ForeignKey(settings.AUTH_USER_MODEL, ...)
vehicle = models.ForeignKey(Vehicle, ...)
status = models.CharField(max_length=20, choices=STATUS_CHOICES, default=STATUS_PENDING)
message = models.TextField(blank=True, null=True)
appointment_date = models.DateTimeField(blank=True, null=True)
created_at = models.DateTimeField(auto_now_add=True)
updated_at = models.DateTimeField(auto_now=True)
```

Explication :

- `user` : utilisateur Django qui fait la reservation.
- `vehicle` : vehicule concerne.
- `status` : statut de la reservation.
- `message` : message facultatif du client.
- `appointment_date` : rendez-vous facultatif.
- `created_at` : date de creation.
- `updated_at` : date de derniere modification.

Statuts prevus :

```text
pending
accepted
rejected
deposit_paid
```

Relation :

```text
User 1 -> N Reservation
Vehicle 1 -> N Reservation
```

Une reservation concerne un seul vehicule.
Un utilisateur peut faire plusieurs reservations.

Le lien vers `Vehicle` utilise :

```python
on_delete=models.PROTECT
```

Cela evite de supprimer un vehicule s'il a deja des reservations. C'est plus coherent pour garder un historique.

Indexes ajoutes :

```python
models.Index(fields=["status"])
models.Index(fields=["created_at"])
```

---

## 8. App payments

Fichier :

```text
payments/models.py
```

### 8.1 Payment

Ce modele represente un paiement d'acompte lie a une reservation.

Champs principaux :

```python
reservation = models.OneToOneField(Reservation, ...)
amount = models.DecimalField(max_digits=10, decimal_places=2)
status = models.CharField(max_length=20, choices=STATUS_CHOICES, default=STATUS_PENDING)
payment_method = models.CharField(max_length=50, blank=True, null=True)
transaction_reference = models.CharField(max_length=120, unique=True, blank=True, null=True)
paid_at = models.DateTimeField(blank=True, null=True)
created_at = models.DateTimeField(auto_now_add=True)
updated_at = models.DateTimeField(auto_now=True)
```

Explication :

- `reservation` : reservation concernee.
- `amount` : montant de l'acompte.
- `status` : statut du paiement.
- `payment_method` : methode de paiement.
- `transaction_reference` : reference unique du paiement.
- `paid_at` : date du paiement.
- `created_at` : date de creation.
- `updated_at` : date de mise a jour.

Statuts prevus :

```text
pending
paid
failed
refunded
```

Relation :

```text
Reservation 1 -> 0 ou 1 Payment
```

On utilise :

```python
models.OneToOneField
```

Parce qu'une reservation peut avoir maximum un paiement d'acompte.

---

### 8.2 Invoice

Ce modele represente une facture liee a un paiement.

Champs principaux :

```python
payment = models.OneToOneField(Payment, ...)
invoice_number = models.CharField(max_length=50, unique=True)
total_amount = models.DecimalField(max_digits=10, decimal_places=2)
vat_amount = models.DecimalField(max_digits=10, decimal_places=2, default=0)
issued_at = models.DateTimeField(auto_now_add=True)
due_date = models.DateField(blank=True, null=True)
notes = models.TextField(blank=True, null=True)
```

Explication :

- `payment` : paiement concerne.
- `invoice_number` : numero de facture unique.
- `total_amount` : montant total facture.
- `vat_amount` : montant TVA.
- `issued_at` : date d'emission.
- `due_date` : date d'echeance facultative.
- `notes` : notes facultatives.

Relation :

```text
Payment 1 -> 0 ou 1 Invoice
```

On utilise aussi :

```python
models.OneToOneField
```

Parce qu'un paiement peut avoir maximum une facture.

---

## 9. App contact

Fichier :

```text
contact/models.py
```

### 9.1 ContactMessage

Ce modele represente un message envoye via un formulaire de contact.

Champs principaux :

```python
full_name = models.CharField(max_length=120)
email = models.EmailField()
phone = models.CharField(max_length=30, blank=True, null=True)
subject = models.CharField(max_length=150)
message = models.TextField()
is_read = models.BooleanField(default=False)
created_at = models.DateTimeField(auto_now_add=True)
```

Explication :

- `full_name` : nom complet.
- `email` : adresse email.
- `phone` : telephone facultatif.
- `subject` : sujet du message.
- `message` : contenu.
- `is_read` : indique si le message a ete lu.
- `created_at` : date d'envoi.

Relation :

```text
ContactMessage est independant
```

Il n'a pas besoin d'etre lie a un vehicule ou a un utilisateur.

---

## 10. Resume des relations

Vue simple des relations principales :

```text
VehicleCategory 1 -> N Vehicle
Vehicle 1 -> N VehicleImage
User 1 -> N Reservation
Vehicle 1 -> N Reservation
Reservation 1 -> 0/1 Payment
Payment 1 -> 0/1 Invoice
ContactMessage independant
```

Explication orale possible :

> Une categorie peut contenir plusieurs vehicules. Chaque vehicule peut avoir plusieurs images. Un utilisateur peut faire plusieurs reservations, et chaque reservation concerne un vehicule. Si la reservation avance, elle peut recevoir un paiement d'acompte. Ce paiement peut ensuite generer une facture. Les messages de contact sont separes du reste, car une personne peut simplement poser une question sans reserver.

---

## 11. Migrations realisees

Les migrations ont ete creees avec :

```powershell
..\venv\Scripts\python.exe manage.py makemigrations
```

Puis appliquees avec :

```powershell
..\venv\Scripts\python.exe manage.py migrate
```

Verification :

```powershell
..\venv\Scripts\python.exe manage.py check
```

Resultat attendu :

```text
System check identified no issues
```

Migrations importantes :

```text
vehicles
0001_initial
0002_vehiclecategory_vehicle_created_at_and_more
0003_vehicleimage
0004_alter_vehiclecategory_options_and_more

reservations
0001_initial
0002_alter_reservation_options_alter_reservation_status

payments
0001_initial
0002_invoice
0003_alter_invoice_options_alter_payment_options

contact
0001_initial
0002_alter_contactmessage_options
```

---

## 12. Probleme rencontre : auto_now_add

Pendant le projet, on a rencontre une erreur avec :

```python
created_at = models.DateTimeField(auto_now_add=True)
```

Django a explique qu'il etait impossible d'ajouter ce champ a une table qui contenait deja des lignes sans donner une valeur par defaut.

Pourquoi ?

La table `Vehicle` existait deja, avec au moins un vehicule. Django devait donc savoir quelle date mettre dans `created_at` pour les anciennes lignes.

Solution utilisee :

```text
Option 1 : Provide a one-off default
Default : timezone.now
```

Cela signifie :

- les anciennes lignes recoivent la date actuelle ;
- les nouvelles lignes utiliseront automatiquement `auto_now_add=True`.

---

## 13. Probleme rencontre : SQLite disk I/O error

On a aussi rencontre plusieurs fois :

```text
sqlite3.OperationalError: disk I/O error
```

Ce probleme ne venait pas directement du code Django.

Cause probable :

- plusieurs serveurs Django `runserver` lances en meme temps ;
- fichier SQLite verrouille ;
- fichier `db.sqlite3-journal` reste actif ;
- projet situe dans OneDrive, qui peut parfois verrouiller les fichiers.

Solution appliquee :

1. Arreter les processus `runserver` en trop.
2. Verifier la base SQLite.
3. Relancer un seul serveur propre.

Commande de verification SQLite utilisee :

```powershell
..\venv\Scripts\python.exe -c "import sqlite3; con=sqlite3.connect('db.sqlite3'); print(con.execute('PRAGMA integrity_check').fetchone()[0]); con.close()"
```

Resultat correct :

```text
ok
```

Conseil :

Toujours eviter d'avoir plusieurs serveurs Django lances sur le meme projet.

---

## 14. Admin Django

Les modeles ont ete enregistres dans l'admin Django :

```text
vehicles/admin.py
reservations/admin.py
payments/admin.py
contact/admin.py
```

L'admin permet de consulter et modifier les tables depuis le navigateur.

URL :

```text
http://127.0.0.1:8001/admin/
```

Compte admin local cree :

```text
username: admin
password: admin1234
```

Important :

Ce mot de passe est uniquement pour le developpement local. Il ne doit pas etre utilise en production.

---

## 15. Comptes de test

Plusieurs comptes existent dans la base.

Compte administrateur :

```text
username: admin
email: admin@multidrive.local
password: admin1234
role: superuser / staff
```

Compte utilisateur cree manuellement :

```text
username: Younes
email: Younes@gmail.com
password: Multidrive1
role: client
```

Note importante :

Le mot de passe du compte `Younes` est note ici parce qu'il a ete communique manuellement. Dans la base de donnees, Django ne stocke pas le mot de passe en clair : il le stocke sous forme securisee, c'est-a-dire hashee. C'est normal et c'est une bonne pratique de securite.

Comptes clients generes par le seeder :

```text
username exemple: client_adam_001
email exemple: client_adam_001@example.com
password: client1234
role: client
```

Le seeder cree 120 comptes clients avec le meme mot de passe de test :

```text
client1234
```

Ces comptes servent uniquement aux donnees de test et au futur dump SQL.

---

## 16. Donnees de test

Une commande Django personnalisee a ete creee pour remplir la base avec des donnees realistes.

Fichier :

```text
vehicles/management/commands/seed_multidrive.py
```

Commande :

```powershell
..\venv\Scripts\python.exe manage.py seed_multidrive
```

La commande cree :

- des categories ;
- des utilisateurs clients ;
- des vehicules ;
- des images de vehicules ;
- des reservations ;
- des paiements ;
- des factures ;
- des messages de contact.

La commande nettoie d'abord les anciennes donnees de test pour eviter les doublons.

Elle conserve le superuser admin.

---

## 17. Donnees actuellement generees

Apres le dernier remplissage, la base contient :

```text
Categories: 10
Vehicles: 150
Vehicle images: 300
Users: 121
Reservations: 150
Payments: 110
Invoices: 105
Contact messages: 120
```

Remarque importante :

- `VehicleCategory` reste a 10 lignes car c'est une table naturellement limitee.
- Les autres tables metier importantes depassent bien les 100 lignes demandees.

Categories presentes :

```text
Velo
Trottinette
Scooter
Moto legere
Citadine
Compacte
Break
Utilitaire leger
Monospace
SUV compact
```

Verification des prix :

```text
Prix minimum: 45 EUR
Prix maximum: 2420 EUR
Vehicules au-dessus de 2500 EUR: 0
```

Cela correspond a l'objectif du projet :

> proposer des vehicules d'occasion accessibles, allant du velo ou de la trottinette a la petite voiture.

---

## 18. Commandes utiles au quotidien

Aller dans le dossier du projet Django :

```powershell
cd C:\Users\elmal\OneDrive\Desktop\multidrive\TFE_MultiDrive\multidrive
```

Verifier le projet :

```powershell
..\venv\Scripts\python.exe manage.py check
```

Creer les migrations :

```powershell
..\venv\Scripts\python.exe manage.py makemigrations
```

Appliquer les migrations :

```powershell
..\venv\Scripts\python.exe manage.py migrate
```

Voir les migrations :

```powershell
..\venv\Scripts\python.exe manage.py showmigrations
```

Remplir la base avec des donnees de test :

```powershell
..\venv\Scripts\python.exe manage.py seed_multidrive
```

Lancer le serveur :

```powershell
..\venv\Scripts\python.exe manage.py runserver
```

Lancer le serveur sans auto-reload :

```powershell
..\venv\Scripts\python.exe manage.py runserver 127.0.0.1:8000 --noreload
```

Le mode `--noreload` peut aider a eviter certains problemes de double processus avec SQLite.

---

## 19. Tests rapides dans le shell Django

Lancer le shell :

```powershell
..\venv\Scripts\python.exe manage.py shell
```

Verifier le nombre de vehicules :

```python
from vehicles.models import Vehicle
Vehicle.objects.count()
```

Verifier les vehicules les moins chers :

```python
Vehicle.objects.order_by("price").values_list("title", "price")[:10]
```

Verifier les categories :

```python
from vehicles.models import VehicleCategory
VehicleCategory.objects.values_list("name", flat=True)
```

Verifier les reservations :

```python
from reservations.models import Reservation
Reservation.objects.count()
```

Verifier les paiements :

```python
from payments.models import Payment
Payment.objects.count()
```

Verifier les factures :

```python
from payments.models import Invoice
Invoice.objects.count()
```

Verifier les messages de contact :

```python
from contact.models import ContactMessage
ContactMessage.objects.count()
```

---

## 20. Dump SQL

Le dump SQL a ete genere apres verification des migrations et des donnees.

Fichier cree :

```text
multidrive_dump.sql
```

Chemin :

```text
C:\Users\elmal\OneDrive\Desktop\multidrive\TFE_MultiDrive\multidrive\multidrive_dump.sql
```

Ce dump contient :

- la structure des tables ;
- les donnees ;
- les cles primaires ;
- les cles etrangeres ;
- les contraintes `REFERENCES` ;
- les index.

Verification effectuee sur le dump :

```text
CREATE TABLE: 17
CREATE INDEX: 26
INSERT INTO: 1175
REFERENCES: 10
```

Exemples de lignes importantes presentes dans le dump :

```text
INSERT INTO "vehicles_vehicle": 150
INSERT INTO "reservations_reservation": 150
INSERT INTO "payments_payment": 110
INSERT INTO "payments_invoice": 105
```

Commande utilisee pour generer le dump :

```powershell
..\venv\Scripts\python.exe -c "import sqlite3; from pathlib import Path; con = sqlite3.connect('db.sqlite3'); output_path = Path('multidrive_dump.sql'); dump_file = output_path.open('w', encoding='utf-8', newline='\n'); dump_file.write('-- MultiDrive SQL dump - structure and data\n'); dump_file.write('PRAGMA foreign_keys=OFF;\n'); [dump_file.write(f'{line}\n') for line in con.iterdump()]; dump_file.write('PRAGMA foreign_keys=ON;\n'); dump_file.close(); con.close()"
```

Avant de regenerer un dump final, il faut :

1. Verifier les migrations :

```powershell
..\venv\Scripts\python.exe manage.py showmigrations
```

2. Verifier le projet :

```powershell
..\venv\Scripts\python.exe manage.py check
```

3. Regenerer les donnees si necessaire :

```powershell
..\venv\Scripts\python.exe manage.py seed_multidrive
```

4. Verifier les volumes :

```powershell
..\venv\Scripts\python.exe manage.py shell
```

Objectif pour le TFE :

- montrer une base relationnelle coherente ;
- avoir des cles primaires ;
- avoir des cles etrangeres ;
- avoir des index ;
- avoir des donnees realistes ;
- pouvoir expliquer les relations entre les tables.

---

## 21. Etat actuel du projet

Etat actuel :

```text
Projet Django cree
Apps creees
Modeles principaux crees
Migrations appliquees
Admin configure
Images configurees
Pillow installe
Donnees de test generees
Base consultable via localhost
Pages publiques de base creees
Authentification client ajoutee
Reservation connectee ajoutee
```

URL admin :

```text
http://127.0.0.1:8001/admin/
```

Identifiants :

```text
admin
admin1234
```

Derniere verification attendue :

```text
System check identified no issues
```

---

## 22. Pages publiques creees

Les premieres pages visibles du site ont ete creees.

URLs disponibles :

```text
http://127.0.0.1:8001/
http://127.0.0.1:8001/vehicles/
http://127.0.0.1:8001/vehicles/<id>/
```

Fichiers crees ou modifies :

```text
vehicles/views.py
vehicles/urls.py
multidrive/urls.py
vehicles/templates/vehicles/base.html
vehicles/templates/vehicles/home.html
vehicles/templates/vehicles/vehicle_list.html
vehicles/templates/vehicles/vehicle_detail.html
vehicles/templates/vehicles/partials/vehicle_card.html
vehicles/static/vehicles/styles.css
```

Pages disponibles :

- page d'accueil ;
- catalogue des vehicules ;
- filtre par categorie ;
- filtre par statut ;
- page detail d'un vehicule ;
- suggestions de vehicules similaires ;
- lien vers l'admin.

Verification effectuee :

```text
/ -> 200
/vehicles/ -> 200
/vehicles/<id>/ -> 200
```

Prochaine etape logique :

```text
Creer le parcours de paiement d'acompte.
```

---

## 23. Authentification client

L'authentification client a ete ajoutee avec l'utilisateur Django par defaut.

URLs disponibles :

```text
http://127.0.0.1:8001/accounts/register/
http://127.0.0.1:8001/accounts/login/
http://127.0.0.1:8001/accounts/logout/
```

Fichiers crees ou modifies :

```text
accounts/forms.py
accounts/views.py
accounts/urls.py
accounts/templates/accounts/register.html
accounts/templates/accounts/login.html
multidrive/urls.py
multidrive/settings.py
vehicles/templates/vehicles/base.html
vehicles/static/vehicles/styles.css
```

Fonctionnement :

- un visiteur peut consulter le site sans compte ;
- un visiteur peut creer un compte ;
- apres inscription, l'utilisateur est connecte automatiquement ;
- un utilisateur peut se connecter ;
- un utilisateur peut se deconnecter ;
- le header change selon l'etat de connexion.

Dans le header :

- visiteur non connecte : `Connexion` et `Creer un compte` ;
- utilisateur connecte : menu utilisateur sous `Bonjour, username` ;
- membre du staff : lien `Admin`.

Cette etape prepare la suite :

```text
Seul un utilisateur connecte pourra reserver un vehicule ou payer un acompte.
```

Verification effectuee :

```text
/accounts/register/ -> 200
/accounts/login/ -> 200
/accounts/logout/ -> 302
Inscription test -> 302 vers accueil
Connexion test -> 302 vers accueil
```

---

## 24. Reservation connectee

Le parcours de reservation est maintenant disponible.

Principe :

- un visiteur peut consulter les vehicules ;
- un visiteur non connecte qui clique sur reserver est redirige vers la connexion ;
- un utilisateur connecte peut envoyer une demande de reservation ;
- la reservation creee a le statut `pending` ;
- l'utilisateur peut consulter ses reservations.

URLs disponibles :

```text
/reservations/vehicle/<vehicle_id>/
/reservations/success/<reservation_id>/
/reservations/mine/
```

Fichiers crees ou modifies :

```text
reservations/forms.py
reservations/views.py
reservations/urls.py
reservations/templates/reservations/reservation_form.html
reservations/templates/reservations/reservation_success.html
reservations/templates/reservations/my_reservations.html
vehicles/templates/vehicles/vehicle_detail.html
vehicles/templates/vehicles/base.html
vehicles/static/vehicles/styles.css
multidrive/urls.py
```

Le header a aussi ete ameliore :

- le lien direct `Deconnexion` n'est plus affiche dans la barre principale ;
- un menu utilisateur apparait sous `Bonjour, username` ;
- ce menu contient :
  - Mes reservations ;
  - Mon profil ;
  - Paiements ;
  - Deconnexion.

Verification effectuee :

```text
Visiteur non connecte -> redirection vers /accounts/login/
Utilisateur connecte -> creation reservation OK
/reservations/mine/ -> 200 pour utilisateur connecte
```

---

## 24bis. Suppression logique du compte

La gestion du profil membre inclut maintenant une demande de suppression de compte en **soft delete**.

Principe retenu :

- le compte n'est pas supprime physiquement de la base ;
- une demande de suppression est enregistree ;
- un statut de compte conserve la trace de la desactivation ;
- l'utilisateur ne peut plus se connecter apres la demande ;
- l'administrateur peut voir l'etat du compte dans l'admin Django.

Modeles ajoutes :

```text
AccountStatus
AccountDeletionRequest
```

Champs importants :

```text
is_deleted
deleted_at
deletion_label
deletion_reason_type
admin_note
reason
processed
processed_at
```

Le marquage visible dans la base prend la forme :

```text
id_<id>_DELETE
```

Exemple :

```text
id_1_DELETE
```

URLs ajoutees :

```text
/accounts/delete-request/
/accounts/delete-request/done/
```

Cette solution a ete retenue pour conserver l'historique des reservations et paiements sans casser les relations en base.

L'administrateur peut aussi desactiver un compte pour abus depuis l'admin Django. Dans ce cas :

- le compte passe en soft delete ;
- `is_active` passe a `False` ;
- le motif devient `admin_block` ;
- un message bloquant specifique est affiche a la connexion.

---

## 24ter. Page de contact et suivi des messages

Une vraie page publique de contact est maintenant disponible.

URLs ajoutees :

```text
/contact/
/contact/success/
/contact/mine/
```

Fonctionnement :

- un visiteur peut envoyer un message sans compte ;
- un membre connecte peut envoyer un message lie a son compte ;
- l'administrateur peut repondre depuis l'admin Django ;
- le membre connecte peut ensuite lire la reponse dans son espace.

Le modele `ContactMessage` a ete enrichi avec :

```text
user
admin_response
responded_at
```

La page `Mes messages` permet au membre de suivre :

- son message initial ;
- l'etat de traitement ;
- la reponse de l'administration si elle existe.

Quand une reponse administrateur est ajoutee :

- une notification non lue est creee pour le membre ;
- une bulle rouge apparait sur `Mes messages` dans le menu utilisateur ;
- la notification disparait quand le membre ouvre sa page de messages.

---

## 24quater. Dashboard administrateur

Un dashboard administrateur simple est maintenant disponible pour les comptes staff.

URL ajoutee :

```text
/accounts/admin-dashboard/
```

Fonctionnalites du dashboard :

- vue globale sur le catalogue ;
- nombre de reservations en attente ;
- nombre de messages sans reponse ;
- nombre de paiements a suivre ;
- nombre de comptes desactives ;
- listes recentes de reservations, messages et comptes desactives ;
- raccourcis vers l'admin Django.

Le dashboard ne remplace pas l'admin Django : il sert de page de pilotage rapide pour les actions du quotidien.

Une notification admin est affichee dans la navigation sous forme de bulle rouge sur `Dashboard admin`.
Elle additionne :

- les reservations en attente ;
- les messages de contact sans reponse ;
- les demandes de suppression non traitees.

---

## 25. Direction UI/UX

La direction visuelle de MultiDrive est maintenant fixee.

Style general :

- sobre ;
- professionnel ;
- moderne ;
- simple ;
- fonctionnel ;
- pas surcharge.

Palette :

```text
Bleu principal: #1E3A8A
Blanc: #FFFFFF
Gris fonce: #333333
Gris clair: #F5F5F5
```

Typographie :

```text
Poppins
```

Principes a respecter pour les prochaines pages :

- header clair avec navigation simple ;
- cartes vehicules lisibles ;
- boutons bleus avec texte blanc ;
- coins legerement arrondis ;
- footer sombre ;
- formulaires propres et bien espaces ;
- design responsive ;
- hierarchie visuelle claire ;
- lisibilite prioritaire ;
- eviter les effets inutiles.

Cette direction devra aussi servir de base pour le futur frontend React.

---

## 26. API REST et documentation

L'API REST du projet a ete ajoutee avec :

```text
Django REST Framework
drf-spectacular
Swagger UI
```

Choix technique retenu :

```text
SessionAuthentication
```

Pourquoi ce choix ?

- c'est la solution la plus simple pour un projet Django existant ;
- elle est facile a tester dans le navigateur ;
- elle est coherente avec l'authentification deja en place sur le site ;
- elle est defendable a l'oral pour un TFE.

Documentation disponible :

```text
http://127.0.0.1:8001/api/schema/
http://127.0.0.1:8001/api/docs/
```

Versioning retenu :

```text
/api/v1/
```

Endpoints exposes :

```text
/api/v1/categories/
/api/v1/vehicles/
/api/v1/reservations/
/api/v1/payments/
/api/v1/invoices/
/api/v1/contact-messages/
```

Logique des permissions :

- `VehicleCategory` : lecture publique, ecriture staff ;
- `Vehicle` : lecture publique, ecriture staff ;
- `Reservation` : utilisateur connecte uniquement, donnees filtrees par utilisateur ;
- `Payment` : utilisateur connecte uniquement, donnees filtrees par utilisateur ;
- `Invoice` : utilisateur connecte uniquement, donnees filtrees par utilisateur ;
- `ContactMessage` : `POST` public, lecture staff uniquement.

Tests valides :

```text
GET /api/v1/categories/ -> 200
GET /api/v1/vehicles/ -> 200
GET /api/v1/reservations/ anonyme -> 403
POST /api/v1/contact-messages/ -> 201
POST /api/v1/reservations/ connecte -> 201
/api/schema/ -> 200
/api/docs/ -> 200
```

Fichiers ajoutes ou modifies pour l'API :

```text
api/serializers.py
api/permissions.py
api/views.py
api/urls.py
multidrive/settings.py
multidrive/urls.py
```

---

## 27. Acces de test a remettre au professeur

URL de l'application :

```text
http://127.0.0.1:8001/
```

URL de l'administration :

```text
http://127.0.0.1:8001/admin/
```

URL de la documentation Swagger :

```text
http://127.0.0.1:8001/api/docs/
```

Profils de test :

### Visiteur

```text
Pas de connexion requise
```

Peut :

- consulter l'accueil ;
- consulter les vehicules ;
- consulter le detail d'un vehicule.

### Membre

```text
username: Younes
password: Multidrive1
```

Peut :

- se connecter ;
- consulter les vehicules ;
- reserver un vehicule ;
- consulter ses reservations.

### Administrateur

```text
username: admin
password: admin1234
```

Peut :

- se connecter a l'admin Django ;
- gerer les vehicules ;
- gerer les reservations ;
- gerer les paiements ;
- gerer les factures ;
- gerer les messages de contact.

---

## 28. Phrase simple pour l'oral

> J'ai construit la base de donnees de MultiDrive progressivement avec Django, en partant des modeles Python. Les vehicules sont ranges par categories, chaque vehicule peut avoir plusieurs images, un utilisateur peut faire une reservation, cette reservation peut avoir un paiement d'acompte, et ce paiement peut generer une facture. Les messages de contact restent independants. J'ai ensuite configure l'admin Django pour consulter les donnees et cree une commande de seed pour generer une base de test realiste, avec des velos, trottinettes, scooters, motos legeres et petites voitures d'occasion a prix accessibles.
