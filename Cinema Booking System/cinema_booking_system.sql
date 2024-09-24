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

DESCRIBE films;
DESCRIBE customers;
DESCRIBE rooms;
DESCRIBE screenings;
DESCRIBE seats;

SHOW TABLES;