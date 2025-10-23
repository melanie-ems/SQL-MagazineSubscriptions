# SQL-MagazineSubscriptions
Modelled on a past paper

## Overview
This repository contains SQL scripts for creating and managing a magazine subscription database system.

## Files
- `create_tables.sql` - SQL script to create all necessary database tables
- `sample_data.sql` - SQL script with sample data for testing
- `verify_tables.sql` - SQL script to verify table creation and structure
- `SCHEMA.md` - Detailed documentation of the database schema

## Quick Start
1. Create the tables:
   ```sql
   source create_tables.sql;
   ```

2. (Optional) Load sample data:
   ```sql
   source sample_data.sql;
   ```

3. (Optional) Verify table creation:
   ```sql
   source verify_tables.sql;
   ```

## Database Schema
The system includes four main tables:
- **Magazines** - Store magazine information
- **Customers** - Store customer details
- **Subscriptions** - Track customer subscriptions to magazines
- **Payments** - Record payment transactions

See `SCHEMA.md` for detailed documentation.
