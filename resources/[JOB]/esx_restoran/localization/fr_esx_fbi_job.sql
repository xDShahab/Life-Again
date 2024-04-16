INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_restoran', 'restoran', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_restoran', 'restoran', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_restoran', 'restoran', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('restoran','restoran')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('restoran',0,'agent','Agent',20,'{}','{}'),
	('restoran',1,'special','Agent Expérimenté',40,'{}','{}'),
	('restoran',2,'supervisor','Superviseur',60,'{}','{}'),
	('restoran',3,'assistant','Assistant du Directeur',85,'{}','{}'),
	('restoran',4,'boss','Directeur',100,'{}','{}')
;
