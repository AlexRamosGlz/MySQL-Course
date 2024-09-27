USE cinema_booking_system;

-- Which films are more than 2 hours long?

SELECT * FROM films
WHERE length_min > 120;

-- Which film (or films) had the most screenings?
select f.name, max(films_screened) as most_viewed FROM (SELECT film_id, count(*) as films_screened FROM screenings GROUP BY film_id) sc
JOIN films f ON sc.film_id = f.id
GROUP BY f.name
ORDER BY most_viewed DESC
LIMIT 1;

-- How many bookings did the film Jigsaw have, in May 2022?
SELECT f.name, count(*) AS booked FROM bookings b
JOIN screenings s ON b.screening_id = s.id
JOIN films f ON f.id = s.film_id
WHERE f.name = "Jigsaw" AND DATE(s.start_time) BETWEEN '2022-05-01' AND '2022-06-01'
GROUP BY f.name;

-- Which five customer made the most bookings
SELECT concat(c.first_name, ' ', c.last_name) AS full_name, count(*) as booked FROM bookings b
INNER JOIN customers c ON c.id = b.customer_id
GROUP BY full_name
ORDER BY booked DESC
LIMIT 5;

-- In the chaplin room, which film was shown most often?
SELECT f.name, count(*) AS no_screenings FROM screenings s
JOIN rooms r ON s.room_id = r.id
JOIN films f ON s.film_id = f.id
WHERE r.name = "Chaplin"
GROUP BY f.name
ORDER BY no_screenings DESC
LIMIT 1;

-- How many of our customers have made a booking?
SELECT count(DISTINCT(customer_id)) FROM bookings;

SHOW TABLES;
DESCRIBE rooms;
DESCRIBE bookings;
DESCRIBE customers;