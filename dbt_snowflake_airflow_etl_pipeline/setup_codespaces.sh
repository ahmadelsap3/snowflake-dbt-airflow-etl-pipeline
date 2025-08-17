#!/bin/bash
# Setup script for GitHub Codespaces

echo "🚀 Setting up dbt + Snowflake + Airflow ETL Pipeline in GitHub Codespaces"
echo "=============================================================="

# Install Python dependencies
echo "📦 Installing Python dependencies..."
pip install -r requirements.txt

# Create necessary directories
echo "📁 Creating necessary directories..."
mkdir -p airflow_home
mkdir -p logs
mkdir -p target

# Set environment variables
echo "🔧 Setting up environment variables..."
export AIRFLOW_HOME=/workspace/airflow_home
export AIRFLOW__CORE__DAGS_FOLDER=/workspace/dags
export AIRFLOW__CORE__LOAD_EXAMPLES=false

# Initialize Airflow database
echo "🗄️ Initializing Airflow database..."
airflow db init

# Create Airflow admin user
echo "👤 Creating Airflow admin user..."
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

echo "✅ Setup completed!"
echo ""
echo "🔗 Next steps:"
echo "1. Copy your Snowflake credentials to profiles.yml"
echo "2. Run: dbt debug --profiles-dir ."
echo "3. Run: dbt seed --profiles-dir ."
echo "4. Run: dbt run --profiles-dir ."
echo "5. Run: dbt docs serve --profiles-dir . --port 8081"
echo "6. Run: airflow webserver --port 8080 (in separate terminal)"
echo "7. Run: airflow scheduler (in another terminal)"
echo ""
echo "🌐 Web UIs:"
echo "• Airflow: http://localhost:8080 (admin/admin)"
echo "• dbt Docs: http://localhost:8081"
