#!/bin/bash

# Setup script for GitHub Codespaces environments

echo "🚀 Setting up dbt + Snowflake + Airflow ETL Pipeline (Codespaces)"

# Install dependencies
echo "🔧 Installing dependencies..."
pip install -r ../../requirements.txt

# Setup directories
echo "🔧 Setting up directories..."
mkdir -p ../../airflow_home

# Setup Airflow environment
export AIRFLOW_HOME="$(cd ../.. && pwd)/airflow_home"
echo "AIRFLOW_HOME=$AIRFLOW_HOME" > ../../.env
echo "AIRFLOW__CORE__DAGS_FOLDER=$(cd ../.. && pwd)/dags" >> ../../.env
echo "AIRFLOW__CORE__LOAD_EXAMPLES=false" >> ../../.env

# Initialize Airflow
echo "🔧 Initializing Airflow..."
airflow db init

# Create Airflow admin user
echo "🔧 Creating Airflow admin user..."
airflow users create \
    --username admin \
    --firstname Admin \
    --lastname User \
    --role Admin \
    --email admin@example.com \
    --password admin

# Copy environment files if they don't exist
if [ ! -f "../../snowflake_env.sh" ]; then
    cp ../../snowflake_env.sh.example ../../snowflake_env.sh
    echo "📝 Created snowflake_env.sh from template"
fi

# Setup dbt profile
mkdir -p ~/.dbt
if [ ! -f "~/.dbt/profiles.yml" ]; then
    cp ../../profiles_template.yml ~/.dbt/profiles.yml
    echo "📝 Created ~/.dbt/profiles.yml from template"
fi

# Setup Codespaces-specific port forwarding
echo "🔧 Configuring port forwarding for Codespaces..."
echo "# Airflow port forwarding
AIRFLOW_PORT=8080
if [ -n \"$CODESPACE_NAME\" ]; then
  CODESPACE_URL=\"https://${CODESPACE_NAME}-${AIRFLOW_PORT}.${GITHUB_CODESPACES_PORT_FORWARDING_DOMAIN}\"
  echo \"✅ Airflow UI will be available at: $CODESPACE_URL\"
fi" >> ../../.env

echo "✅ Codespaces setup completed!"
echo ""
echo "Next steps:"
echo "1. Update your Snowflake credentials: Edit ../../snowflake_env.sh"
echo "2. Update your dbt profile: Edit ~/.dbt/profiles.yml"
echo "3. Test dbt connection: dbt debug --profiles-dir ../../"
echo "4. Start Airflow: ../../start_airflow.sh"
