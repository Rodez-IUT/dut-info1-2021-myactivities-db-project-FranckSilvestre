# Partie 4 - Introduction PL/pgSQL
  
Dans la suite du document l'expression "dossier projet" désigne la racine de votre dossier projet "dut-info1-myactivities-db-project-*VotreLoginGithub*".

Dans la suite du document, à chaque fois que vous trouverez un énoncé  sous la forme :

> “fix #...”

vous devez committer et pusher les modifications sur votre dépôt distant en utilisant comme message de commit cet énoncé.

Les fichiers que l'on vous demande de créér dans le cadre des exercices sont à créér dans votre dossier projet.

### 1. Portage de la fonction SQL insert_salle en PL/pgSQL

L'objectif de cette exercice est de vous familiariser avec les différences de structure et de retour entre les 2 types de fonctions SQL et PL/pgSQL.

> Les fonctions spécifiées dans la suite des activités utilisent **obligatoirement** le langage "plpgsql" et doivent être créées et testées avec le "Query Tool".
>
>Pour chaque fonction spécifiée, vous devez créer un nouveau fichier dans votre dosser projet dont le nom sera précisé pour chaque fonction. Vous devez ensuite compléter ce fichier avec la fonction que vous avez rédigée et testée dans le "Query Tool".

#### Fonction "pl_insert_salle"

- Nom de fichier :  

    P4-9-pl_insert_salle.sql

- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_insert_salle"  
    - *Arguments de la fonction* :  
    "un_nom" de type "character varying(250)"
    "un_nb_personnes_max" de type "integer"  
    - *Description* :   
    La fonction insert une nouvelle salle dans la table "salle" dont le nom et le nombre de personnes max dans la salle sont transmis en paramètres.
    La fonction utilise la séquence "gds.salle_seq" pour générer la valeur de la clé primaire de la salle à insérer dans la base. La date de création et la date de modification sont initialisées en utilisant la fonction "now()". 
    La fonction retourne la salle qui a été insérée.

    Insérez 4 salles dans votre BD à l'aide des instructions suivantes :

        select * from gds.pl_insert_salle('marguerite', 12);
        select * from gds.pl_insert_salle('geranium', 6);
        select * from gds.pl_insert_salle('laurier', 24);
        select * from gds.pl_insert_salle('bambou', 32);

> fix #9 fonction pl_insert_salle

### 2. Portage et adaptation de la fonction SQL insert_reservation en PL/pgSQL

L'objectif est ici d'introduire les instructions conditionnelles et l'utilisation de la variable "FOUND".

#### Fonction "pl_insert_reservation"

- Nom de fichier :  

    P4-10-pl_insert_reservation.sql

- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_insert_reservation"  
    - *Arguments de la fonction* :  
    "une_date_debut" de type "timestamp without time zone"
    "une_date_fin" de type "timestamp without time zone" 
    "un_nom_de_salle" de type "character varying(250)"
    - *Description* :   
    La fonction tente d'inserer une nouvelle réservation dans la table "reservation" dont la date de début, la date de fin et le nom de la salle réservée sont transmis en paramètres.
    Si la salle demandée n'existe pas dans la base alors un message doit s'afficher dans la console (à l'aide d'une instruction "RAISE NOTICE") pour indiquer que la salle demandée n'existe pas. La fonction retourne alors une ligne constituée de valeurs nulles. 
    Si la salle demandée existe, alors la fonction utilise la séquence "gds.reservation_seq" pour générer la valeur de la clé primaire de la réservation à insérer dans la base. La date de création et la date de modification sont initialisées en utilisant la fonction "now()". 
    La fonction retourne la réservation qui a été insérée.


Testez votre fonction à l'aide des instructions suivantes  et vérifiez qu'un message s'affiche bien dans la console quand la salle demandée n'existe pas:

    select * from gds.pl_insert_reservation('2020-04-24 15:00:00','2020-04-24 17:00:00','marguerite');
    select * from gds.pl_insert_reservation('2020-04-22 15:00:00','2020-04-22 17:00:00','geranium');
    select * from gds.pl_insert_reservation('2020-04-22 12:00:00','2020-04-22 14:00:00','bambou');
    select * from gds.pl_insert_reservation('2020-04-22 18:00:00','2020-04-22 19:00:00','laurier');
    select * from gds.pl_insert_reservation('2020-04-25 14:00:00','2020-04-25 17:00:00','begonia');
    select * from gds.pl_insert_reservation('2020-04-22 12:00:00','2020-04-22 14:00:00','lilla');

> fix #10 fonction pl_insert_reservation

### 3. Calcul du temps d'occupation pour une salle donnée

L'objectif est ici d'introduire la notion de boucle sur les résultats d'une requête.

#### Fonction "pl_calcule_temps_occupation"

- Nom de fichier :  

    P4-11-pl_calcule_temps_occupation.sql

- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_calcule_temps_occupation"  
    - *Argument de la fonction* :   
    "un_nom_de_salle" de type "character varying(250)"
    - *Description* :   
    la fonction tente de calculer le temps d'occupation de la salle dont le nom est passé en paramètre. Si la salle demandée n'existe pas dans la base alors un message doit s'afficher dans la console (à l'aide d'une instruction "RAISE NOTICE") pour indiquer que la salle demandée n'existe pas. La fonction retourne null.
    Si la salle existe, la fonction parcourt la liste des réservations de cette salle et ajoute les durées de chacune des réservations pour calculer le temps d'occupation de la salle. Le résultat de cette somme est retournée par la fonction sous forme d'un "interval". L'utilisation de [la fonction "age"](https://www.postgresql.org/docs/9.6/functions-datetime.html) sera bien utile :-).

Testez votre fontion avec les requêtes suivantes :
    
    select * from gds.pl_calcule_temps_occupation('Lilla');
    select * from gds.pl_calcule_temps_occupation('paquerette');
    select * from gds.pl_calcule_temps_occupation('rose');

Si vous avez inséré les données tel que cela était demandé dans les énoncés précédent, ces requêtes doivent retourner respectivement :

- [null]
- 04:00:00
- 02:00:00

> fix #11 fonction pl_calcule_temps_occupation

### 4. Liste des salles avec leur temps d'occupation

L'objectif est ici d'introduire le retour de plusieurs lignes de résultats par une fonction PL/pgSQL ainsi que la réutilisation  de fonction.

#### Fonction "pl_calcule_temps_occupation"

- Nom de fichier :  

    P4-12-pl_get_salles_avec_temps_occupation.sql

- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.pl_get_salles_avec_temps_occupation"  
    - *Argument de la fonction* :   
    Aucun
    - *Description* :   
    La fonction retourne la liste des noms de toutes les salles avec leur temps d'occupation respectif ordonnés par temps d'occupation décroissant puis par nom.
    Cette fonction fera appel à la fonction "gds.pl_calcule_temps_occupation".

> Indication technique : comme nous renvoyons une liste personnalisée qui ne correspond pas à une liste de lignes de table de notre BD, le type de retour de la fonction doit spécifier la structure des lignes retournées avec une clause "TABLE". Dans notre cas, le type de retour doit être :  

    TABLE(nom_salle varchar(250), temps_occupation interval)"

> fix #12 fonction get_salles_avec_temps_occupation