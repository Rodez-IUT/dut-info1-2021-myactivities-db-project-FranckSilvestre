-- P1-1-select-old-users.sql

-- insertion de 2 utilateurs créés avant le 1er sept. 2019

INSERT INTO "user" VALUES (200,'Florence Dupres ', '2019-08-24');
INSERT INTO "user" VALUES (201,'Jacques Morie ', '2019-06-02');

SELECT username, date_created 
FROM "user" 
WHERE date_created < '2019-09-01'
ORDER BY username;

