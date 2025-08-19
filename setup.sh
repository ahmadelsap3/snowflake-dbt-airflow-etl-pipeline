#!/bin/bash

# Main setup script that redirects to platform-specific setup

echo "🚀 dbt + Snowflake + Airflow ETL Pipeline Setup"
echo ""
echo "Please use the platform-specific setup scripts:"
echo ""
echo "1. Linux/Mac:"
echo "   cd setup/linux && chmod +x setup.sh && ./setup.sh"
echo ""
echo "2. Windows:"
echo "   cd setup/windows && setup.bat"
echo ""
echo "3. GitHub Codespaces:"
echo "   cd setup/codespaces && chmod +x setup.sh && ./setup.sh"
echo ""
echo "For more information, see the README.md in each platform directory."

# Detect platform and suggest the appropriate script
if [[ "$OSTYPE" == "linux-gnu"* || "$OSTYPE" == "darwin"* ]]; then
  echo ""
  echo "It looks like you're on Linux/Mac. Would you like to run the Linux/Mac setup script? (y/n)"
  read -r response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    cd setup/linux && chmod +x setup.sh && ./setup.sh
  fi
elif [[ "$OSTYPE" == "msys" || "$OSTYPE" == "win32" ]]; then
  echo ""
  echo "It looks like you're on Windows. Please run the Windows setup script:"
  echo "cd setup/windows && setup.bat"
fi

# Check if in GitHub Codespaces
if [ -n "$CODESPACE_NAME" ]; then
  echo ""
  echo "It looks like you're in GitHub Codespaces. Would you like to run the Codespaces setup script? (y/n)"
  read -r response
  if [[ "$response" =~ ^([yY][eE][sS]|[yY])$ ]]; then
    cd setup/codespaces && chmod +x setup.sh && ./setup.sh
  fi
fi
echo "3. Load seed data: dbt seed --profiles-dir ."
echo "4. Run transformations: dbt run --profiles-dir ."
echo "5. Start Airflow: ./start_airflow.sh"
echo ""
echo "Access Airflow UI at: http://localhost:8080"
echo "Username: admin"
echo "Password: admin"
