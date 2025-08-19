# Windows Setup Instructions

This directory contains setup scripts specifically for Windows environments.

## Prerequisites

- Python 3.11 or later
- Snowflake account with ACCOUNTADMIN access
- Git
- PowerShell or Command Prompt

## Setup Steps

1. Open PowerShell or Command Prompt and navigate to this directory:

```powershell
cd path\to\dbt-snowflake-airflow-etl-pipeline\setup\windows
```

2. Run the setup script:

```powershell
.\setup.bat
```

This script will:

- Create and activate a Python virtual environment
- Install all required dependencies
- Set up Airflow environment
- Initialize the Airflow database
- Create an Airflow admin user
- Create required configuration files from templates

## After Setup

1. Update your Snowflake credentials:

```powershell
notepad ..\..\snowflake_env.ps1
```

2. Source the environment variables:

```powershell
. ..\..\snowflake_env.ps1
```

3. Test the dbt connection:

```powershell
cd ..\..
dbt debug --profiles-dir .
```

4. Start Airflow:

```powershell
.\start_airflow.bat
```

5. Access the Airflow UI at [http://localhost:8080](http://localhost:8080)
   - Username: admin
   - Password: admin

## Troubleshooting

1. Check that Python 3.11+ is installed:

```powershell
python --version
```

2. Ensure you have proper permissions to create directories and files

3. If Airflow fails to start, check the logs:

```powershell
Get-Content -Tail 20 -Wait airflow_home\logs\scheduler\latest
```

4. For dbt connection issues, verify your Snowflake credentials

5. If you encounter permission issues, try running PowerShell as Administrator
