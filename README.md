# SQL-MagazineSubscriptions
Modelled on a past paper

## Overview
This repository contains a SQL database schema for managing magazine subscriptions. The database consists of three main tables: Magazine, Customer, and Subscription.

## Database Schema

### Tables

#### 1. Magazine Table
Stores information about available magazines.

| Column | Type | Description |
|--------|------|-------------|
| MagazineID | INT (PK) | Unique identifier for each magazine |
| MagazineName | VARCHAR(100) | Name of the magazine |
| Publisher | VARCHAR(100) | Publisher of the magazine |
| Category | VARCHAR(50) | Category (e.g., Technology, Lifestyle, Business) |
| IssueFrequency | VARCHAR(20) | How often the magazine is published |
| AnnualPrice | DECIMAL(10,2) | Annual subscription price |
| Description | TEXT | Description of the magazine |

#### 2. Customer Table
Stores customer information.

| Column | Type | Description |
|--------|------|-------------|
| CustomerID | INT (PK) | Unique identifier for each customer |
| FirstName | VARCHAR(50) | Customer's first name |
| LastName | VARCHAR(50) | Customer's last name |
| Email | VARCHAR(100) | Customer's email (unique) |
| Phone | VARCHAR(20) | Customer's phone number |
| Address | VARCHAR(200) | Street address |
| City | VARCHAR(50) | City |
| State | VARCHAR(50) | State/Province |
| PostalCode | VARCHAR(20) | Postal/ZIP code |
| Country | VARCHAR(50) | Country |
| DateRegistered | DATE | Date customer registered |

#### 3. Subscription Table
Links customers to magazines and tracks subscription details.

| Column | Type | Description |
|--------|------|-------------|
| SubscriptionID | INT (PK) | Unique identifier for each subscription |
| CustomerID | INT (FK) | References Customer table |
| MagazineID | INT (FK) | References Magazine table |
| StartDate | DATE | Subscription start date |
| EndDate | DATE | Subscription end date |
| Status | VARCHAR(20) | Status (Active, Expired, Cancelled, Pending) |
| PaymentMethod | VARCHAR(50) | Payment method used |
| SubscriptionPrice | DECIMAL(10,2) | Price paid for subscription |

### Relationships
- **Customer to Subscription**: One-to-Many (One customer can have multiple subscriptions)
- **Magazine to Subscription**: One-to-Many (One magazine can have multiple subscriptions)
- Foreign key constraints ensure referential integrity with CASCADE delete

## Files in This Repository

- **schema.sql**: Database schema definition with table creation statements
- **sample_data.sql**: Sample data for testing and demonstration
- **sample_queries.sql**: Example queries for common operations

## Setup Instructions

1. Create a new database:
   ```sql
   CREATE DATABASE MagazineSubscriptions;
   USE MagazineSubscriptions;
   ```

2. Run the schema script to create tables:
   ```sql
   SOURCE schema.sql;
   ```

3. (Optional) Load sample data:
   ```sql
   SOURCE sample_data.sql;
   ```

4. Try the sample queries:
   ```sql
   SOURCE sample_queries.sql;
   ```

## Usage Examples

### Add a new magazine:
```sql
INSERT INTO Magazine (MagazineName, Publisher, Category, IssueFrequency, AnnualPrice) 
VALUES ('Science Monthly', 'Academic Press', 'Science', 'Monthly', 79.99);
```

### Add a new customer:
```sql
INSERT INTO Customer (FirstName, LastName, Email, Phone, Address, City, State, PostalCode, Country) 
VALUES ('Jane', 'Doe', 'jane.doe@email.com', '555-0107', '789 Broadway', 'Boston', 'MA', '02101', 'USA');
```

### Create a new subscription:
```sql
INSERT INTO Subscription (CustomerID, MagazineID, StartDate, EndDate, Status, PaymentMethod, SubscriptionPrice) 
VALUES (1, 2, '2024-01-01', '2025-01-01', 'Active', 'Credit Card', 39.99);
```

### Query active subscriptions:
```sql
SELECT c.FirstName, c.LastName, m.MagazineName, s.StartDate, s.EndDate
FROM Subscription s
JOIN Customer c ON s.CustomerID = c.CustomerID
JOIN Magazine m ON s.MagazineID = m.MagazineID
WHERE s.Status = 'Active';
```

## Features

- **Referential Integrity**: Foreign key constraints maintain data consistency
- **Data Validation**: Check constraints ensure valid data (e.g., EndDate > StartDate)
- **Indexes**: Optimized for common query patterns
- **Flexible Design**: Supports multiple subscriptions per customer and multiple magazines
- **Status Tracking**: Track subscription lifecycle (Active, Expired, Cancelled, Pending)

## License
This project is for educational purposes.
