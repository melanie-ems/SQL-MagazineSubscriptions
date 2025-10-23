-- Sample data for Magazine Subscription Database
-- This script inserts sample data into the Magazine, Customer, and Subscription tables

-- Insert sample magazines
INSERT INTO Magazine (MagazineName, Publisher, Category, IssueFrequency, AnnualPrice, Description) VALUES
('Tech Today', 'Digital Publishing Inc.', 'Technology', 'Monthly', 59.99, 'Latest trends in technology and innovation'),
('Home & Garden', 'Lifestyle Media', 'Lifestyle', 'Monthly', 39.99, 'Beautiful homes and garden ideas'),
('Business Weekly', 'Financial Press', 'Business', 'Weekly', 149.99, 'Business news and market analysis'),
('Sports Illustrated', 'Sports Media Group', 'Sports', 'Monthly', 49.99, 'Comprehensive sports coverage'),
('Cooking Master', 'Culinary Publications', 'Food', 'Bi-Monthly', 29.99, 'Recipes and cooking techniques'),
('Travel World', 'Adventure Press', 'Travel', 'Quarterly', 24.99, 'Explore destinations around the globe');

-- Insert sample customers
INSERT INTO Customer (FirstName, LastName, Email, Phone, Address, City, State, PostalCode, Country, DateRegistered) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '123 Main St', 'New York', 'NY', '10001', 'USA', '2023-01-15'),
('Sarah', 'Johnson', 'sarah.j@email.com', '555-0102', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA', '2023-02-20'),
('Michael', 'Brown', 'mbrown@email.com', '555-0103', '789 Pine Rd', 'Chicago', 'IL', '60601', 'USA', '2023-03-10'),
('Emily', 'Davis', 'emily.davis@email.com', '555-0104', '321 Elm St', 'Houston', 'TX', '77001', 'USA', '2023-04-05'),
('David', 'Wilson', 'dwilson@email.com', '555-0105', '654 Maple Dr', 'Phoenix', 'AZ', '85001', 'USA', '2023-05-12'),
('Lisa', 'Anderson', 'lisa.a@email.com', '555-0106', '987 Cedar Ln', 'Philadelphia', 'PA', '19101', 'USA', '2023-06-18');

-- Insert sample subscriptions
INSERT INTO Subscription (CustomerID, MagazineID, StartDate, EndDate, Status, PaymentMethod, SubscriptionPrice) VALUES
(1, 1, '2023-01-15', '2024-01-15', 'Active', 'Credit Card', 59.99),
(1, 3, '2023-01-15', '2024-01-15', 'Active', 'Credit Card', 149.99),
(2, 2, '2023-02-20', '2024-02-20', 'Active', 'PayPal', 39.99),
(2, 6, '2023-02-20', '2024-02-20', 'Active', 'PayPal', 24.99),
(3, 3, '2023-03-10', '2024-03-10', 'Active', 'Credit Card', 149.99),
(3, 4, '2023-03-10', '2023-09-10', 'Expired', 'Credit Card', 49.99),
(4, 5, '2023-04-05', '2024-04-05', 'Active', 'Debit Card', 29.99),
(5, 1, '2023-05-12', '2024-05-12', 'Active', 'Credit Card', 59.99),
(5, 4, '2023-05-12', '2024-05-12', 'Active', 'Credit Card', 49.99),
(6, 2, '2023-06-18', '2023-12-18', 'Cancelled', 'PayPal', 39.99);
