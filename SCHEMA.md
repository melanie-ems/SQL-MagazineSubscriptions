# Database Schema Documentation

## Overview
This database schema is designed for a magazine subscription management system. It tracks magazines, customers, their subscriptions, and payment history.

## Tables

### 1. Magazines
Stores information about available magazines.

**Columns:**
- `magazine_id` (INT, PRIMARY KEY): Unique identifier for each magazine
- `title` (VARCHAR(100), NOT NULL): Magazine title
- `publisher` (VARCHAR(100)): Publisher name
- `frequency` (VARCHAR(20)): Publication frequency (Weekly, Monthly, Quarterly, Annual)
- `price_per_issue` (DECIMAL(10,2), NOT NULL): Price per single issue
- `description` (TEXT): Magazine description

**Constraints:**
- Price must be greater than 0
- Frequency must be one of: Weekly, Monthly, Quarterly, Annual

### 2. Customers
Stores customer information.

**Columns:**
- `customer_id` (INT, PRIMARY KEY): Unique identifier for each customer
- `first_name` (VARCHAR(50), NOT NULL): Customer's first name
- `last_name` (VARCHAR(50), NOT NULL): Customer's last name
- `email` (VARCHAR(100), UNIQUE, NOT NULL): Customer's email address
- `phone` (VARCHAR(20)): Contact phone number
- `address_line1` (VARCHAR(100)): Primary address line
- `address_line2` (VARCHAR(100)): Secondary address line
- `city` (VARCHAR(50)): City
- `state` (VARCHAR(50)): State/Province
- `postal_code` (VARCHAR(20)): Postal/ZIP code
- `country` (VARCHAR(50)): Country (defaults to 'USA')
- `date_registered` (DATE): Registration date (defaults to current date)

**Constraints:**
- Email must be unique

### 3. Subscriptions
Links customers to magazines and tracks subscription details.

**Columns:**
- `subscription_id` (INT, PRIMARY KEY): Unique identifier for each subscription
- `customer_id` (INT, NOT NULL, FOREIGN KEY): References Customers table
- `magazine_id` (INT, NOT NULL, FOREIGN KEY): References Magazines table
- `start_date` (DATE, NOT NULL): Subscription start date
- `end_date` (DATE, NOT NULL): Subscription end date
- `status` (VARCHAR(20)): Current status (Active, Expired, Cancelled, Suspended)
- `auto_renew` (BOOLEAN): Whether subscription auto-renews (defaults to FALSE)

**Constraints:**
- End date must be after start date
- Status must be one of: Active, Expired, Cancelled, Suspended
- Deleting a customer cascades to delete their subscriptions
- Deleting a magazine is restricted if subscriptions exist

### 4. Payments
Tracks payment transactions for subscriptions.

**Columns:**
- `payment_id` (INT, PRIMARY KEY): Unique identifier for each payment
- `subscription_id` (INT, NOT NULL, FOREIGN KEY): References Subscriptions table
- `payment_date` (DATE, NOT NULL): Date of payment
- `amount` (DECIMAL(10,2), NOT NULL): Payment amount
- `payment_method` (VARCHAR(20)): Method used (Credit Card, Debit Card, PayPal, Bank Transfer, Cash)
- `transaction_id` (VARCHAR(100)): External transaction reference
- `status` (VARCHAR(20)): Payment status (Pending, Completed, Failed, Refunded)

**Constraints:**
- Amount must be greater than 0
- Payment method must be one of: Credit Card, Debit Card, PayPal, Bank Transfer, Cash
- Status must be one of: Pending, Completed, Failed, Refunded
- Deleting a subscription cascades to delete associated payments

## Indexes
The following indexes are created for improved query performance:
- `idx_customer_email`: On Customers.email
- `idx_subscription_customer`: On Subscriptions.customer_id
- `idx_subscription_magazine`: On Subscriptions.magazine_id
- `idx_subscription_status`: On Subscriptions.status
- `idx_payment_subscription`: On Payments.subscription_id
- `idx_payment_date`: On Payments.payment_date

## Usage

### Creating the Database
```sql
-- Run the create_tables.sql script
source create_tables.sql;
```

### Loading Sample Data
```sql
-- Run the sample_data.sql script
source sample_data.sql;
```

### Example Queries

**Get all active subscriptions for a customer:**
```sql
SELECT c.first_name, c.last_name, m.title, s.start_date, s.end_date
FROM Subscriptions s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Magazines m ON s.magazine_id = m.magazine_id
WHERE c.customer_id = 1 AND s.status = 'Active';
```

**Get total revenue by magazine:**
```sql
SELECT m.title, SUM(p.amount) as total_revenue
FROM Payments p
JOIN Subscriptions s ON p.subscription_id = s.subscription_id
JOIN Magazines m ON s.magazine_id = m.magazine_id
WHERE p.status = 'Completed'
GROUP BY m.magazine_id, m.title
ORDER BY total_revenue DESC;
```

**Find expiring subscriptions (within 30 days):**
```sql
SELECT c.first_name, c.last_name, c.email, m.title, s.end_date
FROM Subscriptions s
JOIN Customers c ON s.customer_id = c.customer_id
JOIN Magazines m ON s.magazine_id = m.magazine_id
WHERE s.status = 'Active' 
  AND s.end_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 30 DAY)
ORDER BY s.end_date;
```
