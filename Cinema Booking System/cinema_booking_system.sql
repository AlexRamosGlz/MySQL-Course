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

CREATE TABLE reserved_seat (
	id INT PRIMARY KEY AUTO_INCREMENT,
    booking_id INT NOT NULL,
    seat_id INT NOT NULL,
    
    FOREIGN KEY (booking_id) REFERENCES bookings(id),
    FOREIGN KEY (seat_id) REFERENCES seats(id)
);



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

SELECT avg(length_min) FROM films;
SELECT avg(length_min) FROM films WHERE length_min > 120;

################################# Exercise 10.1 ######################################

SELECT count(*) FROM bookings WHERE customer_id = 10;
SELECT count(*) FROM screenings s INNER JOIN films f ON s.film_id = f.id WHERE f.name = 'Blade Runner' AND s.start_time BETWEEN  '2022-10-01' AND '2023-11-01';
SELECT DISTINCT count(*) FROM bookings b INNER JOIN screenings s ON b.screening_id = s.id WHERE s.start_time BETWEEN  '2023-04-01' AND '2023-05-01';

#######################################################################################

/*
	GROUP BY()
    
    The GROUP BY statement groups rows that have the same values into summary rows, like "find the number of customers in each country".
	
    SELECT <column_name(s)>
	FROM <table_name>
	WHERE <condition>
	GROUP BY <column_name(s)>
*/

SELECT customer_id, screening_id, count(*) FROM bookings 
GROUP BY customer_id, screening_id 
ORDER BY customer_id;

SELECT f.name, s.start_time, c.first_name, c.last_name, count(b.id) FROM films f 
JOIN screenings s ON s.film_id = f.id
JOIN bookings b ON b.screening_id = s.id
JOIN customers c ON b.customer_id = c.id
GROUP BY f.name, c.first_name, c.last_name, s.start_time
ORDER BY s.start_time;

/*	
	HAVING

	The HAVING clause was added to SQL because the WHERE keyword cannot be used with aggregate functions.
    
	SELECT <column_name(s)>
	FROM <table_name>
    WHERE <condition>
	GROUP BY <column_name(s)>
	HAVING <condition>
	ORDER BY <column_name(s)>;		 
*/

SELECT customer_id, screening_id, count(*) FROM bookings
GROUP BY customer_id, screening_id
HAVING customer_id < 10
ORDER BY customer_id;

SELECT customer_id, screening_id, count(*) FROM bookings
JOIN screenings ON bookings.screening_id = screenings.id
WHERE  year(screenings.start_time) = '2022'
GROUP BY customer_id, screening_id
HAVING customer_id = 10;

############################################### EXCERCISE 10.02 ##########################################



DESCRIBE films;
DESCRIBE customers;
DESCRIBE rooms;
DESCRIBE screenings;
DESCRIBE seats;
DESCRIBE bookings;
DESCRIBE reserved_seat;



/*
	Non-Correlated subquery
    
    In non-correlated query inner query does not dependent on the outer query. They both can run separately.
*/

-- subquerie in WHERE clause

SELECT id, start_time FROM screenings 
WHERE film_id IN (
	SELECT id FROM films 
    WHERE length_min > 120)
ORDER BY start_time;

SELECT first_name, last_name, email FROM customers
WHERE id IN (
	SELECT customer_id FROM bookings
    WHERE screening_id = 1);
    
-- subquerie after FROM
SELECT avg(no_seats), max(no_seats) FROM
(SELECT booking_id, count(seat_id) AS no_seats FROM reserved_seat 
GROUP BY booking_id) b;

/*
	Correlated subquery
    
    In correlated subquery, inner query is dependent on the outer query. Outer query needs to be executed before inner query
*/

SELECT screening_id, customer_id FROM bookings
ORDER BY screening_id;

SELECT screening_id, customer_id, 

/*
	This inner query is running multiple times, it's running for every 
    single row that was returned by the outer query
*/
( SELECT count(*) FROM reserved_seat WHERE booking_id = b.id ) 

as seats_per_booking
FROM bookings b
ORDER BY screening_id;

########################### Excercise 11.1 #######################################

SELECT name, length_min FROM films
WHERE length_min >
(SELECT avg(length_min) FROM films )
ORDER BY length_min;

SELECT max(no_screenings), min(no_screenings) FROM 
( SELECT film_id, count(*) as no_screenings FROM screenings
GROUP BY film_id ) f;

SELECT *,
	( SELECT count(*) FROM screenings
    WHERE screenings.film_id = f.id) screenings_per_film
 FROM films f
 ORDER BY id;
 
/*
	MySQL Functions
    
    https://dev.mysql.com/doc/refman/8.4/en/string-functions.html
*/

-- CONCAT
SELECT concat(first_name, ' ',last_name) as full_name FROM customers;


/*
	Substrings
    
    substring(string, start, length)
*/
SELECT substring("Example", 3, 3) as SUB; -- -> "amp"
SELECT substring("Example", 3) as SUB; -- -> "ample"

SELECT substring(name, 1, 5) AS short_name FROM films;
SELECT substring(name, -6) AS short_name FROM films;

-- Upper & Lower
SELECT Upper(name) as caps FROM films;
SELECT lower(name) as low FROM films;


############################## Exercise 12.1 ########################

SELECT substring(name, -3) as short_name FROM films;

SELECT CONCAT(substring(first_name, 1, 3), " ",substring(last_name, 1, 3)) FROM customers;

#####################################################################

-- DATE() Function
SELECT date('2023-09-22');
SELECT date('2023-09-22 07:45:32');

SELECT start_time FROM screenings;

SELECT date(start_time) FROM screenings;

SELECT * FROM screenings
WHERE date(start_time) = '2023-07-08'; 

SELECT * FROM screenings
WHERE start_time = '2023-07-08'; -- ->  no start_time matches '2023-07-08'

SELECT * FROM screenings
WHERE date(start_time) BETWEEN '2023-07-08' AND '2023-09-09'; 

-- MONTH() Funtion
SELECT month('2023-09-22 07:45:32');

SELECT MONTH(start_time) FROM screenings;

SELECT * FROM screenings
WHERE MONTH(start_time) = 8;

SELECT MONTH(start_time), count(*) FROM screenings
GROUP BY MONTH(start_time);

-- YEAR() FUNCTION
SELECT YEAR('2023-09-22');

SELECT YEAR(start_time) FROM screenings;

SELECT * FROM screenings
WHERE YEAR(start_time) = '2023';

SELECT YEAR(start_time), count(*) FROM screenings
GROUP BY YEAR(start_time);

########################### EXCERCISE 12.2 ##################################

SELECT film_id, start_time FROM screenings
WHERE DATE(start_time) = '2022-06-18';

SELECT * FROM screenings
WHERE DATE(start_time) BETWEEN '2023-03-06' AND '2023-03-13';

SHOW TABLES;