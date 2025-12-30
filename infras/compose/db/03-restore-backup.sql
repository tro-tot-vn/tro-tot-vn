-- Restore database from backup file
-- This script assumes the backup file TroTotVN_full.bak is mounted at /backup/

-- Drop database if exists to allow restore
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'TroTotVN')
BEGIN
    -- Set database to single user mode to drop connections
    ALTER DATABASE TroTotVN SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TroTotVN;
    PRINT 'Existing database TroTotVN dropped.';
END
GO

-- Restore database from backup
RESTORE DATABASE TroTotVN
FROM DISK = '/var/opt/mssql/backup/TroTotVN_full.bak'
WITH 
    MOVE 'TroTotVN' TO '/var/opt/mssql/data/TroTotVN.mdf',
    MOVE 'TroTotVN_log' TO '/var/opt/mssql/data/TroTotVN_log.ldf',
    REPLACE,
    STATS = 10;
GO

PRINT 'Database TroTotVN restored successfully from backup.';
GO
