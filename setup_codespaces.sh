#!/bin/bash

echo "🚀 Setting up dbt + Snowflake + Airflow ETL Pipeline"

pip install -r requirements.txt

mkdir -p airflow_home logs target

export AIRFLOW_HOME=/workspace/airflow_home
export AIRFLOW__CORE__DAGS_FOLDER=/workspace/dags
export AIRFLOW__CORE__LOAD_EXAMPLES=false

airflow db init

airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

echo "✅ Setup completed!"
echo "1. Copy Snowflake credentials to profiles.yml"
echo "2. dbt debug --profiles-dir ."
echo "3. dbt seed --profiles-dir ."
echo "4. dbt run --profiles-dir ."
echo "5. dbt docs serve --profiles-dir . --port 8081"
echo "6. airflow webserver --port 8080"
echo "7. airflow scheduler"
