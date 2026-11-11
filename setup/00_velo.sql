-- Learn Databricks SQL - the sample data: a small bike rental in Lucerne (fictional).
-- Run it once. It creates the catalog `sql_playground` and the schema `velo` in it, if they don't exist yet.
-- All timestamps are UTC.

CREATE CATALOG IF NOT EXISTS sql_playground;
USE CATALOG sql_playground;

CREATE SCHEMA IF NOT EXISTS velo;
USE SCHEMA velo;

CREATE OR REPLACE TABLE stations (
  station_id INT, name STRING, postal_code INT, latitude DOUBLE, longitude DOUBLE, capacity INT, opened_on DATE
);
INSERT INTO stations VALUES
  (1, 'Bahnhof', 6003, 47.0502, 8.3102, 24, DATE'2022-05-01'),
  (2, 'Schwanenplatz', 6004, 47.0533, 8.3089, 16, DATE'2022-05-01'),
  (3, 'Verkehrshaus', 6006, 47.0539, 8.3373, 20, DATE'2023-04-01'),
  (4, 'Allmend', 6005, 47.0351, 8.3032, 12, DATE'2023-04-01'),
  (5, 'Kantonsspital', 6004, 47.0578, 8.298, 10, DATE'2024-06-15'),
  (6, 'Littau', 6014, 47.0531, 8.2571, NULL, DATE'2026-04-15');

CREATE OR REPLACE TABLE bikes (
  bike_id INT, model STRING, bike_type STRING, purchased_on DATE, purchase_price DECIMAL(8,2),
  home_station_id INT, status STRING
);
INSERT INTO bikes VALUES
  (1, 'Tour 3', 'city', DATE'2023-04-12', 890.00, 1, 'active'),
  (2, 'Tour 3', 'city', DATE'2023-04-12', 890.00, 2, 'active'),
  (3, 'Tour 3', 'city', DATE'2024-03-01', 940.00, 1, 'active'),
  (4, 'Urban S', 'city', DATE'2024-03-01', 1120.00, 4, 'active'),
  (5, 'Urban S', 'city', DATE'2025-02-17', 1150.00, 2, 'active'),
  (6, 'Volt E1', 'e-bike', DATE'2024-05-20', 3400.00, 3, 'active'),
  (7, 'Volt E1', 'e-bike', DATE'2022-06-03', 3250.00, 1, 'retired'),
  (8, 'Volt E2', 'e-bike', DATE'2025-02-17', 3890.00, 3, 'active'),
  (9, 'Volt E2', 'e-bike', DATE'2025-02-17', 3890.00, 5, 'active'),
  (10, 'Cargo L', 'cargo', DATE'2024-09-09', 5600.00, 4, 'active'),
  (11, 'Cargo L', 'cargo', DATE'2024-09-09', 5600.00, NULL, 'maintenance'),
  (12, 'Volt E2', 'e-bike', DATE'2026-03-30', 3990.00, 3, 'active');

CREATE OR REPLACE TABLE customers (
  customer_id INT, first_name STRING, last_name STRING, email STRING, city STRING, signed_up_on DATE, plan STRING
);
INSERT INTO customers VALUES
  (1, 'Luca', 'Keller', 'luca.keller@example.com', 'Luzern', DATE'2024-05-02', 'plus'),
  (2, 'Mia', 'Schmid', 'mia.schmid@example.com', 'Luzern', DATE'2024-08-19', 'plus'),
  (3, 'Noah', 'Weber', 'noah.weber@example.com', 'Kriens', DATE'2025-01-11', 'basic'),
  (4, 'Anna', 'Meier', 'anna.meier@example.com', 'luzern', DATE'2025-03-07', 'basic'),
  (5, 'Elena', 'Fischer', NULL, 'Luzern', DATE'2025-06-23', 'basic'),
  (6, 'Jonas', 'Müller', 'jonas.mueller@example.com', 'LUZERN', DATE'2025-09-01', 'plus'),
  (7, 'Sofia', 'Brunner', 'sofia.brunner@example.com', 'Emmen', DATE'2025-11-15', NULL),
  (8, NULL, 'Stadtkurier GmbH', 'dispo@stadtkurier.example', 'Luzern', DATE'2024-02-01', 'business'),
  (9, 'ANNA', 'MEIER', ' Anna.Meier@Example.com ', 'Luzern', DATE'2026-01-20', 'plus'),
  (10, 'Tim', 'Baumann', 'tim.baumann@example.com', 'Küssnacht', DATE'2026-03-15', 'basic');

CREATE OR REPLACE TABLE price_changes (
  bike_type STRING, valid_from DATE, unlock_fee DECIMAL(6,2), price_per_30_min DECIMAL(6,2)
);
INSERT INTO price_changes VALUES
  ('city', DATE'2026-01-01', 1.00, 1.50),
  ('e-bike', DATE'2026-01-01', 1.50, 3.00),
  ('cargo', DATE'2026-01-01', 2.00, 4.00),
  ('city', DATE'2026-03-28', 1.00, 2.00),
  ('e-bike', DATE'2026-03-28', 2.00, 3.50),
  ('cargo', DATE'2026-03-28', 2.00, 4.50);

CREATE OR REPLACE TABLE rentals (
  rental_id INT, bike_id INT, customer_id INT, start_station_id INT, end_station_id INT,
  started_at TIMESTAMP, ended_at TIMESTAMP, distance_km DECIMAL(5,1), price_chf DECIMAL(6,2), payment_method STRING
);
INSERT INTO rentals VALUES
  (1, 1, 1, 1, 2, TIMESTAMP'2026-03-23 06:42:00Z', TIMESTAMP'2026-03-23 07:00:00Z', 3.2, 2.50, 'card'),
  (2, 6, 2, 3, 1, TIMESTAMP'2026-03-23 07:05:00Z', TIMESTAMP'2026-03-23 07:29:00Z', 6.1, 4.50, 'twint'),
  (3, 2, 3, 2, 5, TIMESTAMP'2026-03-23 11:30:00Z', TIMESTAMP'2026-03-23 12:11:00Z', 5.4, 4.00, 'card'),
  (4, 10, 5, 4, 4, TIMESTAMP'2026-03-23 13:15:00Z', TIMESTAMP'2026-03-23 14:50:00Z', 7.8, 18.00, 'twint'),
  (5, 7, 4, 1, 3, TIMESTAMP'2026-03-24 06:50:00Z', TIMESTAMP'2026-03-24 07:17:00Z', 6.4, 4.50, 'card'),
  (6, 3, 1, 1, 2, TIMESTAMP'2026-03-24 06:44:00Z', TIMESTAMP'2026-03-24 07:00:00Z', 3.1, 2.50, 'card'),
  (7, 8, 6, 5, 1, TIMESTAMP'2026-03-24 16:20:00Z', TIMESTAMP'2026-03-24 16:42:00Z', 4.0, 4.50, 'twint'),
  (8, 1, 7, 2, 2, TIMESTAMP'2026-03-24 18:05:00Z', TIMESTAMP'2026-03-24 19:08:00Z', 9.5, 5.50, 'card'),
  (9, 6, 2, 3, 1, TIMESTAMP'2026-03-25 07:02:00Z', TIMESTAMP'2026-03-25 07:27:00Z', 6.0, 4.50, 'twint'),
  (10, 4, 8, 4, 1, TIMESTAMP'2026-03-25 07:30:00Z', TIMESTAMP'2026-03-25 08:03:00Z', 7.2, 4.00, 'invoice'),
  (11, 11, 5, 4, 5, TIMESTAMP'2026-03-25 09:10:00Z', TIMESTAMP'2026-03-25 11:10:00Z', 11.3, 18.00, 'twint'),
  (12, 2, 9, 1, 3, TIMESTAMP'2026-03-25 17:45:00Z', TIMESTAMP'2026-03-25 18:14:00Z', 6.6, 2.50, 'card'),
  (13, 9, 3, 5, 2, TIMESTAMP'2026-03-26 12:10:00Z', TIMESTAMP'2026-03-26 12:24:00Z', 2.2, 4.50, 'card'),
  (14, 3, 1, 1, 2, TIMESTAMP'2026-03-26 06:41:00Z', TIMESTAMP'2026-03-26 06:58:00Z', 3.2, 2.50, 'card'),
  (15, 7, 6, 1, 5, TIMESTAMP'2026-03-26 21:15:00Z', TIMESTAMP'2026-03-26 21:34:00Z', 3.5, 4.50, 'twint'),
  (16, 5, 99, 2, 1, TIMESTAMP'2026-03-26 14:00:00Z', TIMESTAMP'2026-03-26 14:12:00Z', 1.9, 2.50, 'card'),
  (17, 8, 2, 3, 1, TIMESTAMP'2026-03-27 07:04:00Z', TIMESTAMP'2026-03-27 07:30:00Z', 6.1, 4.50, 'twint'),
  (18, 1, 4, 1, 4, TIMESTAMP'2026-03-27 23:40:00Z', TIMESTAMP'2026-03-28 00:25:00Z', 8.0, 4.00, 'card'),
  (19, 10, 7, 2, 3, TIMESTAMP'2026-03-28 10:00:00Z', TIMESTAMP'2026-03-28 12:30:00Z', 14.2, 24.50, 'card'),
  (20, 6, 8, 4, 1, TIMESTAMP'2026-03-28 08:15:00Z', TIMESTAMP'2026-03-28 08:46:00Z', 7.0, 9.00, 'invoice'),
  (21, 2, 1, 1, 2, TIMESTAMP'2026-03-28 09:30:00Z', TIMESTAMP'2026-03-28 09:45:00Z', 3.0, 0.00, NULL),
  (22, 9, 3, 5, 5, TIMESTAMP'2026-03-28 15:20:00Z', TIMESTAMP'2026-03-28 16:48:00Z', 12.4, 12.50, 'card'),
  (23, 4, 6, 1, 5, TIMESTAMP'2026-03-29 00:50:00Z', TIMESTAMP'2026-03-29 01:20:00Z', 4.1, 3.00, 'twint'),
  (24, 3, 9, 3, 2, TIMESTAMP'2026-03-29 13:05:00Z', TIMESTAMP'2026-03-29 13:57:00Z', 8.8, 5.00, 'card'),
  (25, 8, 2, 3, 1, TIMESTAMP'2026-03-30 06:03:00Z', TIMESTAMP'2026-03-30 06:28:00Z', 6.0, 5.50, 'twint'),
  (26, 1, 1, 1, 2, TIMESTAMP'2026-03-30 05:42:00Z', TIMESTAMP'2026-03-30 05:59:00Z', 3.1, 3.00, 'card'),
  (27, 5, 5, 4, 4, TIMESTAMP'2026-03-30 12:30:00Z', TIMESTAMP'2026-03-30 12:50:00Z', 2.7, 3.00, 'twint'),
  (28, 6, 8, 4, 1, TIMESTAMP'2026-03-31 06:15:00Z', TIMESTAMP'2026-03-31 06:45:00Z', 7.1, 5.50, 'invoice'),
  (29, 9, 7, 2, 1, TIMESTAMP'2026-03-31 16:40:00Z', TIMESTAMP'2026-03-31 17:16:00Z', 5.9, 9.00, 'card'),
  (30, 2, 3, 5, NULL, TIMESTAMP'2026-03-31 17:55:00Z', NULL, NULL, NULL, NULL);

-- the same rentals as the app sent them: one JSON document per rental, with tags and app details
CREATE OR REPLACE TABLE rentals_raw (raw STRING);
INSERT INTO rentals_raw VALUES
  ('{"rental_id":1,"bike":{"id":1,"type":"city"},"customer_id":1,"start":{"station_id":1,"ts":"2026-03-23T06:42:00Z"},"end":{"station_id":2,"ts":"2026-03-23T07:00:00Z"},"distance_km":3.2,"price_chf":2.5,"payment":"card","tags":["commute"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":2,"bike":{"id":6,"type":"e-bike"},"customer_id":2,"start":{"station_id":3,"ts":"2026-03-23T07:05:00Z"},"end":{"station_id":1,"ts":"2026-03-23T07:29:00Z"},"distance_km":6.1,"price_chf":4.5,"payment":"twint","tags":["commute"],"app":{"os":"Android","version":"2.4.1"}}'),
  ('{"rental_id":3,"bike":{"id":2,"type":"city"},"customer_id":3,"start":{"station_id":2,"ts":"2026-03-23T11:30:00Z"},"end":{"station_id":5,"ts":"2026-03-23T12:11:00Z"},"distance_km":5.4,"price_chf":4.0,"payment":"card","tags":["leisure"],"app":{"os":"iOS","version":"2.3.0"}}'),
  ('{"rental_id":4,"bike":{"id":10,"type":"cargo"},"customer_id":5,"start":{"station_id":4,"ts":"2026-03-23T13:15:00Z"},"end":{"station_id":4,"ts":"2026-03-23T14:50:00Z"},"distance_km":7.8,"price_chf":18.0,"payment":"twint","tags":["shopping","kids"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":5,"bike":{"id":7,"type":"e-bike"},"customer_id":4,"start":{"station_id":1,"ts":"2026-03-24T06:50:00Z"},"end":{"station_id":3,"ts":"2026-03-24T07:17:00Z"},"distance_km":6.4,"price_chf":4.5,"payment":"card","tags":["commute"],"app":{"os":"Android","version":"2.4.0"}}'),
  ('{"rental_id":6,"bike":{"id":3,"type":"city"},"customer_id":1,"start":{"station_id":1,"ts":"2026-03-24T06:44:00Z"},"end":{"station_id":2,"ts":"2026-03-24T07:00:00Z"},"distance_km":3.1,"price_chf":2.5,"payment":"card","tags":["commute"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":7,"bike":{"id":8,"type":"e-bike"},"customer_id":6,"start":{"station_id":5,"ts":"2026-03-24T16:20:00Z"},"end":{"station_id":1,"ts":"2026-03-24T16:42:00Z"},"distance_km":4.0,"price_chf":4.5,"payment":"twint","tags":["commute","rain"],"app":{"os":"Android","version":"2.2.5"}}'),
  ('{"rental_id":8,"bike":{"id":1,"type":"city"},"customer_id":7,"start":{"station_id":2,"ts":"2026-03-24T18:05:00Z"},"end":{"station_id":2,"ts":"2026-03-24T19:08:00Z"},"distance_km":9.5,"price_chf":5.5,"payment":"card","tags":["leisure"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":9,"bike":{"id":6,"type":"e-bike"},"customer_id":2,"start":{"station_id":3,"ts":"2026-03-25T07:02:00Z"},"end":{"station_id":1,"ts":"2026-03-25T07:27:00Z"},"distance_km":6.0,"price_chf":4.5,"payment":"twint","tags":["commute"],"app":{"os":"Android","version":"2.4.1"}}'),
  ('{"rental_id":10,"bike":{"id":4,"type":"city"},"customer_id":8,"start":{"station_id":4,"ts":"2026-03-25T07:30:00Z"},"end":{"station_id":1,"ts":"2026-03-25T08:03:00Z"},"distance_km":7.2,"price_chf":4.0,"payment":"invoice","tags":["commute"],"app":{"os":"web","version":null}}'),
  ('{"rental_id":11,"bike":{"id":11,"type":"cargo"},"customer_id":5,"start":{"station_id":4,"ts":"2026-03-25T09:10:00Z"},"end":{"station_id":5,"ts":"2026-03-25T11:10:00Z"},"distance_km":11.3,"price_chf":18.0,"payment":"twint","tags":["shopping"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":12,"bike":{"id":2,"type":"city"},"customer_id":9,"start":{"station_id":1,"ts":"2026-03-25T17:45:00Z"},"end":{"station_id":3,"ts":"2026-03-25T18:14:00Z"},"distance_km":6.6,"price_chf":2.5,"payment":"card","tags":["commute"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":13,"bike":{"id":9,"type":"e-bike"},"customer_id":3,"start":{"station_id":5,"ts":"2026-03-26T12:10:00Z"},"end":{"station_id":2,"ts":"2026-03-26T12:24:00Z"},"distance_km":2.2,"price_chf":4.5,"payment":"card","tags":[],"app":{"os":"iOS","version":"2.3.0"}}'),
  ('{"rental_id":14,"bike":{"id":3,"type":"city"},"customer_id":1,"start":{"station_id":1,"ts":"2026-03-26T06:41:00Z"},"end":{"station_id":2,"ts":"2026-03-26T06:58:00Z"},"distance_km":3.2,"price_chf":2.5,"payment":"card","tags":["commute"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":15,"bike":{"id":7,"type":"e-bike"},"customer_id":6,"start":{"station_id":1,"ts":"2026-03-26T21:15:00Z"},"end":{"station_id":5,"ts":"2026-03-26T21:34:00Z"},"distance_km":3.5,"price_chf":4.5,"payment":"twint","tags":["night"],"app":{"os":"Android","version":"2.2.5"}}'),
  ('{"rental_id":16,"bike":{"id":5,"type":"city"},"customer_id":99,"start":{"station_id":2,"ts":"2026-03-26T14:00:00Z"},"end":{"station_id":1,"ts":"2026-03-26T14:12:00Z"},"distance_km":1.9,"price_chf":2.5,"payment":"card","tags":[],"app":{"os":"Android","version":"2.1.0"}}'),
  ('{"rental_id":17,"bike":{"id":8,"type":"e-bike"},"customer_id":2,"start":{"station_id":3,"ts":"2026-03-27T07:04:00Z"},"end":{"station_id":1,"ts":"2026-03-27T07:30:00Z"},"distance_km":6.1,"price_chf":4.5,"payment":"twint","tags":["commute","rain"],"app":{"os":"Android","version":"2.4.1"}}'),
  ('{"rental_id":18,"bike":{"id":1,"type":"city"},"customer_id":4,"start":{"station_id":1,"ts":"2026-03-27T23:40:00Z"},"end":{"station_id":4,"ts":"2026-03-28T00:25:00Z"},"distance_km":8.0,"price_chf":4.0,"payment":"card","tags":["night"],"app":{"os":"Android","version":"2.4.0"}}'),
  ('{"rental_id":19,"bike":{"id":10,"type":"cargo"},"customer_id":7,"start":{"station_id":2,"ts":"2026-03-28T10:00:00Z"},"end":{"station_id":3,"ts":"2026-03-28T12:30:00Z"},"distance_km":14.2,"price_chf":24.5,"payment":"card","tags":["leisure","kids"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":20,"bike":{"id":6,"type":"e-bike"},"customer_id":8,"start":{"station_id":4,"ts":"2026-03-28T08:15:00Z"},"end":{"station_id":1,"ts":"2026-03-28T08:46:00Z"},"distance_km":7.0,"price_chf":9.0,"payment":"invoice","tags":[],"app":{"os":"web","version":null}}'),
  ('{"rental_id":21,"bike":{"id":2,"type":"city"},"customer_id":1,"start":{"station_id":1,"ts":"2026-03-28T09:30:00Z"},"end":{"station_id":2,"ts":"2026-03-28T09:45:00Z"},"distance_km":3.0,"price_chf":0.0,"payment":null,"tags":["promo"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":22,"bike":{"id":9,"type":"e-bike"},"customer_id":3,"start":{"station_id":5,"ts":"2026-03-28T15:20:00Z"},"end":{"station_id":5,"ts":"2026-03-28T16:48:00Z"},"distance_km":12.4,"price_chf":12.5,"payment":"card","tags":["leisure"],"app":{"os":"iOS","version":"2.3.0"}}'),
  ('{"rental_id":23,"bike":{"id":4,"type":"city"},"customer_id":6,"start":{"station_id":1,"ts":"2026-03-29T00:50:00Z"},"end":{"station_id":5,"ts":"2026-03-29T01:20:00Z"},"distance_km":4.1,"price_chf":3.0,"payment":"twint","tags":["night"],"app":{"os":"Android","version":"2.2.5"}}'),
  ('{"rental_id":24,"bike":{"id":3,"type":"city"},"customer_id":9,"start":{"station_id":3,"ts":"2026-03-29T13:05:00Z"},"end":{"station_id":2,"ts":"2026-03-29T13:57:00Z"},"distance_km":8.8,"price_chf":5.0,"payment":"card","tags":["leisure"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":25,"bike":{"id":8,"type":"e-bike"},"customer_id":2,"start":{"station_id":3,"ts":"2026-03-30T06:03:00Z"},"end":{"station_id":1,"ts":"2026-03-30T06:28:00Z"},"distance_km":6.0,"price_chf":5.5,"payment":"twint","tags":["commute"],"app":{"os":"Android","version":"2.4.1"}}'),
  ('{"rental_id":26,"bike":{"id":1,"type":"city"},"customer_id":1,"start":{"station_id":1,"ts":"2026-03-30T05:42:00Z"},"end":{"station_id":2,"ts":"2026-03-30T05:59:00Z"},"distance_km":3.1,"price_chf":3.0,"payment":"card","tags":["commute"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":27,"bike":{"id":5,"type":"city"},"customer_id":5,"start":{"station_id":4,"ts":"2026-03-30T12:30:00Z"},"end":{"station_id":4,"ts":"2026-03-30T12:50:00Z"},"distance_km":2.7,"price_chf":3.0,"payment":"twint","tags":["shopping"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":28,"bike":{"id":6,"type":"e-bike"},"customer_id":8,"start":{"station_id":4,"ts":"2026-03-31T06:15:00Z"},"end":{"station_id":1,"ts":"2026-03-31T06:45:00Z"},"distance_km":7.1,"price_chf":5.5,"payment":"invoice","tags":["commute"],"app":{"os":"web","version":null}}'),
  ('{"rental_id":29,"bike":{"id":9,"type":"e-bike"},"customer_id":7,"start":{"station_id":2,"ts":"2026-03-31T16:40:00Z"},"end":{"station_id":1,"ts":"2026-03-31T17:16:00Z"},"distance_km":5.9,"price_chf":9.0,"payment":"card","tags":["commute","rain"],"app":{"os":"iOS","version":"2.4.1"}}'),
  ('{"rental_id":30,"bike":{"id":2,"type":"city"},"customer_id":3,"start":{"station_id":5,"ts":"2026-03-31T17:55:00Z"},"end":null,"distance_km":null,"price_chf":null,"payment":null,"tags":["leisure"],"app":{"os":"iOS","version":"2.3.0"}}');
