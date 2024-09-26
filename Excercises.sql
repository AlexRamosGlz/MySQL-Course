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

