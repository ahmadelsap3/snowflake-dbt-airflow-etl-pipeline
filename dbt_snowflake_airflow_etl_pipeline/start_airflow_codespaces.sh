#!/bin/bash

# Airflow Startup Script for GitHub Codespaces
echo "🚀 Starting Airflow in GitHub Codespaces..."

# Create airflow directories
mkdir -p /workspace/airflow_home
mkdir -p /workspace/airflow_home/logs
mkdir -p /workspace/airflow_home/plugins

# Set environment variables
export AIRFLOW_HOME="/workspace/airflow_home"
export AIRFLOW__CORE__DAGS_FOLDER="/workspace/dags"
export AIRFLOW__CORE__LOAD_EXAMPLES="false"
export AIRFLOW__CORE__EXECUTOR="LocalExecutor"
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="sqlite:////workspace/airflow_home/airflow.db"
export AIRFLOW__WEBSERVER__WEB_SERVER_PORT="8080"
export AIRFLOW__WEBSERVER__WORKERS="1"
export AIRFLOW__WEBSERVER__WORKER_TIMEOUT="300"

# Initialize Airflow database
echo "📊 Initializing Airflow database..."
airflow db init

# Create admin user
echo "👤 Creating admin user..."
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

echo "✅ Airflow setup complete!"
echo ""
echo "🌐 To start Airflow:"
echo "   airflow webserver --port 8080 --daemon"
echo "   airflow scheduler --daemon"
echo ""
echo "🔗 Access Airflow at: https://$CODESPACE_NAME-8080.app.github.dev"
echo "   Username: admin"
echo "   Password: admin"
