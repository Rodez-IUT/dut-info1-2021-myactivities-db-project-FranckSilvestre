# Partie 5 - Curseurs et gestions des erreurs

Avant de réaliser cette partie, il convient d'avoir lu de manière active le support de cours sur les notions abordées dans ce TP (activité Moodle).  
Dans la suite du document l'expression "dossier projet" désigne la racine de votre dossier projet "dut-info1-myactivities-db-project-*VotreLoginGithub*".

Dans la suite du document, à chaque fois que vous trouverez un énoncé  sous la forme :

> “fix #...”

vous devez committer et pusher les modifications sur votre dépôt distant en utilisant comme message de commit cet énoncé.

Les fichiers que l'on vous demande de créér dans le cadre des exercices sont à créér dans votre dossier projet.

### 1. Gestion d'erreur dans le calcul du temps d'occupation pour une salle donnée

L'objectif est ici de lever une exception quand le nom de la salle fourni ne correspond à aucune salle de la base de donnée.

#### Modification de la fonction "pl_calcule_temps_occupation"

- Nom de fichier à créér :  

    P5-13-pl_calcule_temps_occupation.sql

- Nouvelle description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_calcule_temps_occupation"  
    - *Argument de la fonction* :   
    "un_nom_de_salle" de type "character varying(250)"
    - *Description* :   
    la fonction tente de calculer le temps d'occupation de la salle dont le nom est passé en paramètre. Si la salle demandée n'existe pas dans la base alors 
    ~~un message doit s'afficher dans la console (à l'aide d'une instruction "RAISE NOTICE") pour indiquer que la salle demandée n'existe pas. La fonction retourne null.~~
    **une erreur est lancée avec le code d'erreur "invalid_parameter_value" et un message indiquant que le nom de la salle n'est pas valide.**
    Si la salle existe, la fonction parcourt la liste des réservations de cette salle et ajoute les durées de chacune des réservations pour calculer le temps d'occupation de la salle. Le résultat de cette somme est retournée par la fonction sous forme d'un "interval". L'utilisation de [la fonction "age"](https://www.postgresql.org/docs/9.6/functions-datetime.html) sera bien utile :-).

Testez votre fontion avec les requêtes suivantes :
    
    select * from gds.pl_calcule_temps_occupation('Lilla');
    select * from gds.pl_calcule_temps_occupation('paquerette');
    select * from gds.pl_calcule_temps_occupation('rose');

Si vous avez inséré les données tel que cela était demandé dans les énoncés précédent, ces requêtes doivent retourner respectivement :

- Aucun résultat mais un message d'erreur dans la console avec le code d'erreur 22023 indiqué.
- 04:00:00
- 02:00:00

> fix #13 fonction pl_calcule_temps_occupation modifiée

### 2. Utilisation d'un curseur pour la liste des salles avec leur temps d'occupation

L'objectif est ici d'introduire l'utilisation d'un curseur comme type de retour de la fonction.

#### Modification de la fonction "pl_calcule_temps_occupation"

- Nom de fichier à créer :  

    P5-14-pl_get_salles_avec_temps_occupation.sql

- Nouvelle description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_get_salles_avec_temps_occupation"  
    - *Argument de la fonction* :   
    "curs" de type refcursor
    - *Description* :   
    La fonction retourne **un curseur correspondant à** la liste des noms de toutes les salles avec leur temps d'occupation respectif ordonnés par temps d'occupation décroissant puis par nom.
    Cette fonction fera appel à la fonction "gds.pl_calcule_temps_occupation".

> Indication technique : pour tester votre fonction, référez vous à l'exemple donné dans le support de cours.

> fix #14 fonction get_salles_avec_temps_occupation modifiées