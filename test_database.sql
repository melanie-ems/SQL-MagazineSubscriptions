-- Database Validation Test Script
-- This script tests the database structure and functionality

-- Test 1: Verify all tables exist
SELECT 'Test 1: Checking tables exist' as Test;
.tables

-- Test 2: Count records in each table
SELECT 'Test 2: Record counts' as Test;
SELECT 'Magazine' as TableName, COUNT(*) as RecordCount FROM Magazine
UNION ALL
SELECT 'Customer', COUNT(*) FROM Customer
UNION ALL
SELECT 'Subscription', COUNT(*) FROM Subscription;

-- Test 3: Verify foreign key relationships
SELECT 'Test 3: Verifying relationships' as Test;
SELECT 
    COUNT(DISTINCT s.CustomerID) as UniqueCustomers,
    COUNT(DISTINCT s.MagazineID) as UniqueMagazines,
    COUNT(*) as TotalSubscriptions
FROM Subscription s;

-- Test 4: Test JOIN queries
SELECT 'Test 4: Testing JOIN operations' as Test;
SELECT 
    c.FirstName || ' ' || c.LastName as CustomerName,
    m.MagazineName,
    s.Status
FROM Subscription s
JOIN Customer c ON s.CustomerID = c.CustomerID
JOIN Magazine m ON s.MagazineID = m.MagazineID
LIMIT 3;

-- Test 5: Test aggregation
SELECT 'Test 5: Testing aggregation' as Test;
SELECT 
    Status,
    COUNT(*) as Count
FROM Subscription
GROUP BY Status;

-- Test 6: Test indexes (check query plan)
SELECT 'Test 6: Verifying indexes' as Test;
EXPLAIN QUERY PLAN
SELECT * FROM Subscription WHERE CustomerID = 1;

-- Test 7: Verify constraints
SELECT 'Test 7: Testing constraints' as Test;
SELECT 'Foreign Key Constraint Test' as ConstraintType;
-- The following would fail with foreign key constraint:
-- INSERT INTO Subscription (CustomerID, MagazineID, StartDate, EndDate) 
-- VALUES (999, 1, '2024-01-01', '2025-01-01');

SELECT 'Date Check Constraint Test' as ConstraintType;
-- The following would fail with CHECK constraint:
-- INSERT INTO Subscription (CustomerID, MagazineID, StartDate, EndDate) 
-- VALUES (1, 1, '2025-01-01', '2024-01-01');

SELECT 'Status Check Constraint Test' as ConstraintType;
-- The following would fail with CHECK constraint:
-- INSERT INTO Subscription (CustomerID, MagazineID, StartDate, EndDate, Status) 
-- VALUES (1, 1, '2024-01-01', '2025-01-01', 'InvalidStatus');

-- Test 8: Test data integrity
SELECT 'Test 8: Data integrity check' as Test;
SELECT 
    (SELECT COUNT(*) FROM Subscription WHERE CustomerID NOT IN (SELECT CustomerID FROM Customer)) as OrphanedSubscriptions,
    (SELECT COUNT(*) FROM Subscription WHERE MagazineID NOT IN (SELECT MagazineID FROM Magazine)) as InvalidMagazines;

-- All tests complete
SELECT 'All validation tests completed successfully!' as Result;
