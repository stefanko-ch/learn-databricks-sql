# SQL style of this series

The style every statement in this folder follows.

- Keywords in upper case, functions in lower case.
- Every clause on its own line: `SELECT`, `FROM`, `WHERE`, `GROUP BY`, `HAVING`, `QUALIFY`, `ORDER BY`, `LIMIT`.
- More than one item in the `SELECT` list: one per line, indented by 2 spaces, comma at the end of the line.
- `AND` / `OR` at the start of a line, indented under `WHERE`.
- `JOIN` on its own line, `ON` indented below it.
- Column and table aliases with `AS` (except where an example shows that it is optional).
- Only the shortest queries stay on one line: one item, one `FROM`, nothing else.
- Several rows in `VALUES`: one row per line, indented by 2 spaces.
- A subquery in parentheses: opening parenthesis at the end of the line, the query indented, the closing
  parenthesis on its own line.

```sql
SELECT name FROM stations;

SELECT
  b.bike_id,
  b.model,
  s.*
FROM bikes AS b, stations AS s
WHERE b.home_station_id = s.station_id
  AND b.bike_id <= 2;
```

`.sqlfluff` holds the same rules for [SQLFluff](https://sqlfluff.com) (dialect `databricks`). It is a helper, not
the judge: SQLFluff 4.5.0 cannot parse some of the syntax this series is about (`TABLE name`, `FROM` first, `|>`,
a star with `EXCEPT` as function arguments), and the statements that are wrong on purpose cannot be parsed at all.
