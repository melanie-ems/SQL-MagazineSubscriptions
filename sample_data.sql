-- Sample Data for Magazine Subscriptions Database
-- This script inserts sample data into the tables

-- Insert sample magazines
INSERT INTO Magazines (title, publisher, frequency, price_per_issue, description) VALUES
('Tech Weekly', 'Tech Publishing Inc', 'Weekly', 4.99, 'Latest technology news and reviews'),
('Home & Garden Monthly', 'Home Life Press', 'Monthly', 5.99, 'Tips and ideas for home improvement and gardening'),
('Business Quarterly', 'Business Insights Ltd', 'Quarterly', 12.99, 'In-depth business analysis and market trends'),
('Fashion Today', 'Style Media Group', 'Monthly', 6.99, 'Latest fashion trends and style guides'),
('Science Annual', 'Academic Press', 'Annual', 29.99, 'Annual compilation of scientific discoveries');

-- Insert sample customers
INSERT INTO Customers (first_name, last_name, email, phone, address_line1, city, state, postal_code, country) VALUES
('John', 'Smith', 'john.smith@email.com', '555-0101', '123 Main St', 'New York', 'NY', '10001', 'USA'),
('Emma', 'Johnson', 'emma.johnson@email.com', '555-0102', '456 Oak Ave', 'Los Angeles', 'CA', '90001', 'USA'),
('Michael', 'Brown', 'michael.brown@email.com', '555-0103', '789 Pine Rd', 'Chicago', 'IL', '60601', 'USA'),
('Sarah', 'Davis', 'sarah.davis@email.com', '555-0104', '321 Elm St', 'Houston', 'TX', '77001', 'USA'),
('David', 'Wilson', 'david.wilson@email.com', '555-0105', '654 Maple Dr', 'Phoenix', 'AZ', '85001', 'USA');

-- Insert sample subscriptions
INSERT INTO Subscriptions (customer_id, magazine_id, start_date, end_date, status, auto_renew) VALUES
(1, 1, '2024-01-01', '2024-12-31', 'Active', TRUE),
(1, 3, '2024-01-01', '2024-12-31', 'Active', FALSE),
(2, 2, '2024-03-01', '2025-02-28', 'Active', TRUE),
(3, 1, '2024-02-15', '2024-08-15', 'Expired', FALSE),
(4, 4, '2024-06-01', '2025-05-31', 'Active', TRUE),
(5, 5, '2024-01-01', '2024-12-31', 'Active', FALSE);

-- Insert sample payments
INSERT INTO Payments (subscription_id, payment_date, amount, payment_method, transaction_id, status) VALUES
(1, '2024-01-01', 259.48, 'Credit Card', 'TXN001', 'Completed'),
(2, '2024-01-01', 155.88, 'Credit Card', 'TXN002', 'Completed'),
(3, '2024-03-01', 71.88, 'PayPal', 'TXN003', 'Completed'),
(4, '2024-02-15', 129.74, 'Debit Card', 'TXN004', 'Completed'),
(5, '2024-06-01', 83.88, 'Credit Card', 'TXN005', 'Completed'),
(6, '2024-01-01', 29.99, 'Bank Transfer', 'TXN006', 'Completed');
