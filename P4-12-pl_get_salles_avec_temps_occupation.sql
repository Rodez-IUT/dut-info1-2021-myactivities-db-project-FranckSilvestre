CREATE OR REPLACE FUNCTION gds.pl_get_salles_avec_temps_occupation() 
RETURNS TABLE(nom_salle varchar(250), temps_occupation interval) AS $$
	BEGIN
		RETURN QUERY 
			SELECT nom, gds.pl_calcule_temps_occupation(nom) as tps_occupation
			FROM gds.salle 
			ORDER BY tps_occupation DESC, nom;
		RETURN; -- optionnel
	END;
$$ LANGUAGE plpgsql;

select * from gds.pl_get_salles_avec_temps_occupation();