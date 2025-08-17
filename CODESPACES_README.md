# 🚀 Airflow dbt Snowflake Pipeline - GitHub Codespaces

This project is configured to run Apache Airflow with dbt and Snowflake integration in GitHub Codespaces.

## 🆓 FREE Usage

- **60 hours/month** free with GitHub Free account
- **120 hours/month** free with GitHub Pro account
- Perfect for development and learning!

## 🏁 Quick Start

### 1. Open in Codespaces
1. Go to your GitHub repository
2. Click the **Code** button
3. Select **Codespaces** tab
4. Click **Create codespace on main**

### 2. Start Airflow
```bash
# Make the script executable
chmod +x start_airflow_codespaces.sh

# Run the setup
./start_airflow_codespaces.sh

# Start Airflow services
airflow webserver --port 8080 --daemon
airflow scheduler --daemon
```

### 3. Access Airflow UI
- **URL**: `https://YOUR-CODESPACE-NAME-8080.app.github.dev`
- **Username**: `admin`
- **Password**: `admin`

### 4. Configure Snowflake Connection
1. Go to Admin → Connections in Airflow UI
2. Create new connection:
   - **Connection Id**: `snowflake_default`
   - **Connection Type**: `Snowflake`
   - **Host**: `ACHAMLP-CK87481.snowflakecomputing.com`
   - **Login**: `AHMEDELSAB3`
   - **Password**: `KYer.He9t.A9pGB`
   - **Extra**: `{"account": "ACHAMLP-CK87481", "warehouse": "FINANCE_WH", "database": "finance_db", "role": "ACCOUNTADMIN"}`

## 📁 Project Structure
```
├── .devcontainer/          # Codespaces configuration
├── dags/                   # Airflow DAGs
├── models/                 # dbt models
├── airflow_home/           # Airflow home directory
├── requirements.txt        # Python dependencies
└── start_airflow_codespaces.sh  # Startup script
```

## 🔧 Available Commands

```bash
# Check Airflow status
airflow info

# List DAGs
airflow dags list

# Test dbt connection
dbt debug

# Run dbt models
dbt run

# Stop Airflow services
pkill -f "airflow webserver"
pkill -f "airflow scheduler"
```

## 🎯 Your DAGs

Your main DAG is: `advanced_dbt_snowflake_pipeline`

It includes:
- ✅ Data quality checks
- ✅ dbt staging models
- ✅ dbt marts models
- ✅ Documentation generation

## 💡 Tips

1. **Keep Codespace Active**: The free tier gives you 60 hours/month
2. **Stop When Not Using**: Stop the codespace to conserve hours
3. **Port Forwarding**: Ports 8080 is automatically forwarded
4. **Environment Variables**: Pre-configured for Airflow

## 🔗 Useful Links

- [GitHub Codespaces Docs](https://docs.github.com/en/codespaces)
- [Apache Airflow Docs](https://airflow.apache.org/docs/)
- [dbt Docs](https://docs.getdbt.com/)

Happy coding! 🎉
