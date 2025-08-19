# Linux/Mac Setup Instructions

This directory contains setup scripts specifically for Linux and macOS environments.

## Prerequisites

- Python 3.11 or later
- Snowflake account with ACCOUNTADMIN access
- Git

## Setup Steps

1. Open a terminal and navigate to this directory:

```bash
cd path/to/dbt-snowflake-airflow-etl-pipeline/setup/linux
```

2. Make the setup script executable:

```bash
chmod +x setup.sh
```

3. Run the setup script:

```bash
./setup.sh
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

```bash
nano ../../snowflake_env.sh
```

2. Source the environment variables:

```bash
source ../../snowflake_env.sh
```

3. Test the dbt connection:

```bash
cd ../..
dbt debug --profiles-dir .
```

4. Start Airflow:

```bash
./start_airflow.sh
```

5. Access the Airflow UI at http://localhost:8080
   - Username: admin
   - Password: admin

## Troubleshooting

If you encounter any issues during setup:

1. Check that Python 3.11+ is installed:
```bash
python --version
```

2. Ensure you have proper permissions to create directories and files

3. If Airflow fails to start, check the logs:
```bash
tail -f airflow_home/logs/scheduler/latest
```

4. For dbt connection issues, verify your Snowflake credentials
