-- Fonction recuperant l'id d'une salle à partir de son nom

CREATE OR REPLACE FUNCTION gds.get_salle_id(un_nom_de_salle character varying(250)) 
RETURNS bigint AS $$
	select id from gds.salle where nom = un_nom_de_salle;
$$ LANGUAGE SQL;

-- Fonction insérant une nouvelle réservation

CREATE OR REPLACE FUNCTION gds.insert_reservation(
    une_date_debut timestamp without time zone,
    une_date_fin timestamp without time zone, 
    un_nom_de_salle character varying(250) 
) RETURNS gds.reservation AS $$
        -- insert la reservation
        INSERT INTO gds.reservation (id, date_debut, date_fin, date_creation, date_modification,salle_id) 
        VALUES (nextval('gds.reservation_seq'),
				une_date_debut, 
				une_date_fin, 
				now(), 
				now(),
				gds.get_salle_id(un_nom_de_salle)
			   ) 
        returning *;
$$ LANGUAGE SQL;