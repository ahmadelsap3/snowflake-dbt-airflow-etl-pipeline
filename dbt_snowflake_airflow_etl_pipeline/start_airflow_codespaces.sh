#!/bin/bash

echo "🚀 Starting Airflow in GitHub Codespaces..."

mkdir -p /workspace/airflow_home /workspace/airflow_home/logs /workspace/airflow_home/plugins

export AIRFLOW_HOME="/workspace/airflow_home"
export AIRFLOW__CORE__DAGS_FOLDER="/workspace/dags"
export AIRFLOW__CORE__LOAD_EXAMPLES="false"
export AIRFLOW__CORE__EXECUTOR="LocalExecutor"
export AIRFLOW__DATABASE__SQL_ALCHEMY_CONN="sqlite:////workspace/airflow_home/airflow.db"
export AIRFLOW__WEBSERVER__WEB_SERVER_PORT="8080"
export AIRFLOW__WEBSERVER__WORKERS="1"
export AIRFLOW__WEBSERVER__WORKER_TIMEOUT="300"

airflow db init

airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

echo "✅ Setup complete!"
echo "🌐 Access: https://$CODESPACE_NAME-8080.app.github.dev (admin/admin)"
