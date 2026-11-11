-- Learn Databricks SQL - the data for the exercises: a small cinema in Lucerne (fictional).
-- Run it once. It creates the catalog `sql_playground` and the schema `kino` in it, if they don't exist yet.
-- All timestamps are UTC.

CREATE CATALOG IF NOT EXISTS sql_playground;
USE CATALOG sql_playground;

CREATE SCHEMA IF NOT EXISTS kino;
USE SCHEMA kino;

CREATE OR REPLACE TABLE movies (
  movie_id INT, title STRING, genre STRING, release_year INT, runtime_min INT, language STRING, age_rating INT
);
INSERT INTO movies VALUES
  (1, 'The Last Tram', 'drama', 2024, 112, 'de', 12),
  (2, 'Nordlicht', 'drama', 2025, 98, 'de', 12),
  (3, 'Paper Planets', 'animation', 2025, 91, 'en', 6),
  (4, 'Zero Kelvin Kiss', 'comedy', 2023, 104, 'en', 12),
  (5, 'Les Heures Bleues', 'drama', 2025, 127, 'fr', 16),
  (6, 'Alpine Static', 'thriller', 2026, NULL, 'de', 16),
  (7, 'paper planets 2', 'animation', 2026, 88, 'en', 6),
  (8, 'The Quiet Orchard', 'Drama', 2022, 119, 'en', 12);

CREATE OR REPLACE TABLE screens (
  screen_id INT, name STRING, seats INT, has_3d BOOLEAN, opened_on DATE
);
INSERT INTO screens VALUES
  (1, 'Saal 1', 120, true, DATE'2015-09-01'),
  (2, 'Saal 2', 64, false, DATE'2015-09-01'),
  (3, 'Studio', 28, false, DATE'2021-03-12'),
  (4, 'Open Air', NULL, false, DATE'2026-06-01');

CREATE OR REPLACE TABLE members (
  member_id INT, first_name STRING, last_name STRING, email STRING, city STRING, joined_on DATE, tier STRING
);
INSERT INTO members VALUES
  (1, 'Lea', 'Huber', 'lea.huber@example.com', 'Luzern', DATE'2023-02-11', 'gold'),
  (2, 'Marco', 'Frei', 'marco.frei@example.com', 'Luzern', DATE'2024-06-30', 'silver'),
  (3, 'Nina', 'Graf', NULL, 'Kriens', DATE'2024-09-14', 'silver'),
  (4, 'David', 'Suter', 'david.suter@example.com', 'Lucerne', DATE'2025-01-05', NULL),
  (5, 'Sara', 'Vogel', 'sara.vogel@example.com', 'Luzern', DATE'2025-04-19', 'gold'),
  (6, 'Marco', 'FREI', 'Marco.Frei@Example.com', 'Luzern', DATE'2025-11-02', 'silver'),
  (7, 'Jan', 'Kunz', 'jan.kunz@example.com', 'Horw', DATE'2026-01-08', 'silver'),
  (8, NULL, 'Filmclub Tribschen', 'info@filmclub.example', 'Luzern', DATE'2022-10-01', 'club');

CREATE OR REPLACE TABLE screenings (
  screening_id INT, movie_id INT, screen_id INT, starts_at TIMESTAMP, language_version STRING, format STRING,
  base_price_chf DECIMAL(6,2)
);
INSERT INTO screenings VALUES
  (1, 1, 1, TIMESTAMP'2026-03-02 17:30:00Z', 'OV', '2D', 18.00),
  (2, 3, 2, TIMESTAMP'2026-03-02 13:00:00Z', 'DE', '2D', 14.00),
  (3, 2, 3, TIMESTAMP'2026-03-03 19:15:00Z', 'OV', '2D', 16.00),
  (4, 4, 1, TIMESTAMP'2026-03-04 19:30:00Z', 'OV', '2D', 18.00),
  (5, 3, 1, TIMESTAMP'2026-03-04 14:00:00Z', 'DE', '3D', 17.00),
  (6, 5, 3, TIMESTAMP'2026-03-05 19:00:00Z', 'OV', '2D', 16.00),
  (7, 1, 2, TIMESTAMP'2026-03-06 16:45:00Z', 'OV', '2D', 18.00),
  (8, 6, 1, TIMESTAMP'2026-03-06 22:30:00Z', 'OV', '2D', 20.00),
  (9, 7, 2, TIMESTAMP'2026-03-07 10:00:00Z', 'DE', '2D', 14.00),
  (10, 4, 3, TIMESTAMP'2026-03-07 21:45:00Z', 'OV', '2D', 16.00),
  (11, 2, 1, TIMESTAMP'2026-03-08 10:30:00Z', 'OV', '2D', NULL),
  (12, 5, 2, TIMESTAMP'2026-03-08 18:00:00Z', 'OV', '2D', 16.00);

CREATE OR REPLACE TABLE tickets (
  ticket_id INT, screening_id INT, member_id INT, seat STRING, price_chf DECIMAL(6,2), discount STRING,
  channel STRING, sold_at TIMESTAMP
);
INSERT INTO tickets VALUES
  (1, 1, 1, 'F7', 18.00, NULL, 'web', TIMESTAMP'2026-03-01 09:12:00Z'),
  (2, 1, 1, 'F8', 18.00, NULL, 'web', TIMESTAMP'2026-03-01 09:12:00Z'),
  (3, 1, NULL, 'C3', 14.00, 'student', 'box office', TIMESTAMP'2026-03-02 17:10:00Z'),
  (4, 2, 3, 'B1', 9.00, 'kids', 'app', TIMESTAMP'2026-03-01 18:40:00Z'),
  (5, 2, 3, 'B2', 9.00, 'kids', 'app', TIMESTAMP'2026-03-01 18:40:00Z'),
  (6, 2, 3, 'B3', 14.00, NULL, 'app', TIMESTAMP'2026-03-01 18:40:00Z'),
  (7, 3, 2, 'D4', 16.00, NULL, 'web', TIMESTAMP'2026-03-02 20:05:00Z'),
  (8, 3, 5, 'D5', 12.00, 'student', 'app', TIMESTAMP'2026-03-03 12:30:00Z'),
  (9, 4, 4, 'G10', 18.00, NULL, 'web', TIMESTAMP'2026-03-03 08:00:00Z'),
  (10, 4, 6, 'G10', 18.00, NULL, 'app', TIMESTAMP'2026-03-03 08:01:00Z'),
  (11, 4, NULL, 'A1', 18.00, NULL, 'box office', TIMESTAMP'2026-03-04 19:20:00Z'),
  (12, 4, 8, 'H1', 18.00, NULL, 'web', TIMESTAMP'2026-02-27 10:00:00Z'),
  (13, 4, 8, 'H2', 18.00, NULL, 'web', TIMESTAMP'2026-02-27 10:00:00Z'),
  (14, 4, 8, 'H3', 18.00, NULL, 'web', TIMESTAMP'2026-02-27 10:00:00Z'),
  (15, 5, 5, 'E5', 12.00, 'kids', 'app', TIMESTAMP'2026-03-02 07:45:00Z'),
  (16, 5, 5, 'E6', 17.00, NULL, 'app', TIMESTAMP'2026-03-02 07:45:00Z'),
  (17, 99, 2, 'A2', 16.00, NULL, 'web', TIMESTAMP'2026-03-04 11:11:00Z'),
  (18, 6, 1, 'C1', 0.00, 'voucher', 'web', TIMESTAMP'2026-03-04 21:00:00Z'),
  (19, 6, NULL, 'C2', 16.00, NULL, 'box office', TIMESTAMP'2026-03-05 18:50:00Z'),
  (20, 7, 2, 'D1', 14.00, 'student', 'web', TIMESTAMP'2026-03-05 13:00:00Z'),
  (21, 7, 6, 'D2', 18.00, NULL, 'app', TIMESTAMP'2026-03-06 09:30:00Z'),
  (22, 8, 1, 'F7', 20.00, NULL, 'web', TIMESTAMP'2026-03-01 09:15:00Z'),
  (23, 8, 5, 'F8', 20.00, NULL, 'app', TIMESTAMP'2026-03-05 22:10:00Z'),
  (24, 8, NULL, 'K12', NULL, NULL, 'phone', TIMESTAMP'2026-03-06 15:00:00Z'),
  (25, 9, 3, 'A1', 9.00, 'kids', 'app', TIMESTAMP'2026-03-06 19:00:00Z'),
  (26, 9, 3, 'A2', 9.00, 'kids', 'app', TIMESTAMP'2026-03-06 19:00:00Z'),
  (27, 10, 4, 'B4', 16.00, NULL, 'web', TIMESTAMP'2026-03-07 20:00:00Z'),
  (28, 12, 8, 'C5', 16.00, NULL, 'web', TIMESTAMP'2026-03-06 10:00:00Z');
