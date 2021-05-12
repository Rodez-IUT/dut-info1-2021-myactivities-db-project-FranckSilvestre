-- vue reservations

CREATE OR REPLACE VIEW gds.vue_reservations AS
	SELECT 
		res.id as reservation_id,
		nom as salle,
		date_debut,
		date_fin
	FROM 
		gds.reservation res
		JOIN
		gds.salle salle ON salle_id = salle.id
	ORDER BY nom, date_debut;

select * from gds.vue_reservations;