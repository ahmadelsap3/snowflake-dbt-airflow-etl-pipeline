#!/bin/bash

# Airflow startup script
cd /workspaces/dbt-snowflake-airflow-etl-pipeline

# Set environment variables
export AIRFLOW_HOME=/workspaces/dbt-snowflake-airflow-etl-pipeline/airflow_home
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN=sqlite:////workspaces/dbt-snowflake-airflow-etl-pipeline/airflow_home/airflow.db
export AIRFLOW__CORE__EXECUTOR=SequentialExecutor
export AIRFLOW__CORE__DAGS_FOLDER=/workspaces/dbt-snowflake-airflow-etl-pipeline/dags
export AIRFLOW__WEBSERVER__EXPOSE_CONFIG=True
export PATH="/workspaces/dbt-snowflake-airflow-etl-pipeline/.venv/bin:$PATH"

echo "🚀 Starting Airflow services..."

# Kill any existing processes
pkill -f "airflow webserver" 2>/dev/null || true
pkill -f "airflow scheduler" 2>/dev/null || true
pkill -f "gunicorn" 2>/dev/null || true

sleep 2

echo "📊 Starting Airflow webserver on http://localhost:8080"
airflow webserver --port 8080 --daemon

echo "⏰ Starting Airflow scheduler"  
airflow scheduler --daemon

sleep 3

echo "✅ Airflow services started successfully!"
echo ""
echo "🌐 Access Airflow UI at: http://localhost:8080"
echo "👤 Username: admin"
echo "🔑 Password: admin"
echo ""
echo "📈 Your dbt-Snowflake-Airflow ETL pipeline is ready!"
echo "� DAG: advanced_dbt_snowflake_pipeline"
