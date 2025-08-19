# PowerShell script for setting Snowflake environment variables

# Snowflake Connection Environment Variables
# Edit these values with your actual Snowflake credentials

$env:SNOWFLAKE_ACCOUNT = "YOUR_ACCOUNT_IDENTIFIER"     # e.g., xy12345.us-east-1
$env:SNOWFLAKE_USER = "YOUR_SNOWFLAKE_USERNAME"        # e.g., john.doe@company.com
$env:SNOWFLAKE_PASSWORD = "YOUR_SNOWFLAKE_PASSWORD"    # Your Snowflake password
$env:SNOWFLAKE_WAREHOUSE = "YOUR_WAREHOUSE_NAME"       # Your warehouse name
$env:SNOWFLAKE_DATABASE = "YOUR_DATABASE_NAME"         # Database to use
$env:SNOWFLAKE_ROLE = "YOUR_ROLE"                      # Your role (e.g., ACCOUNTADMIN)

Write-Host "🔐 Snowflake environment variables set"
Write-Host "Account: $env:SNOWFLAKE_ACCOUNT"
Write-Host "User: $env:SNOWFLAKE_USER"
Write-Host "Warehouse: $env:SNOWFLAKE_WAREHOUSE"
Write-Host "Database: $env:SNOWFLAKE_DATABASE"
Write-Host "Role: $env:SNOWFLAKE_ROLE"
Write-Host ""
Write-Host "⚠️  Please update this file with your actual Snowflake credentials before running dbt commands"
