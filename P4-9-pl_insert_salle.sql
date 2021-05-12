CREATE OR REPLACE FUNCTION gds.pl_insert_salle(
        un_nom VARCHAR(250), 
        un_nb_personnes_max integer) 
RETURNS gds.salle AS $$
	DECLARE
		nouvelle_salle gds.salle%ROWTYPE;
	BEGIN
        -- insert la salle
        INSERT INTO gds.salle 
			(id, nom, nb_personnes_max, date_creation, date_modification) 
        	VALUES (nextval('gds.salle_seq'),un_nom, un_nb_personnes_max, now(), now()) 
			returning * INTO nouvelle_salle;
		RETURN nouvelle_salle;
	END;	
$$ LANGUAGE plpgsql;
