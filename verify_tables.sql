-- Verification Script
-- This script verifies that all tables were created correctly

-- Show all tables
SHOW TABLES;

-- Describe each table structure
DESCRIBE Magazines;
DESCRIBE Customers;
DESCRIBE Subscriptions;
DESCRIBE Payments;

-- Show indexes for each table
SHOW INDEX FROM Magazines;
SHOW INDEX FROM Customers;
SHOW INDEX FROM Subscriptions;
SHOW INDEX FROM Payments;

-- Count records in each table (useful after loading sample data)
SELECT 'Magazines' AS table_name, COUNT(*) AS record_count FROM Magazines
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customers
UNION ALL
SELECT 'Subscriptions', COUNT(*) FROM Subscriptions
UNION ALL
SELECT 'Payments', COUNT(*) FROM Payments;
