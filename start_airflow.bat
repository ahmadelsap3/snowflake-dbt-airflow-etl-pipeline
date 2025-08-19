@echo off
REM Simplified Airflow startup script for Windows

echo 🚀 Starting Airflow services...

REM Set environment variables
set AIRFLOW_HOME=%CD%\airflow_home
set AIRFLOW__CORE__DAGS_FOLDER=%CD%\dags

REM Make sure airflow home exists
if not exist %AIRFLOW_HOME% mkdir %AIRFLOW_HOME%

echo 📊 Starting Airflow webserver on http://localhost:8080
start /B cmd /c "airflow webserver --port 8080"

echo ⏰ Starting Airflow scheduler
start /B cmd /c "airflow scheduler"

echo ✅ Airflow services started successfully!
echo.
echo 🌐 Access Airflow UI at: http://localhost:8080
echo 👤 Username: admin
echo 🔑 Password: admin
echo.
echo 📈 Your dbt-Snowflake-Airflow ETL pipeline is ready!
echo DAG: advanced_dbt_snowflake_pipeline
echo.
echo To stop Airflow, close the terminal windows or end the processes manually.
