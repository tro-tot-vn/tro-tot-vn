#!/bin/bash

# Log time stamp for tracking
echo "Starting database configuration: $(date)"

# Create database
echo "Executing script 1: Create database"
/opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d master -i /scripts/01-create-database.sql -C

# Wait a moment for database to be available
sleep 3

# Restore from backup FIRST (before enabling CDC)
# Check if backup exists in the mounted volume
if [ -f "/backup/TroTotVN_full.bak" ]; then
    echo "Executing script 2: Restore from backup"
    /opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d master -i /scripts/03-restore-backup.sql -C
    
    # Wait for restore to complete
    sleep 5
else
    echo "Backup file not found, skipping restore."
fi

# Enable CDC (after restore, so tables exist)
echo "Executing script 3: Enable CDC"
/opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d TroTotVN -i /scripts/02-enable-cdc.sql -C

echo "Database setup complete at: $(date)"