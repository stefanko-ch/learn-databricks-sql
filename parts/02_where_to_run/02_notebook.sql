-- Databricks notebook source
-- MAGIC %md
-- MAGIC The script of this part as a notebook: one statement per cell.

-- COMMAND ----------

USE sql_playground.velo;

-- COMMAND ----------

SELECT
  bike_type,
  count(*) AS bikes
FROM bikes
GROUP BY bike_type
ORDER BY bike_type;
