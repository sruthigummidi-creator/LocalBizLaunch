-- Run this in MySQL Workbench against your existing localbiz_launch database.
-- Adds optional phone and role columns only if they do not already exist.
USE localbiz_launch;

DROP PROCEDURE IF EXISTS migrate_localbiz_user_columns;
DELIMITER //
CREATE PROCEDURE migrate_localbiz_user_columns()
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = DATABASE() AND table_name = 'users' AND column_name = 'role'
    ) THEN
        ALTER TABLE users ADD COLUMN role VARCHAR(20) NOT NULL DEFAULT 'CUSTOMER';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns
        WHERE table_schema = DATABASE() AND table_name = 'users' AND column_name = 'phone'
    ) THEN
        ALTER TABLE users ADD COLUMN phone VARCHAR(20) NULL;
    END IF;
END//
DELIMITER ;

CALL migrate_localbiz_user_columns();
DROP PROCEDURE migrate_localbiz_user_columns;

-- Existing accounts default to CUSTOMER. Promote accounts after choosing which emails
-- should be the owner/admin account. Example:
-- UPDATE users SET role='OWNER' WHERE email='owner@example.com';
-- UPDATE users SET role='ADMIN' WHERE email='admin@example.com';
