# GitHub Codespaces Setup Instructions

This directory contains setup scripts specifically for GitHub Codespaces environments.

## Prerequisites

- GitHub account with Codespaces access
- Snowflake account with ACCOUNTADMIN access

## Setup Steps

1. Create a new Codespace from your repository

2. Open a terminal in Codespaces and navigate to this directory:

```bash
cd path/to/dbt-snowflake-airflow-etl-pipeline/setup/codespaces
```

3. Make the setup script executable:

```bash
chmod +x setup.sh
```

4. Run the setup script:

```bash
./setup.sh
```

This script will:

- Install all required dependencies
- Set up Airflow environment
- Initialize the Airflow database
- Create an Airflow admin user
- Create required configuration files from templates
- Configure port forwarding for Codespaces

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

5. Access the Airflow UI using the forwarded port URL provided in the terminal output
   - Username: admin
   - Password: admin

## Codespaces-Specific Features

- Automatic port forwarding for Airflow UI (port 8080)
- Environment pre-configured for cloud development
- Seamless GitHub integration for version control

## Troubleshooting

1. Check that Python is properly installed:

```bash
python --version
```

2. If Airflow fails to start, check the logs:

```bash
tail -f airflow_home/logs/scheduler/latest
```

3. For dbt connection issues, verify your Snowflake credentials

4. If port forwarding isn't working, check the Ports tab in the Codespaces UI
