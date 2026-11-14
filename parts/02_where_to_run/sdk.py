# /// script
# requires-python = ">=3.11"
# dependencies = ["databricks-sdk"]
# ///
"""Run SQL from Python with the Databricks SDK: a wrapper around the Statement Execution API.

    uv run sdk.py <cli-profile> <warehouse-id>
"""
import sys

from databricks.sdk import WorkspaceClient

profile, warehouse_id = sys.argv[1], sys.argv[2]
w = WorkspaceClient(profile=profile)

response = w.statement_execution.execute_statement(
    warehouse_id=warehouse_id,
    catalog="sql_playground",
    schema="velo",
    statement="SELECT bike_type, count(*) AS bikes FROM bikes GROUP BY bike_type ORDER BY bike_type",
    wait_timeout="30s",
)
print(response.status.state)
print([column.name for column in response.manifest.schema.columns])
for row in response.result.data_array:
    print(row)
