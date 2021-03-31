# Partie 1 - Population de la base de données

Avant de réaliser cette partie, il convient d'avoir visionné la vidéo mise à disposition dans l'espace de cours Moodle et accessible directement via cette URL :
https://youtu.be/aM2KBUfADak

### 1. Création de l'utilisateur "myactivities-user" 

1.1. Ouvrez pgAdmin 4 et connectez vous à votre serveur local en utilisant le user "postgres".

1.2. Créez un nouvel utilisateur spécifié comme suit :
    
- username : myactivities-user
- mot de passe : 123456
- attributs : LOGIN et CREATEDB

### 2. Création de la base de données "myactivities-db"

2.1. Déconnectez-vous du serveur et reconnectez-vous au serveur en utilisant l'utilisateur "myactivities-user".

2.2. Créez une nouvelle base de données spécifiées comme suit :

- name : myactivities-db
- owner (propriétaire) : myactivities-user
- encoding : UTF8

### 3. Création et initialisation de la table "user"

En utilisant l'éditeur de requête "Query Tool" proposé par pgAdmin, utilisez les instructions SQL ci-dessous pour créer  et initialiser le contenu de la  table "user".

    CREATE TABLE "user"
    (
        id bigint NOT NULL,
        username character varying(500),
        date_created timestamp without time zone NOT NULL DEFAULT now(),
        CONSTRAINT user_pkey PRIMARY KEY (id)
    );

    INSERT INTO "user" VALUES (100,'Marie Dupont', now());
    INSERT INTO "user" VALUES (101,'Paul Durand', now());
    INSERT INTO "user" VALUES (102,'Jane Doe', now());

> Les requêtes spécifiées dans la suite des activités doivent être exécutées et donc testées via le "Query Tool". Certaines requêtes nécessiteront l'insertion de nouvelles données pour être testées. 
>
>Pour chaque requête spécifiée, vous devez créer un nouveau fichier dont le nom sera spécifié pour chaque requête. Vous devez ensuite compléter ce fichier avec la requête que vous avez rédigée et testée dans "Query Tool" ainsi qu'avec les instructions que vous aurez à rédiger et à exécuter pour tester votre requête. 

### 4. Requêtes simples sur la table "user"

4.1. Sélection des "vieux" "user"

- Nom de fichier :  
    
    P1-1-select-old-users.sql

- Description de la requête :

    Sélectionner le username et la date de création des utilisateurs créés avant le 1er septembre 2019 triés par ordre alphabétique sur les "username".

> fix #1 requete sur user

### 5. Création et initialisation de la table "activity"

En utilisant l'éditeur de requête "Query Tool" proposé par pgAdmin, utilisez les instructions SQL ci-dessous pour créer  et initialiser le contenu de la  table "activity".

    CREATE TABLE activity
    (
        id bigint NOT NULL,
        title character varying(200) NOT NULL,
        description text,
        creation_date timestamp without time zone NOT NULL DEFAULT now(),
        modification_date timestamp without time zone NOT NULL DEFAULT now(),
        owner_id bigint,
        CONSTRAINT activity_pkey PRIMARY KEY (id),
        CONSTRAINT activity_user_id_fk FOREIGN KEY (owner_id)
            REFERENCES "user" (id)
            ON DELETE CASCADE
    );


    INSERT INTO public.activity VALUES (1, 'Tennis de table', 'Activité loisir tennis de table', '2019-01-21 11:30:00', '2019-01-21 11:30:00', 101);
    INSERT INTO public.activity VALUES (2, 'Théatre', 'Club de théâtre amateur', '2019-01-21 11:30:00', '2019-01-21 11:30:00');
    INSERT INTO public.activity VALUES (3, 'Musique funk', 'Groupe de musique amateur passionné de jazz fusion funk.', '2019-01-21 11:30:00', '2019-01-21 11:30:00');
    INSERT INTO public.activity VALUES (4, 'Football', 'Club de foot pour tous les ages', '2019-01-21 11:30:00', '2019-01-21 11:30:51.00', 102);

5.1. Sélection des activités et de leur propriétaires 

- Nom de fichier :  
    
    P1-2-select-all-activities.sql

- Description de la requête :

    Sélectionner le "title", la description et le "username" du propriétaire de toutes les activités créées après le 1er septembre 2019 triés par ordre alphabétique sur les "title" puis sur les "username".
    Si une activité n'est attachée à aucun propriétaire, la ligne correspondante doit s'afficher quand même avec le champ "username" laissé vide. 

> fix #2 requete sur activity