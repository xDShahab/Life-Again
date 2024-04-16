INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_artesh', 'artesh', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_artesh', 'artesh', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_artesh', 'artesh', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('artesh','artesh')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('artesh',0,'agent','Agent',20,'{}','{}'),
	('artesh',1,'special','Agent Expérimenté',40,'{}','{}'),
	('artesh',2,'supervisor','Superviseur',60,'{}','{}'),
	('artesh',3,'assistant','Assistant du Directeur',85,'{}','{}'),
	('artesh',4,'boss','Directeur',100,'{}','{}')
;
