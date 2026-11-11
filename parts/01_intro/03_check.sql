-- After the setup script: do you have the same data?
SELECT 'bikes' AS table_name, count(*) AS row_count FROM bikes
UNION ALL
SELECT 'customers', count(*) FROM customers
UNION ALL
SELECT 'price_changes', count(*) FROM price_changes
UNION ALL
SELECT 'rentals', count(*) FROM rentals
UNION ALL
SELECT 'rentals_raw', count(*) FROM rentals_raw
UNION ALL
SELECT 'stations', count(*) FROM stations
ORDER BY table_name;

-- The time zone of the session decides how a timestamp is displayed.
SELECT current_timezone() AS session_time_zone;

-- Two rentals in UTC and in local time (Europe/Zurich: CET in winter, CEST in summer): one over midnight, one over the switch to summer time.
SELECT
  rental_id,
  started_at,
  ended_at,
  from_utc_timestamp(started_at, 'Europe/Zurich') AS started_local,
  from_utc_timestamp(ended_at, 'Europe/Zurich') AS ended_local
FROM rentals
WHERE rental_id IN (18, 23)
ORDER BY rental_id;
