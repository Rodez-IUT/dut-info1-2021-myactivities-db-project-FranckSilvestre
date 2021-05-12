CREATE OR REPLACE FUNCTION gds.pl_insert_reservation(
    une_date_debut timestamp without time zone,
    une_date_fin timestamp without time zone, 
    un_nom_de_salle character varying(250) 
) RETURNS gds.reservation AS $$
	DECLARE
		salle_reservee_id gds.salle.id%TYPE;
		reservation gds.reservation%ROWTYPE;
	BEGIN
		SELECT id INTO salle_reservee_id from gds.salle where nom = un_nom_de_salle;
		IF FOUND 
		THEN
			-- insert la reservation
        	INSERT INTO gds.reservation (id, date_debut, date_fin, date_creation, date_modification,salle_id) 
        		VALUES (nextval('gds.reservation_seq'),
					une_date_debut, 
					une_date_fin, 
					now(), 
					now(),
					salle_reservee_id
			   ) 
        	returning * INTO reservation;
		ELSE
			RAISE NOTICE 'La salle demandée n''existe pas';
		END IF;
	RETURN reservation;
	END;
$$ LANGUAGE plpgsql;