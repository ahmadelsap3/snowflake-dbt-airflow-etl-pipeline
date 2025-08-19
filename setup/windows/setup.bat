@echo off
REM Setup script for Windows environments

echo 🚀 Setting up dbt + Snowflake + Airflow ETL Pipeline (Windows)

REM Create Python virtual environment
echo 🔧 Creating Python virtual environment...
python -m venv ..\..\\.venv
  
echo 🔧 Activating virtual environment...
call ..\..\\.venv\Scripts\activate.bat

REM Install dependencies
echo 🔧 Installing dependencies...
pip install -r ..\..\requirements.txt

REM Setup directories
echo 🔧 Setting up directories...
if not exist ..\..\airflow_home mkdir ..\..\airflow_home

REM Setup Airflow environment
set AIRFLOW_HOME=%CD%\..\..\airflow_home
echo AIRFLOW_HOME=%AIRFLOW_HOME% > ..\..\\.env
echo AIRFLOW__CORE__DAGS_FOLDER=%CD%\..\..\dags >> ..\..\\.env
echo AIRFLOW__CORE__LOAD_EXAMPLES=false >> ..\..\\.env

REM Initialize Airflow
echo 🔧 Initializing Airflow...
airflow db init

REM Create Airflow admin user
echo 🔧 Creating Airflow admin user...
airflow users create ^
    --username admin ^
    --firstname Admin ^
    --lastname User ^
    --role Admin ^
    --email admin@example.com ^
    --password admin

REM Copy environment files if they don't exist
if not exist ..\..\snowflake_env.ps1 (
    copy ..\..\snowflake_env.ps1.example ..\..\snowflake_env.ps1
    echo 📝 Created snowflake_env.ps1 from template
)

REM Setup dbt profile
if not exist %USERPROFILE%\.dbt mkdir %USERPROFILE%\.dbt
if not exist %USERPROFILE%\.dbt\profiles.yml (
    copy ..\..\profiles_template.yml %USERPROFILE%\.dbt\profiles.yml
    echo 📝 Created profiles.yml from template
)

echo ✅ Windows setup completed!
echo.
echo Next steps:
echo 1. Update your Snowflake credentials: Edit ..\..\snowflake_env.ps1
echo 2. Update your dbt profile: Edit %USERPROFILE%\.dbt\profiles.yml
echo 3. Test dbt connection: dbt debug --profiles-dir ..\..\
echo 4. Start Airflow: ..\..\start_airflow.bat
