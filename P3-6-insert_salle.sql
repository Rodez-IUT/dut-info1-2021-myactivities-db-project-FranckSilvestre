-- Fonction insert salle

CREATE OR REPLACE FUNCTION gds.insert_salle(
        un_nom VARCHAR(250), 
        un_nb_personnes_max integer) 
RETURNS gds.salle AS $$
        -- insert la salle
        INSERT INTO gds.salle (id, nom, nb_personnes_max, date_creation, date_modification) 
        VALUES (nextval('gds.salle_seq'),un_nom, un_nb_personnes_max, now(), now()) returning *;
$$ LANGUAGE SQL;