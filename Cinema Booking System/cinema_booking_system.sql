CREATE SCHEMA cinema_booking_system;

SHOW DATABASES;

USE cinema_booking_system;

CREATE TABLE films (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL UNIQUE,
    length_min INT NOT NULL
);

CREATE TABLE customers (
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(45),
    last_name VARCHAR(45) NOT NULL,
    email VARCHAR(45) NOT NULL UNIQUE
);

CREATE TABLE rooms (
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(45) NOT NULL,
    no_seats INT NOT NULL
);

CREATE TABLE screenings (
	id INT PRIMARY KEY AUTO_INCREMENT,
    film_id INT NOT NULL,
    room_id INT NOT NULL,
    start_time DATETIME NOT NULL,
    
    FOREIGN KEY (film_id) REFERENCES films(id),
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE seats (
	id INT PRIMARY KEY AUTO_INCREMENT,
    seat_row CHAR(1)  NOT NULL,
    number INT NOT NULL,
    room_id INT,
    
    FOREIGN KEY (room_id) REFERENCES rooms(id)
);

CREATE TABLE bookings (
	id INT PRIMARY KEY AUTO_INCREMENT,
    screening_id INT,
    customer_id INT,
    
    FOREIGN KEY (screening_id) REFERENCES screenings(id),
    FOREIGN KEY (customer_id) REFERENCES customers(id)
);

CREATE TABLE reserverd_seat (
	id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (seat_id) REFERENCES seats(id)
);

DESCRIBE films;
DESCRIBE customers;
DESCRIBE rooms;
DESCRIBE screenings;
DESCRIBE seats;
DESCRIBE bookings;
DESCRIBE reserved_seat;

/*
	COUNT()
    
    this function returns the number of rows that matches a specified criterion.
    
    SELECT COUNT(<column_name>)
	FROM <table_name>
	WHERE <condition>;
*/

SELECT count(*) AS no_customers FROM customers;
SELECT count(first_name) FROM customers;
SELECT count(*) FROM customers WHERE last_name = "Smith";
SELECT count(*) FROM customers WHERE first_name IS NULL;

/*
	SUM()
    
    this function returns the total sum of a numeric column.

	SELECT SUM(<column_name>)
	FROM <table_name>
	WHERE <condition>;	
*/

SELECT sum(no_seats) AS all_cinemas_seats FROM rooms;
SELECT sum(no_seats) FROM rooms WHERE id > 1;

/*	
	MIN()

	Thisfunction returns the smallest value of the selected column.
    
	SELECT MIN(<column_name>)
	FROM <table_name>
	WHERE <condition>;	
*/

SELECT min(length_min) FROM films;

/*
	MAX()
    
	this function returns the largest value of the selected column.

	SELECT MAX(<column_name>)
	FROM <table_name>
	WHERE <condition>;	
*/

SELECT MAX(length_min) FROM films;

/*
	AVG()
    
    this function returns the average value of a numeric column.
    
	SELECT AVG(<column_name>)
	FROM <table_name>
	WHERE <condition>;	
*/

SHOW TABLES;