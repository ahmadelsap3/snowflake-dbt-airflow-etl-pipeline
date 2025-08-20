"""
Advanced dbt + Snowflake ETL Pipeline DAG
This DAG demonstrates an advanced ETL pipeline using dbt with Snowflake.
"""

from datetime import datetime, timedelta
from airflow import DAG
from airflow.operators.bash import BashOperator
from airflow.operators.empty import EmptyOperator

# Default arguments
default_args = {
    'owner': 'data-engineering-team',
    'depends_on_past': False,
    'start_date': datetime(2025, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Create DAG
dag = DAG(
    'advanced_dbt_snowflake_pipeline',
    default_args=default_args,
    description='Advanced dbt + Snowflake ETL Pipeline',
    schedule='@daily',
    start_date=datetime(2025, 1, 1),
    catchup=False,
    max_active_runs=1,
    tags=['dbt', 'snowflake', 'etl', 'data-engineering'],
)

# Define tasks
start = EmptyOperator(
    task_id='start_pipeline',
    dag=dag,
)

# dbt debug to test connection
dbt_debug = BashOperator(
    task_id='dbt_debug',
    bash_command='cd /opt/airflow/project && dbt debug --profiles-dir /opt/airflow/project/.dbt',
    dag=dag,
)

# dbt seed to load CSV data
dbt_seed = BashOperator(
    task_id='dbt_seed',
    bash_command='cd /opt/airflow/project && dbt seed --profiles-dir /opt/airflow/project/.dbt',
    dag=dag,
)

# dbt run staging models
dbt_run_staging = BashOperator(
    task_id='dbt_run_staging',
    bash_command='cd /opt/airflow/project && dbt run --profiles-dir /opt/airflow/project/.dbt --select example.Staging',
    dag=dag,
)

# dbt run marts models
dbt_run_marts = BashOperator(
    task_id='dbt_run_marts',
    bash_command='cd /opt/airflow/project && dbt run --profiles-dir /opt/airflow/project/.dbt --select example.marts',
    dag=dag,
)

# dbt generate and serve docs (optional - commented out for production)
# dbt_docs_generate = BashOperator(
#     task_id='dbt_docs_generate',
#     bash_command='cd /workspaces/dbt-snowflake-airflow-etl-pipeline && dbt docs generate --profiles-dir .',
#     dag=dag,
# )

end = EmptyOperator(
    task_id='end_pipeline',
    dag=dag,
)

# Define task dependencies
start >> dbt_debug >> dbt_seed >> dbt_run_staging >> dbt_run_marts >> end
