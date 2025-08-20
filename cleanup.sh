#!/bin/bash
# cleanup.sh - Script to clean up the repository before pushing

# Create necessary directories
mkdir -p .dbt

# Remove unnecessary files and directories
echo "Cleaning up unnecessary files and directories..."

# Remove Python cache files
find . -type d -name "__pycache__" -exec rm -rf {} +
find . -name "*.pyc" -delete

# Remove logs
rm -rf logs/
rm -rf airflow-docker/logs/

# Remove dbt artifacts
rm -rf target/
rm -rf dbt_packages/

# Remove Airflow SQLite database
rm -f airflow-docker/*.db
rm -f airflow-docker/standalone_admin_password.txt

# Remove any potential sensitive files
rm -f .dbt/profiles.yml

# Create example files
echo "Creating example credential files..."
cp -n snowflake_env.sh.example snowflake_env.sh

echo "Clean up complete!"
echo "Remember to add your sensitive credentials to:"
echo "1. snowflake_env.sh"
echo "2. .dbt/profiles.yml (based on profiles_template.yml)"
echo ""
echo "Next steps:"
echo "1. git init"
echo "2. git add ."
echo "3. git commit -m 'Initial commit'"
echo "4. git remote add origin https://github.com/yourusername/snowflake-dbt-airflow-pipeline.git"
echo "5. git push -u origin main"
