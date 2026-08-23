# MultiDrive - Acces de test pour le professeur

## 1. URL de l'application

Application web :

```text
http://127.0.0.1:8001/
```

Interface d'administration Django :

```text
http://127.0.0.1:8001/admin/
```

Documentation API Swagger :

```text
http://127.0.0.1:8001/api/docs/
```

---

## 2. Profils de test disponibles

### A. Visiteur

```text
Aucun identifiant requis
```

Fonctionnalites testables :

- consulter l'accueil ;
- consulter la liste des vehicules ;
- consulter le detail d'un vehicule.

---

### B. Membre

```text
username: Jury_user
password: Testjury123
```

Fonctionnalites testables :

- se connecter ;
- consulter les vehicules ;
- consulter le detail d'un vehicule ;
- reserver un vehicule ;
- consulter ses reservations ;
- acceder a l'espace membre (paiements, messages, profil) ;
- consulter l'API documentee si besoin.

---

### C. Administrateur

```text
username: Jury
password: Testjury123
```

Fonctionnalites testables :

- se connecter a l'interface d'administration ;
- acceder au dashboard administrateur ;
- ajouter / modifier / supprimer des vehicules ;
- gerer les reservations ;
- gerer les paiements ;
- gerer les factures ;
- gerer les messages de contact et y repondre ;
- gerer les comptes membres.

---

## 3. Remarque importante

L'application est actuellement executee en local.

Cela signifie que l'adresse :

```text
http://127.0.0.1:8001/
```

est une URL de test locale utilisee sur la machine de demonstration.

---

## 4. Resume rapide

```text
Visiteur       : consultation sans connexion
Membre         : Jury_user / Testjury123
Administrateur : Jury / Testjury123
```
