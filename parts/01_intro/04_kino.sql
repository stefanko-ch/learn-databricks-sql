-- The second dataset, for the exercises: a small cinema. Every table, every row.
USE sql_playground.kino;

SELECT *
FROM movies
ORDER BY movie_id;

SELECT *
FROM screens
ORDER BY screen_id;

SELECT *
FROM members
ORDER BY member_id;

SELECT *
FROM screenings
ORDER BY screening_id;

SELECT *
FROM tickets
ORDER BY ticket_id;
