#!/bin/bash

# Simplified Airflow startup script

echo "🚀 Starting Airflow services..."

# Load environment variables
if [[ -f .env ]]; then
  source .env
else
  export AIRFLOW_HOME="$(pwd)/airflow_home"
  export AIRFLOW__CORE__DAGS_FOLDER="$(pwd)/dags"
fi

# Make sure airflow home exists
mkdir -p $AIRFLOW_HOME

# Kill any existing processes
pkill -f "airflow webserver" 2>/dev/null || true
pkill -f "airflow scheduler" 2>/dev/null || true
pkill -f "gunicorn" 2>/dev/null || true

sleep 2

echo "📊 Starting Airflow webserver on http://localhost:8080"
airflow webserver --port 8080 &

echo "⏰ Starting Airflow scheduler"  
airflow scheduler &

echo "✅ Airflow services started successfully!"
echo ""
echo "🌐 Access Airflow UI at: http://localhost:8080"
echo "👤 Username: admin"
echo "🔑 Password: admin"
echo ""
echo "📈 Your dbt-Snowflake-Airflow ETL pipeline is ready!"
echo "DAG: advanced_dbt_snowflake_pipeline"
echo ""
echo "To stop Airflow, press Ctrl+C or run: pkill -f airflow"
