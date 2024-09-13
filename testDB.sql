CREATE DATABASE test;

USE test;

SHOW DATABASES;

CREATE TABLE addresses (
	id INT,
    house_number INT,
    city VARCHAR(20),
    postcode VARCHAR(7)
);

####### ADDING AND REMOVING PRIMARY KEYS #####################

DESCRIBE addresses;

-- Add primary key after creating a table --
-- ALTER TABLE <table_name>
-- ADD PRIMARY KEY (<column_name>);

ALTER TABLE addresses
ADD PRIMARY KEY (id);

-- Remove primary key after creating a table --
-- ALTER TABLE <table_name>
-- DROP PRIMARY KEY;

ALTER TABLE addresses
DROP PRIMARY KEY;

###############################################

######### MODIFYG A COLUMN DATA TYPE ##########

-- ALTER TABLE <table name>
-- CHANGE <current_column_name> <new_column_name> <data_type>;

-- ALTER TABLE <table_name>
-- MODIFY <column_name> <data_type>;
ALTER TABLE addresses 
MODIFY id INT;

-- ################################################

CREATE TABLE people (
	id INT,
    first_name  VARCHAR(20),
    last_name VARCHAR(20),
    address_id INT
);

ALTER TABLE people
ADD PRIMARY KEY (id);

CREATE TABLE pets (
	id INT,
    name VARCHAR(20),
    species VARCHAR(20),
    owner_id INT
);


######### Add and Remove Foreign keys #############

-- Add foreign key to a table --
-- ALTER TABLE <table_name>
-- ADD CONSTRAINT <constraint_name>
-- FOREIGN KEY (<column_name) REFERENCES <table_name>(<column_name>);

ALTER TABLE people
ADD CONSTRAINT FK_PeopleAddress
FOREIGN KEY (address_id) REFERENCES addresses(id);

-- Remove foreign key to a table --
-- ALTER TABLE <table_name>
-- DROP FOREIGN KEY <constraint_name>
-- DROP INDEX <constraint_name>

-- SQL automatically creates and index when adding a foreign key, so in order to fully remove 
-- a foreign key we must also remove it's index
ALTER TABLE people
DROP FOREIGN KEY FK_PeopleAddress,
DROP INDEX FK_PeopleAddress;

#######################################################


###### Add and remove unique constraints ##########

-- Add a unique constraint to a column --
-- ALTER TABLE <table_name>
-- ADD CONSTRAINT <contraint_name> UNIQUE (<column_name>);

ALTER TABLE pets
ADD CONSTRAINT u_species UNIQUE (species);

-- Remove a unique constraint from a column --
-- ALTER TALBE <table_name>
-- DROP INDEX <constraint_name>;

ALTER TABLE pets
DROP INDEX u_species;

#########################################################

############# RENAME COLUMN NAME ########################

-- Rename with new data type --
-- ALTER TABLE <table name>
-- CHANGE <current_column_name> <new_column_name> <data_type>;

ALTER TABLE pets
CHANGE species animal_type VARCHAR(20);
 
 -- Rename ONLY --
-- ALTER TABLE <table name>
-- RENAME COLUMN <current_column_name> TO <new_column_name>;

ALTER TABLE pets
RENAME COLUMN animal_type TO species;

#############################################################

################ EXERCISE 4.1 ###############################

ALTER TABLE pets
ADD PRIMARY KEY (id);

ALTER TABLE pets
ADD CONSTRAINT FK_PetsPeople
FOREIGN KEY (owner_id) REFERENCES people(id);

ALTER TABLE people
ADD COLUMN email varchar(20);

ALTER TABLE people
ADD CONSTRAINT u_email UNIQUE (email);

ALTER TABLE pets
RENAME COLUMN name TO first_name;

DESCRIBE people;
DESCRIBE addresses;
DESCRIBE pets;

SHOW TABLES;