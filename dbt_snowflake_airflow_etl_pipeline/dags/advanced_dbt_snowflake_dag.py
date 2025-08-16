from datetime import datetime, timedelta
from airflow import DAG
# from airflow.providers.snowflake.operators.snowflake import SnowflakeOperator  # Commented out until provider is installed
from airflow.operators.bash import BashOperator
from airflow.operators.python import PythonOperator
from airflow.operators.dummy import DummyOperator

# Default arguments
default_args = {
    'owner': 'data-engineer',
    'depends_on_past': False,
    'start_date': datetime(2025, 1, 1),
    'email_on_failure': False,
    'email_on_retry': False,
    'retries': 1,
    'retry_delay': timedelta(minutes=5),
}

# Define the DAG
dag = DAG(
    'advanced_dbt_snowflake_pipeline',
    default_args=default_args,
    description='Advanced dbt + Snowflake Pipeline with Data Quality Checks',
    schedule_interval=timedelta(days=1),
    catchup=False,
    tags=['dbt', 'snowflake', 'data-quality', 'etl'],
)

# dbt project path - adjust based on your environment
# For Docker: "/opt/dbt_project"
# For local: use the actual project path
DBT_PROJECT_PATH = "/opt/airflow/dags/../"  # Points to the dbt project root

# Start and End tasks
start_task = DummyOperator(
    task_id='start_pipeline',
    dag=dag,
)

end_task = DummyOperator(
    task_id='end_pipeline',
    dag=dag,
)

# Data Quality Check function
def check_data_freshness():
    """
    Check if source data is fresh enough for processing
    """
    print("Checking data freshness...")
    # Add your data freshness logic here
    # For example, check if latest data is within acceptable time window
    return True

# Pre-processing tasks
data_freshness_check = PythonOperator(
    task_id='check_data_freshness',
    python_callable=check_data_freshness,
    dag=dag,
)

# Pre-run Snowflake check (using Snowflake operator)
# Note: Configure Snowflake connection in Airflow Admin -> Connections
# Connection ID: snowflake_default
# Connection Type: Snowflake
# Temporarily commented out - uncomment when snowflake provider is installed
# snowflake_health_check = SnowflakeOperator(
#     task_id='snowflake_health_check',
#     sql="SELECT CURRENT_VERSION();",
#     snowflake_conn_id='snowflake_default',  # Configure this connection in Airflow
#     dag=dag,
# )

# Alternative: Use dbt debug for connection test
snowflake_health_check = BashOperator(
    task_id='snowflake_health_check_via_dbt',
    bash_command=f'cd "{DBT_PROJECT_PATH}" && dbt debug --profiles-dir /home/airflow/.dbt',
    dag=dag,
)

# dbt tasks
dbt_deps = BashOperator(
    task_id='dbt_install_dependencies',
    bash_command=f'cd "{DBT_PROJECT_PATH}" && dbt deps',
    dag=dag,
)

dbt_debug = BashOperator(
    task_id='dbt_connection_test',
    bash_command=f'cd "{DBT_PROJECT_PATH}" && dbt debug --no-version-check',
    dag=dag,
)

# Staging models
dbt_run_staging = BashOperator(
    task_id='dbt_run_staging_models',
    bash_command=f'cd "{DBT_PROJECT_PATH}" && dbt run --models staging',
    dag=dag,
)

dbt_test_staging = BashOperator(
    task_id='dbt_test_staging_models',
    bash_command=f'cd "{DBT_PROJECT_PATH}" && dbt test --models staging',
    dag=dag,
)

# Marts models
dbt_run_marts = BashOperator(
    task_id='dbt_run_marts_models',
    bash_command=f'cd "{DBT_PROJECT_PATH}" && dbt run --models marts',
    dag=dag,
)

dbt_test_marts = BashOperator(
    task_id='dbt_test_marts_models',
    bash_command=f'cd "{DBT_PROJECT_PATH}" && dbt test --models marts',
    dag=dag,
)

# Final data quality checks
def final_data_validation():
    """
    Perform final validation on processed data
    """
    print("Running final data validation...")
    # Add your final validation logic here
    # For example, row count checks, data consistency checks, etc.
    return True

final_validation = PythonOperator(
    task_id='final_data_validation',
    python_callable=final_data_validation,
    dag=dag,
)

# Generate documentation
dbt_docs = BashOperator(
    task_id='dbt_generate_documentation',
    bash_command=f'cd "{DBT_PROJECT_PATH}" && dbt docs generate',
    dag=dag,
)

# Define task dependencies
start_task >> [data_freshness_check, snowflake_health_check]
[data_freshness_check, snowflake_health_check] >> dbt_deps
dbt_deps >> dbt_debug >> dbt_run_staging >> dbt_test_staging
dbt_test_staging >> dbt_run_marts >> dbt_test_marts
dbt_test_marts >> final_validation >> dbt_docs >> end_task
