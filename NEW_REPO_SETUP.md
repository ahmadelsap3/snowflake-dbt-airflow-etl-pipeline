# Instructions for Setting Up the New Repository

Follow these steps to set up your project in a new clean repository without any sensitive credentials:

## 1. Create a New Repository

1. Go to GitHub and create a new empty repository

## 2. Push to the New Repository

```bash
# Navigate to your project directory
cd path/to/dbt-snowflake-airflow-etl-pipeline

# Initialize a new git repository
git init

# Add all files to the staging area
git add .

# Make the initial commit
git commit -m "Initial commit: Clean project setup without credentials"

# Add the remote origin of your new repository
git remote add origin https://github.com/your-username/your-new-repo-name.git

# Push to the new repository
git push -u origin main
```

## 3. Environment Setup

We provide platform-specific setup scripts in the `setup` directory:

### For Linux/Mac

```bash
# Navigate to the Linux setup directory
cd setup/linux

# Make the setup script executable
chmod +x setup.sh

# Run the setup script
./setup.sh

# Configure Snowflake credentials
nano ../../snowflake_env.sh
```

### For Windows

```powershell
# Navigate to the Windows setup directory
cd setup\windows

# Run the setup script
.\setup.bat

# Configure Snowflake credentials
notepad ..\..\snowflake_env.ps1
```

### For GitHub Codespaces

```bash
# Navigate to the Codespaces setup directory
cd setup/codespaces

# Make the setup script executable
chmod +x setup.sh

# Run the setup script
./setup.sh

# Configure Snowflake credentials
nano ../../snowflake_env.sh
```

## 4. dbt Profile Setup

1. Update the dbt profile with your Snowflake credentials:
   - Edit `~/.dbt/profiles.yml` on Linux/Mac
   - Edit `%USERPROFILE%\.dbt\profiles.yml` on Windows

## 5. Test the Setup

### Testing on Linux/Mac

```bash
# Source Snowflake environment variables
source snowflake_env.sh

# Test dbt connection
dbt debug --profiles-dir .
```

### Testing on Windows

```powershell
# Source Snowflake environment variables
. .\snowflake_env.ps1

# Test dbt connection
dbt debug --profiles-dir .
```

## 6. Start Airflow

### Starting on Linux/Mac

```bash
./start_airflow.sh
```

### Starting on Windows

```powershell
.\start_airflow.bat
```

Access the Airflow UI at `http://localhost:8080` with:

- Username: admin
- Password: admin
