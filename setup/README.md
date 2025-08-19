# Setup Instructions

This directory contains platform-specific setup scripts for the dbt-Snowflake-Airflow ETL pipeline project.

## Choose Your Platform

Select the appropriate setup directory based on your environment:

- [**Linux/Mac**](./linux/README.md) - For Ubuntu, Debian, CentOS, macOS, and other Unix-based systems
- [**Windows**](./windows/README.md) - For Windows 10/11 with PowerShell or Command Prompt
- [**Codespaces**](./codespaces/README.md) - For GitHub Codespaces cloud development environment

## Common Setup Requirements

Regardless of platform, you'll need:

1. Python 3.11 or later
2. A Snowflake account with ACCOUNTADMIN access
3. Git

## Configuration Files

After running the setup script for your platform, you'll need to update two main configuration files:

1. Snowflake Environment Variables:
   - `snowflake_env.sh` (Linux/Mac/Codespaces)
   - `snowflake_env.ps1` (Windows)

2. dbt Profile:
   - `~/.dbt/profiles.yml` (Linux/Mac/Codespaces)
   - `%USERPROFILE%\.dbt\profiles.yml` (Windows)

## Common Workflow

Once setup is complete, the workflow is similar across all platforms:

1. Set environment variables
2. Run dbt models
3. Start Airflow
4. Trigger the DAG from the Airflow UI

## Need Help?

If you encounter any issues during setup, please:

1. Check the platform-specific README for troubleshooting tips
2. Ensure all prerequisites are installed
3. Verify your Snowflake credentials are correct
