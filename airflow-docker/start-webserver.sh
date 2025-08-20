#!/bin/bash
echo "Waiting for init container to complete..."
sleep 10
echo "Starting Airflow webserver..."
airflow webserver
