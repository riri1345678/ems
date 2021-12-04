USE `essentialmode`;

INSERT INTO `addon_account` (name, label, shared) VALUES
	('society_sp', 'sp', 1)
;

INSERT INTO `addon_inventory` (name, label, shared) VALUES
	('society_sp', 'sp', 1)
;

INSERT INTO `datastore` (name, label, shared) VALUES
	('society_sp', 'Sapeur Pompier', 1)
;

INSERT INTO `job_grades` (job_name, grade, name, label, salary) VALUES
	('sp',0,'sp','Ambulancier',20)
	('sp',1,'doctor','Medecin',40,)
	('sp',2,'boss','Chirurgien',80)

INSERT INTO `jobs` (name, label) VALUES
	('sp','sp')
;

INSERT INTO `items` (name, label, `limit`) VALUES
	('bandage','Bandage', 20),
	('medikit','Medikit', 5)
;

ALTER TABLE `users`
	ADD `is_dead` TINYINT(1) NULL DEFAULT '0'
;
