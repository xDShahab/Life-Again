INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_sheriff', 'sheriff', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_sheriff', 'sheriff', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_sheriff', 'sheriff', 1)
;

INSERT INTO `jobs` (name, label) VALUES
	('sheriff','sheriff')
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary, skin_male, skin_female) VALUES
	('sheriff',0,'agent','Agent',20,'{}','{}'),
	('sheriff',1,'special','Agent Expérimenté',40,'{}','{}'),
	('sheriff',2,'supervisor','Superviseur',60,'{}','{}'),
	('sheriff',3,'assistant','Assistant du Directeur',85,'{}','{}'),
	('sheriff',4,'boss','Directeur',100,'{}','{}')
;
