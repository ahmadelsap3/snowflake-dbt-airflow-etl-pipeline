#!/usr/bin/env python3
"""
Simple dbt Pipeline Runner for Windows
Simulates Airflow functionality without the Windows compatibility issues
"""

import subprocess
import sys
import os
import time
from datetime import datetime

def run_command(command, description):
    """Run a command and handle the output"""
    print(f"\n🔄 {description}")
    print(f"Command: {command}")
    print("-" * 50)
    
    try:
        # Change to the project directory
        project_dir = os.path.dirname(os.path.abspath(__file__))
        
        result = subprocess.run(
            command, 
            shell=True, 
            capture_output=True, 
            text=True,
            cwd=project_dir
        )
        
        if result.returncode == 0:
            print(f"✅ {description} - SUCCESS")
            if result.stdout:
                print(f"Output: {result.stdout}")
        else:
            print(f"❌ {description} - FAILED")
            if result.stderr:
                print(f"Error: {result.stderr}")
            return False
            
    except Exception as e:
        print(f"❌ {description} - EXCEPTION: {str(e)}")
        return False
    
    return True

def main():
    """Main pipeline execution"""
    print("🚀 Starting dbt + Snowflake ETL Pipeline")
    print(f"⏰ Started at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    print("=" * 60)
    
    # Activate virtual environment in commands
    venv_prefix = r".\.venv\Scripts\Activate.ps1; "
    
    # Pipeline steps
    steps = [
        {
            "command": f"{venv_prefix}dbt debug --profiles-dir .",
            "description": "Testing Snowflake Connection"
        },
        {
            "command": f"{venv_prefix}dbt seed --profiles-dir .",
            "description": "Loading Raw Data (Seeds)"
        },
        {
            "command": f"{venv_prefix}dbt run --profiles-dir .",
            "description": "Running dbt Models (Staging + Marts)"
        },
        {
            "command": f"{venv_prefix}dbt test --profiles-dir .",
            "description": "Running Data Quality Tests"
        },
        {
            "command": f"{venv_prefix}dbt docs generate --profiles-dir .",
            "description": "Generating Documentation"
        }
    ]
    
    # Execute each step
    failed_steps = []
    for i, step in enumerate(steps, 1):
        print(f"\n📋 Step {i}/{len(steps)}: {step['description']}")
        
        if not run_command(step['command'], step['description']):
            failed_steps.append(step['description'])
            print(f"⚠️  Step {i} failed, but continuing...")
    
    # Summary
    print("\n" + "=" * 60)
    print("📊 PIPELINE SUMMARY")
    print("=" * 60)
    
    if failed_steps:
        print(f"❌ Failed Steps ({len(failed_steps)}):")
        for step in failed_steps:
            print(f"   • {step}")
    else:
        print("✅ All steps completed successfully!")
    
    print(f"\n⏰ Completed at: {datetime.now().strftime('%Y-%m-%d %H:%M:%S')}")
    
    # Offer to start documentation server
    print("\n🌐 Would you like to start the documentation server?")
    print("This will open dbt docs at http://localhost:8081")
    
    # Start docs server automatically
    print("🔄 Starting dbt documentation server...")
    docs_command = f"{venv_prefix}dbt docs serve --profiles-dir . --port 8081"
    
    try:
        # Start docs server in background
        subprocess.Popen(
            docs_command,
            shell=True,
            cwd=os.path.dirname(os.path.abspath(__file__))
        )
        print("✅ Documentation server starting at http://localhost:8081")
        print("Press Ctrl+C to stop this script (docs server will continue running)")
        
        # Keep script alive
        while True:
            time.sleep(10)
            
    except KeyboardInterrupt:
        print("\n👋 Pipeline runner stopped. Documentation server may still be running.")
    except Exception as e:
        print(f"⚠️  Could not start docs server: {e}")

if __name__ == "__main__":
    main()
