-- The most recent rental of every customer, with QUALIFY.
SELECT
  customer_id,
  rental_id,
  started_at,
  price_chf
FROM rentals
QUALIFY row_number() OVER (PARTITION BY customer_id ORDER BY started_at DESC) = 1
ORDER BY customer_id;

-- The same without QUALIFY: the window function moves into a subquery, the filter outside.
SELECT
  customer_id,
  rental_id,
  started_at,
  price_chf
FROM (
  SELECT
    customer_id,
    rental_id,
    started_at,
    price_chf,
    row_number() OVER (PARTITION BY customer_id ORDER BY started_at DESC) AS rn
  FROM rentals
) AS ranked
WHERE rn = 1
ORDER BY customer_id;
