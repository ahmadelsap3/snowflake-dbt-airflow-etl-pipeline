#!/bin/bash
echo "Waiting for init container to complete..."
sleep 10
echo "Starting Airflow scheduler..."
airflow scheduler
