-- Sample Queries for Magazine Subscription Database
-- This file contains useful queries for working with the database

-- Query 1: Get all active subscriptions with customer and magazine details
SELECT 
    s.SubscriptionID,
    c.FirstName,
    c.LastName,
    c.Email,
    m.MagazineName,
    m.Publisher,
    s.StartDate,
    s.EndDate,
    s.Status,
    s.SubscriptionPrice
FROM Subscription s
JOIN Customer c ON s.CustomerID = c.CustomerID
JOIN Magazine m ON s.MagazineID = m.MagazineID
WHERE s.Status = 'Active'
ORDER BY s.EndDate;

-- Query 2: Find customers with multiple subscriptions
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    COUNT(s.SubscriptionID) as SubscriptionCount,
    SUM(s.SubscriptionPrice) as TotalSpent
FROM Customer c
JOIN Subscription s ON c.CustomerID = s.CustomerID
GROUP BY c.CustomerID, c.FirstName, c.LastName, c.Email
HAVING COUNT(s.SubscriptionID) > 1
ORDER BY SubscriptionCount DESC;

-- Query 3: List all magazines with their subscriber count
SELECT 
    m.MagazineID,
    m.MagazineName,
    m.Publisher,
    m.Category,
    COUNT(s.SubscriptionID) as SubscriberCount,
    SUM(CASE WHEN s.Status = 'Active' THEN 1 ELSE 0 END) as ActiveSubscribers
FROM Magazine m
LEFT JOIN Subscription s ON m.MagazineID = s.MagazineID
GROUP BY m.MagazineID, m.MagazineName, m.Publisher, m.Category
ORDER BY SubscriberCount DESC;

-- Query 4: Find subscriptions expiring in the next 30 days
SELECT 
    s.SubscriptionID,
    c.FirstName,
    c.LastName,
    c.Email,
    m.MagazineName,
    s.EndDate,
    DATEDIFF(s.EndDate, CURRENT_DATE) as DaysUntilExpiry
FROM Subscription s
JOIN Customer c ON s.CustomerID = c.CustomerID
JOIN Magazine m ON s.MagazineID = m.MagazineID
WHERE s.Status = 'Active'
AND s.EndDate BETWEEN CURRENT_DATE AND DATE_ADD(CURRENT_DATE, INTERVAL 30 DAY)
ORDER BY s.EndDate;

-- Query 5: Calculate total revenue by magazine category
SELECT 
    m.Category,
    COUNT(s.SubscriptionID) as TotalSubscriptions,
    SUM(s.SubscriptionPrice) as TotalRevenue,
    AVG(s.SubscriptionPrice) as AveragePrice
FROM Magazine m
JOIN Subscription s ON m.MagazineID = s.MagazineID
GROUP BY m.Category
ORDER BY TotalRevenue DESC;

-- Query 6: Find customers who have never subscribed
SELECT 
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Email,
    c.DateRegistered
FROM Customer c
LEFT JOIN Subscription s ON c.CustomerID = s.CustomerID
WHERE s.SubscriptionID IS NULL;

-- Query 7: Get subscription history for a specific customer (replace CustomerID = 1 with desired ID)
SELECT 
    m.MagazineName,
    s.StartDate,
    s.EndDate,
    s.Status,
    s.SubscriptionPrice,
    s.PaymentMethod
FROM Subscription s
JOIN Magazine m ON s.MagazineID = m.MagazineID
WHERE s.CustomerID = 1
ORDER BY s.StartDate DESC;

-- Query 8: Find the most popular magazine by category
SELECT 
    m.Category,
    m.MagazineName,
    COUNT(s.SubscriptionID) as SubscriptionCount
FROM Magazine m
JOIN Subscription s ON m.MagazineID = s.MagazineID
GROUP BY m.Category, m.MagazineName
HAVING COUNT(s.SubscriptionID) = (
    SELECT MAX(sub_count)
    FROM (
        SELECT m2.Category, COUNT(s2.SubscriptionID) as sub_count
        FROM Magazine m2
        JOIN Subscription s2 ON m2.MagazineID = s2.MagazineID
        WHERE m2.Category = m.Category
        GROUP BY m2.MagazineID
    ) as counts
)
ORDER BY m.Category;
