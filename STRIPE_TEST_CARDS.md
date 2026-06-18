# Cartes de test Stripe — MultiDrive

Toutes ces cartes fonctionnent en mode **test** uniquement (`pk_test_...`).
- Date d'expiration : n'importe quelle date future (ex : 12/28)
- CVC : n'importe quel code a 3 chiffres (ex : 123)
- Code postal : n'importe quoi (ex : 75000)

---

## Cas de succes

| Carte | Numero | Comportement |
|---|---|---|
| Visa (standard) | `4242 4242 4242 4242` | Paiement accepte immediatement |
| Visa (debit) | `4000 0566 5566 5556` | Paiement accepte (debit) |
| Mastercard | `5555 5555 5555 4444` | Paiement accepte immediatement |
| Mastercard (prepayee) | `5200 8282 8282 8210` | Paiement accepte (prepayee) |
| American Express | `3782 822463 10005` | Paiement accepte (CVC = 4 chiffres : 1234) |

---

## Cas d'echec — refus de paiement

| Carte | Numero | Comportement |
|---|---|---|
| Carte refusee (generique) | `4000 0000 0000 0002` | Paiement refuse — `card_declined` |
| Solde insuffisant | `4000 0000 0000 9995` | Refuse — `insufficient_funds` |
| CVC incorrect | `4000 0000 0000 0101` | Refuse — `incorrect_cvc` |
| Carte expiree | `4000 0000 0000 0069` | Refuse — `expired_card` |
| Numero incorrect | `4000 0000 0000 0127` | Refuse — `incorrect_number` |
| Carte perdue | `4000 0000 0000 9987` | Refuse — `lost_card` |
| Carte volee | `4000 0000 0000 9979` | Refuse — `stolen_card` |
| Erreur de traitement | `4000 0000 0000 0119` | Refuse — `processing_error` |

---

## Cas avec authentification 3D Secure (SCA)

| Carte | Numero | Comportement |
|---|---|---|
| 3DS requis — succes | `4000 0027 6000 3184` | Popup 3DS -> cliquer "Authentifier" -> succes |
| 3DS requis — echec | `4000 0082 6000 3178` | Popup 3DS -> cliquer "Echouer" -> paiement refuse |
| 3DS optionnel | `4000 0025 0000 3155` | 3DS propose mais non obligatoire |

---

## Cas speciaux

| Carte | Numero | Comportement |
|---|---|---|
| Paiement bloque (fraude) | `4100 0000 0000 0019` | Refuse — `fraudulent` |
| Carte necessitant un code postal | `4000 0000 0000 0036` | Refuse si code postal incorrect |

---

## Comment tester dans MultiDrive

1. Creer un compte membre et faire une reservation
2. Attendre que l'admin accepte la reservation (ou l'accepter depuis le dashboard admin)
3. Aller dans **Paiements et achats** -> cliquer **Payer**
4. Choisir le montant et valider
5. Sur la page Stripe, entrer l'un des numeros ci-dessus
6. Observer le resultat dans MultiDrive et dans le dashboard Stripe (mode test)

## Verifier les paiements dans Stripe

Dashboard Stripe (mode test) :
- Transactions : voir tous les paiements, leur statut et les details
- Logs : voir les requetes API detaillees
- Webhooks : (si configure) voir les evenements recus

---

*Document de test interne — ne pas partager publiquement.*
