# Snowflake Connection Setup Instructions

## Step 1: Update Your Snowflake Credentials

Please edit the file `snowflake_env.sh` and replace the placeholder values with your actual Snowflake credentials:

```bash
# Edit this file with your actual credentials
nano snowflake_env.sh
```

**Required Information:**

1. **SNOWFLAKE_ACCOUNT**: Your Snowflake account identifier
   - Find this in your Snowflake URL
   - Example: If your URL is `https://xy12345.us-east-1.snowflakecomputing.com`, then your account is `xy12345.us-east-1`

2. **SNOWFLAKE_USER**: Your Snowflake username
   - Usually your email address or username

3. **SNOWFLAKE_PASSWORD**: Your Snowflake password

4. **SNOWFLAKE_WAREHOUSE**: Your warehouse name
   - Default is usually `COMPUTE_WH`
   - You can see available warehouses in Snowflake web UI under Admin > Warehouses

5. **SNOWFLAKE_DATABASE**: Database name to use
   - We'll create `DBT_DB` if it doesn't exist
   - Or use any existing database name

6. **SNOWFLAKE_ROLE**: Your role
   - Usually `ACCOUNTADMIN` or `SYSADMIN`

## Step 2: Test the Connection

After updating the credentials, run:

```bash
# Load Snowflake credentials
source snowflake_env.sh

# Test dbt connection
export PATH="/workspaces/dbt-snowflake-airflow-etl-pipeline/.venv/bin:$PATH"
dbt debug --profiles-dir .
```

## Step 3: If You Need to Create Database/Schema

If the database doesn't exist, you can create it by logging into Snowflake and running:

```sql
-- Create database
CREATE DATABASE IF NOT EXISTS DBT_DB;

-- Create schema
CREATE SCHEMA IF NOT EXISTS DBT_DB.RAW;

-- Grant permissions (adjust role as needed)
GRANT ALL PRIVILEGES ON DATABASE DBT_DB TO ROLE ACCOUNTADMIN;
GRANT ALL PRIVILEGES ON SCHEMA DBT_DB.RAW TO ROLE ACCOUNTADMIN;
```

---

**Next Steps After Credentials Setup:**

1. Test connection with `dbt debug`
2. Load seed data with `dbt seed` 
3. Run staging models with `dbt run --models staging`
4. Run marts models with `dbt run --models marts`
5. Run tests with `dbt test`

Let me know when you've updated the credentials and I'll help you proceed with the next steps!
