#!/bin/bash

# Log time stamp for tracking
echo "Starting database configuration: $(date)"

# Create database
echo "Executing script 1: Create database"
/opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d master -i /scripts/01-create-database.sql -C

# Wait a moment for database to be available
sleep 3

# Create tables
echo "Executing script 2: Create tables"
# /opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d TroTotVN -i /scripts/02-create-tables.sql -C

# Create stored procedures
echo "Executing script 3: Create stored procedures"
/opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d TroTotVN -i /scripts/03-create-stored-procedures.sql -C

# Seed data
echo "Executing script 4: Seed data"
/opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d TroTotVN -i /scripts/04-seed-data.sql -C

echo "Database setup complete at: $(date)"