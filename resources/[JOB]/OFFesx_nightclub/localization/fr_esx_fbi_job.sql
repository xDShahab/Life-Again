INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_nightclub', 'nightclub', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_nightclub', 'nightclub', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_nightclub', 'nightclub', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('nightclub','nightclub')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('nightclub',0,'agent','Agent',20,'{}','{}'),
	('nightclub',1,'special','Agent Expérimenté',40,'{}','{}'),
	('nightclub',2,'supervisor','Superviseur',60,'{}','{}'),
	('nightclub',3,'assistant','Assistant du Directeur',85,'{}','{}'),
	('nightclub',4,'boss','Directeur',100,'{}','{}')
;
