# Partie 3 - Schémas, séquences et vues

Dans la suite du document l'expression "dossier projet" désigne la racine de votre dossier projet "dut-info1-myactivities-db-project-*VotreLoginGithub*".

Dans la suite du document, à chaque fois que vous trouverez un énoncé  sous la forme :

> “fix #...”

vous devez committer et pusher les modifications sur votre dépôt distant en utilisant comme message de commit cet énoncé.

Les fichiers que l'on vous demande de créér dans le cadre des exercices sont à créér dans votre dossier projet.

### 1. Création du schéma  "gds" (pour gestion de salles)

1.1. Ouvrez pgAdmin 4 et connectez vous à votre base de données.

1.2. À l'aide du "Query tool", créer le schéma "gds" à l'aide de l'instruction suivante :

    CREATE SCHEMA gds;

1.3. Toujours à l'aide de "Query tool" créer dans le schéma "gds" les tables "salle" et "reservation" à l'aide des instructions suivantes :

    CREATE TABLE gds.salle
    (
        id bigint NOT NULL,
        nom character varying(250) NOT NULL UNIQUE,
        nb_personnes_max integer NOT NULL,
        date_creation timestamp without time zone NOT NULL,
        date_modification timestamp without time zone NOT NULL,
        CONSTRAINT salle_pkey PRIMARY KEY (id)
    );

    CREATE TABLE gds.reservation
    (
        id bigint NOT NULL,
        date_debut timestamp without time zone NOT NULL,
        date_fin timestamp without time zone NOT NULL,
        date_creation timestamp without time zone NOT NULL,
        date_modification timestamp without time zone NOT NULL,
        salle_id bigint NOT NULL,
        CONSTRAINT reservation_pkey PRIMARY KEY (id),
        CONSTRAINT fk_reservation_salle FOREIGN KEY (salle_id)
            REFERENCES gds.salle (id)
    )

1.4. Création de séquences.

Afin de faciliter la création de nouveaux enregistrements, nous allons créer une séquence pour chacune des tables du schéma "gds". À l'aide du "Query tool" créez les séquences à l'aide des instructions suivantes :

CREATE SEQUENCE gds.salle_seq;
CREATE SEQUENCE gds.reservation_seq;

### 2. Fonctions de création des salles et des réservations

> Les fonctions spécifiées dans la suite des activités doivent être créées et testées avec le "Query Tool".
>
>Pour chaque fonction spécifiée, vous devez créer un nouveau fichier dans votre dosser projet dont le nom sera précisé pour chaque fonction. Vous devez ensuite compléter ce fichier avec la fonction que vous avez rédigée et testée dans le "Query Tool".

2.1. Fonction "insert_salle"

- Nom de fichier :  

    P3-6-insert_salle.sql

- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.insert_salle"  
    - *Arguments de la fonction* :  
    "un_nom" de type "character varying(250)"
    "un_nb_personnes_max" de type "integer"  
    - *Description* :   
    la fonction insert une nouvelle salle dans la table "salle" dont le nom et le nombre de personnes max dans la salle sont transmis en paramètres.
    La fonction utilise la séquence "gds.salle_seq" pour générer la valeur de la clé primaire de la salle à insérer dans la base. La date de création et la date de modification sont initialisées en utilisant la fonction "now()". 
    La fonction retourne la salle qui a été insérée.

Insérez 4 salles dans votre BD à l'aide des instructions suivantes :

    select * from gds.insert_salle('paquerette', 12);
    select * from gds.insert_salle('rose', 6);
    select * from gds.insert_salle('dalhia', 24);
    select * from gds.insert_salle('tulipe', 32);

> fix #6 fonction fonction insert_salle 

2.2. Fonction "insert_reservation"

- Nom de fichier :  

    P3-7-insert_reservation.sql

- Description de la fonction :  

    - *Nom de la fonction* :  
    "gds.insert_reservation"  
    - *Arguments de la fonction* :  
    "une_date_debut" de type "timestamp without time zone"
    "une_date_fin" de type "timestamp without time zone" 
    "un_nom_de_salle" de type "character varying(250)"
    - *Description* :   
    la fonction insert une nouvelle réservation dans la table "reservation" dont la date de début, la date de fin et le nom de la salle réservée sont transmis en paramètres.
    La fonction utilise la séquence "gds.reservation_seq" pour générer la valeur de la clé primaire de la réservation à insérer dans la base. La date de création et la date de modification sont initialisées en utilisant la fonction "now()". 
    La fonction retourne la réservation qui a été insérée.

> Indice disponible : si vous êtes bloqué.e.s sur cette question, un indice est disponible auprès de votre enseignant. 

Insérez 6 réservations dans votre BD à l'aide des instructions suivantes :

    select * from gds.insert_reservation('2020-04-24 15:00:00','2020-04-24 17:00:00','paquerette');
    select * from gds.insert_reservation('2020-04-22 15:00:00','2020-04-22 17:00:00','paquerette');
    select * from gds.insert_reservation('2020-04-22 12:00:00','2020-04-22 14:00:00','rose');
    select * from gds.insert_reservation('2020-04-23 18:00:00','2020-04-22 19:00:00','tulipe');
    select * from gds.insert_reservation('2020-04-25 14:00:00','2020-04-25 17:00:00','dalhia');
    select * from gds.insert_reservation('2020-04-22 12:00:00','2020-04-22 14:00:00','dalhia');

> fix #7 fonction insert_reservation 

### 3. Création de la vue retournant les réservations

Une fois votre vue créée et testée dans le "Query tool", reportez le code de votre vue dans le fichier spécifié ci-dessous.

- Nom de fichier :  

    P3-8-vues_reservations.sql

- Description de la vue :  

    - *Nom de la vue* :  
    "gds.vue_reservations"  
    - *Description* :   
    la vue retourne la liste de toutes les réservations. Chaque ligne retournée affiche :
        - l'id de la réservation 
        - le nom de la salle réservée
        - la date de début de la réservation
        - la date de fin de la réservation
    Les réservations sont triées sur les noms des salles puis de la date de début la plus récente à la date de début la plus ancienne.

Vous pouvez tester le bon fonctionnement de votre vue avec la requête suivante :

    select * from gds.vue_reservations;

> fix #8 vue reservations