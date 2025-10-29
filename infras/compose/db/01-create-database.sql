-- Tạo database mới nếu nó chưa tồn tại
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'TroTotVN')
BEGIN
    CREATE DATABASE TroTotVN;
    PRINT 'Database TroTotVN created successfully.';
END
ELSE
BEGIN
    PRINT 'Database TroTotVN already exists.';
END
GO