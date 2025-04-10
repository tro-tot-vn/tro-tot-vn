#!/bin/bash

# Log time stamp for tracking
echo "Starting database configuration: $(date)"

# Create database
echo "Executing script 1: Create database"
/opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d master -i /scripts/01-create-database.sql -C

# Wait a moment for database to be available
sleep 3

echo "Database setup complete at: $(date)"