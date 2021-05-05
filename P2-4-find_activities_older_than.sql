-- P2-4-find_activities_older_than.sql

-- la fonction

CREATE OR REPLACE FUNCTION find_activities_older_than(old_date date) RETURNS SETOF "activity" AS $$
  SELECT * FROM activity WHERE modification_date < old_date;
$$ LANGUAGE SQL;

-- test de la fonction
select * from find_activities_older_than('2020-03-30');