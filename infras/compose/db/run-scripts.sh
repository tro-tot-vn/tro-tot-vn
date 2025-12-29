#!/bin/bash

# Log time stamp for tracking
echo "Starting database configuration: $(date)"

# Create database
echo "Executing script 1: Create database"
/opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d master -i /scripts/01-create-database.sql -C

# Wait a moment for database to be available
sleep 3

# Enable CDC
echo "Executing script 2: Enable CDC"
/opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d TroTotVN -i /scripts/02-enable-cdc.sql -C

# Restore from backup if backup file exists
if [ -f "/backup/TroTotVN_full.bak" ]; then
    echo "Executing script 3: Restore from backup"
    /opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d master -i /scripts/03-restore-backup.sql -C
    
    # Wait for restore to complete
    sleep 5
    
    # Re-enable CDC after restore
    echo "Re-enabling CDC after restore"
    /opt/mssql-tools/bin/sqlcmd -S db-trototvn -U sa -P "$1" -d TroTotVN -i /scripts/02-enable-cdc.sql -C
else
    echo "Backup file not found, skipping restore."
fi

echo "Database setup complete at: $(date)"