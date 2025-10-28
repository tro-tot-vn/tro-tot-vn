USE TroTotVN;
GO

-- Enable CDC at database level
IF NOT EXISTS (SELECT 1 FROM sys.databases WHERE name = 'TroTotVN' AND is_cdc_enabled = 1)
BEGIN
    EXEC sys.sp_cdc_enable_db;
    PRINT 'CDC enabled on database TroTotVN';
END
ELSE
BEGIN
    PRINT 'CDC already enabled on database TroTotVN';
END
GO

-- Enable CDC on Post table
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Post' AND is_tracked_by_cdc = 1)
BEGIN
    EXEC sys.sp_cdc_enable_table
        @source_schema = 'dbo',
        @source_name = 'Post',
        @role_name = NULL,
        @supports_net_changes = 1;
    PRINT 'CDC enabled on Post table';
END
ELSE
BEGIN
    PRINT 'CDC already enabled on Post table';
END
GO

-- Enable CDC on Customer table  
IF NOT EXISTS (SELECT 1 FROM sys.tables WHERE name = 'Customer' AND is_tracked_by_cdc = 1)
BEGIN
    EXEC sys.sp_cdc_enable_table
        @source_schema = 'dbo',
        @source_name = 'Customer',
        @role_name = NULL,
        @supports_net_changes = 1;
    PRINT 'CDC enabled on Customer table';
END
ELSE
BEGIN
    PRINT 'CDC already enabled on Customer table';
END
GO

-- Verify CDC setup
SELECT 'Database CDC Status' as Info, name, is_cdc_enabled 
FROM sys.databases WHERE name = 'TroTotVN';

SELECT 'Table CDC Status' as Info, name, is_tracked_by_cdc 
FROM sys.tables WHERE is_tracked_by_cdc = 1;
GO

