#!/bin/bash

# Snowflake Connection Environment Variables
# Edit these values with your actual Snowflake credentials

export SNOWFLAKE_ACCOUNT=ACHAMLP-CK87481     # e.g., xy12345.us-east-1
export SNOWFLAKE_USER=AHMEDELSAB3                  # e.g., john.doe@company.com
export SNOWFLAKE_PASSWORD="KYer.He9t.A9pGB"              # Your Snowflake password
export SNOWFLAKE_WAREHOUSE=FINANCE_WH                # Your warehouse name
export SNOWFLAKE_DATABASE=FINANCE_DB                   # Database to use
export SNOWFLAKE_ROLE=ACCOUNTADMIN                   # Your role

echo "🔐 Snowflake environment variables set"
echo "Account: $SNOWFLAKE_ACCOUNT"
echo "User: $SNOWFLAKE_USER"
echo "Warehouse: $SNOWFLAKE_WAREHOUSE"
echo "Database: $SNOWFLAKE_DATABASE"
echo "Role: $SNOWFLAKE_ROLE"
echo ""
echo "⚠️  Please update this file with your actual Snowflake credentials before running dbt commands"
