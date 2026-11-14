-- The script every way of running SQL gets in this part: two statements, the second depends on the first.
USE sql_playground.velo;

SELECT
  bike_type,
  count(*) AS bikes
FROM bikes
GROUP BY bike_type
ORDER BY bike_type;
