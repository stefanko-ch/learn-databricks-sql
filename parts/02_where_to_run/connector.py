# /// script
# requires-python = ">=3.11"
# dependencies = ["databricks-sql-connector", "databricks-sdk"]
# ///
"""Run SQL from Python with the Databricks SQL Connector: one connection is one session.

    uv run connector.py <cli-profile> <warehouse-id>
"""
import sys

from databricks import sql
from databricks.sdk import WorkspaceClient

profile, warehouse_id = sys.argv[1], sys.argv[2]
w = WorkspaceClient(profile=profile)  # reads host and login from the CLI profile

with sql.connect(
    server_hostname=w.config.host.removeprefix("https://"),
    http_path=f"/sql/1.0/warehouses/{warehouse_id}",
    credentials_provider=lambda: w.config.authenticate,
    catalog="sql_playground",
) as connection:
    with connection.cursor() as cursor:
        cursor.execute("USE SCHEMA velo")
        cursor.execute("SELECT bike_type, count(*) AS bikes FROM bikes GROUP BY bike_type ORDER BY bike_type")
        print([column[0] for column in cursor.description])
        for row in cursor.fetchall():
            print(row)

        try:
            cursor.execute("USE SCHEMA velo; SELECT count(*) AS bikes FROM bikes")
        except Exception as error:
            print(type(error).__name__, str(error).strip().splitlines()[0])
