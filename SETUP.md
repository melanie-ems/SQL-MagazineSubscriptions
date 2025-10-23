# Setup Guide

This guide will help you set up the Magazine Subscription database on different SQL platforms.

## Prerequisites

Choose one of the following database systems:
- MySQL 5.7 or higher
- MariaDB 10.2 or higher
- SQLite 3.x
- PostgreSQL (requires minor syntax adjustments)

## Setup Options

### Option 1: MySQL / MariaDB

1. **Create Database:**
   ```bash
   mysql -u root -p
   ```
   ```sql
   CREATE DATABASE MagazineSubscriptions;
   USE MagazineSubscriptions;
   ```

2. **Load Schema:**
   ```sql
   SOURCE schema.sql;
   ```

3. **Load Sample Data (Optional):**
   ```sql
   SOURCE sample_data.sql;
   ```

4. **Verify Installation:**
   ```sql
   SHOW TABLES;
   DESCRIBE Magazine;
   DESCRIBE Customer;
   DESCRIBE Subscription;
   ```

### Option 2: SQLite

1. **Create Database:**
   ```bash
   sqlite3 magazine_subscriptions.db
   ```

2. **Load Schema:**
   ```sql
   .read schema_sqlite.sql
   ```

3. **Enable Foreign Keys (Important!):**
   ```sql
   PRAGMA foreign_keys = ON;
   ```

4. **Load Sample Data (Optional):**
   ```sql
   .read sample_data.sql
   ```

5. **Verify Installation:**
   ```sql
   .tables
   .schema Magazine
   .schema Customer
   .schema Subscription
   ```

### Option 3: Command Line (SQLite)

```bash
# Create database and load schema in one command
sqlite3 magazine_subscriptions.db < schema_sqlite.sql

# Load sample data
sqlite3 magazine_subscriptions.db < sample_data.sql

# Verify
sqlite3 magazine_subscriptions.db ".tables"
```

### Option 4: Command Line (MySQL)

```bash
# Create database
mysql -u root -p -e "CREATE DATABASE MagazineSubscriptions;"

# Load schema
mysql -u root -p MagazineSubscriptions < schema.sql

# Load sample data
mysql -u root -p MagazineSubscriptions < sample_data.sql

# Verify
mysql -u root -p MagazineSubscriptions -e "SHOW TABLES;"
```

## Testing Your Installation

After setup, run these queries to verify everything is working:

### 1. Count Records
```sql
SELECT 'Magazines' as Table_Name, COUNT(*) as Count FROM Magazine
UNION ALL
SELECT 'Customers', COUNT(*) FROM Customer
UNION ALL
SELECT 'Subscriptions', COUNT(*) FROM Subscription;
```

Expected output (with sample data):
```
Magazines: 6
Customers: 6
Subscriptions: 10
```

### 2. Test Relationships
```sql
SELECT 
    c.FirstName,
    c.LastName,
    m.MagazineName,
    s.Status
FROM Subscription s
JOIN Customer c ON s.CustomerID = c.CustomerID
JOIN Magazine m ON s.MagazineID = m.MagazineID
LIMIT 5;
```

This should return subscription details with customer and magazine names.

### 3. Test Constraints

Try inserting invalid data to test constraints:

```sql
-- This should fail (invalid customer ID)
INSERT INTO Subscription (CustomerID, MagazineID, StartDate, EndDate)
VALUES (999, 1, '2024-01-01', '2025-01-01');

-- This should fail (end date before start date)
INSERT INTO Subscription (CustomerID, MagazineID, StartDate, EndDate)
VALUES (1, 1, '2025-01-01', '2024-01-01');

-- This should fail (invalid status)
INSERT INTO Subscription (CustomerID, MagazineID, StartDate, EndDate, Status)
VALUES (1, 1, '2024-01-01', '2025-01-01', 'InvalidStatus');
```

All three should produce errors, confirming that constraints are working.

## Troubleshooting

### Foreign Keys Not Working (SQLite)
SQLite requires foreign keys to be explicitly enabled:
```sql
PRAGMA foreign_keys = ON;
```

### Syntax Errors (MySQL)
Make sure you're using MySQL 5.7+ or MariaDB 10.2+:
```bash
mysql --version
```

### Date Format Issues
Use ISO 8601 format for dates: `YYYY-MM-DD`
```sql
'2024-01-15'  -- Correct
'01/15/2024'  -- Incorrect
```

### Permission Issues (MySQL)
Grant necessary privileges:
```sql
GRANT ALL PRIVILEGES ON MagazineSubscriptions.* TO 'your_user'@'localhost';
FLUSH PRIVILEGES;
```

## Next Steps

1. Review the **sample_queries.sql** file for example queries
2. Check **ERD.md** for the database structure diagram
3. Read **README.md** for usage examples
4. Start adding your own data!

## Cleanup (Optional)

To remove the database:

**MySQL:**
```sql
DROP DATABASE MagazineSubscriptions;
```

**SQLite:**
```bash
rm magazine_subscriptions.db
```
