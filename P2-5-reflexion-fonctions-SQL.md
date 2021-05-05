## P2-5-reflexion-fonctions-SQL.md

### Problèmes posés par la fonction

- On ne peut pas utiliser la fonction pour ajouter une activité en lui associant comme propriéatire un utilisateur existant.
- On doit connaitre les identifiants disponibles des activités et des utilisateurs pour pouvoir insérer une nouvelle activité.

### Proposition de solution

- Pour pouvoir recycler un propriétaire existant, il faudrait pouvoir exécuter du code sous condition : si un utilisateur avec tel "id" existe déjà, on affecte cet utilisateur comme propriétaire à la base de données.

- Pour ne pas avoir à connaître les identifiants disonibles, il faudrait bénficier d'un dispositif permettant de générer automatiquement les identifiants disponibles dont on a besoin.