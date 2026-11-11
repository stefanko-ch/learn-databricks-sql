-- The six tables, every row. ORDER BY only so that the rows come back in the same order every time.
SELECT *
FROM stations
ORDER BY station_id;

SELECT *
FROM bikes
ORDER BY bike_id;

SELECT *
FROM customers
ORDER BY customer_id;

SELECT *
FROM price_changes
ORDER BY valid_from, bike_type;

SELECT *
FROM rentals
ORDER BY rental_id;

SELECT *
FROM rentals_raw
ORDER BY raw:rental_id::int;
