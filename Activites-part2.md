# Partie 2 - Fonctions SQL
 
Dans la suite du document l'expression "dossier projet" désigne la racine de votre dossier projet "dut-info1-myactivities-db-project-*VotreLoginGithub*".

Dans la suite du document, à chaque fois que vous trouverez un énoncé  sous la forme :

> “fix #...”

vous devez committer et pusher les modifications sur votre dépôt distant en utilisant comme message de commit cet énoncé.

Les fichiers que l'on vous demande de créér dans le cadre des exercices sont à créér dans votre dossier projet.

### 1. Écriture d'une fonction retournant un seul élément 

1.1. Ouvrez pgAdmin 4 et connectez vous à votre base de données.

1.2. À l'aide du "Query tool", créer la fonction "create_activity_with_owner" à l'aide de l'énoncé suivant :

    CREATE OR REPLACE FUNCTION create_activity_with_owner(
        an_act_id bigint, 
        an_act_title VARCHAR(200), 
        an_act_descr text, 
        a_user_id bigint,
        a_username VARCHAR(500)) 
    RETURNS activity AS $$
        -- insert the owner
        INSERT INTO "user" (id, username, date_created) 
        VALUES (a_user_id, a_username, now());
        -- insert the activity
        INSERT INTO activity (id, title, description, creation_date, modification_date, owner_id)
        VALUES (an_act_id, an_act_title, an_act_descr, now(), now(), a_user_id);
        -- return the created activity
        SELECT * FROM activity where id = an_act_id ;
    $$
    LANGUAGE SQL;

Tester que la fonction est correcte avec l'énoncé suivant :

    SELECT * FROM create_activity_with_owner(21,'Billard','Jouer au billard à Rodez',2001, 'Joé Bill');

> Les fonctions spécifiées dans la suite des activités doivent être créées et testées avec le "Query Tool". Certaines fonctions nécessiteront l'insertion de nouvelles données pour être testées. 
>
>Pour chaque fonction spécifiée, vous devez créer un nouveau fichier dont le nom sera précisé pour chaque fonction. Vous devez ensuite compléter ce fichier avec la fonction et les requêtes que vous avez rédigées pour tester dans le "Query Tool".

1.3 Modification de la fonction pour utilisation de la clause RETURNING

- Nom de fichier :  

    P2-3-create_activity_with_owner_RETURNING.sql

- Description de la fonction :  

    Modifiez la fonction "create_activity_with_owner" pour qu'elle utilise la clause RETURNING au lieu de la dernière instruction SELECT pour retourner l'activité que la fonction vient de créer.

> fix #3 fonction clause returning

### 2. Ecriture d'une fonction retournant plusieurs éléments

2.1. Fonction "find_activities_older_than"

- Nom de fichier :  

    P2-4-find_activities_older_than.sql

- Description de la fonction :  

    - *Nom de la fonction* :  
    "find_activities_older_than"  
    - *Argument de la fonction* :  
    "old_date" de type "date"  
    - *Description* :   
    la fonction retourne la liste des activités qui n'ont pas été modifiées depuis la date "old_date" passée en paramètre.

> fix #4 fonction find_activities_older_than

### 3. Réflexion sur l'utilisation des fonctions SQL

Pour répondre aux questions de cette exercice créé le fichier "P2-5-reflexion-fonctions-SQL.md" dans votre dossier projet. Vos réponses devront figurer dans ce fichier.

Examinez la fonction "create_activity_with_owner" du premier exercice.

2.1 Problèmes posés par cette fonction

Cette fonction posent différents problèmes telle qu'elle est écrite.
Pouvez-vous identifiez et expliquez les problèmes qu'elle pose ?


2.2 Propositions de solution

Que faudrait-il pouvoir faire dans cette fonction pour résoudre les problèmes soulevés précédemment ?

> fix #5 réflexions sur create_activity_with_owner




