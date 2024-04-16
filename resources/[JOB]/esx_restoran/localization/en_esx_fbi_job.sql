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
	('restoran',0,'rank1','Karmand',20,'{}','{}'),
	('restoran',1,'rank2','Karmand',20,'{}','{}'),
	('restoran',2,'boss','Rais',40,'{}','{}'),
;
