# Entity Relationship Diagram

## Magazine Subscription Database

```
┌─────────────────────────────┐
│        Magazine             │
├─────────────────────────────┤
│ PK MagazineID (INT)         │
│    MagazineName (VARCHAR)   │
│    Publisher (VARCHAR)      │
│    Category (VARCHAR)       │
│    IssueFrequency (VARCHAR) │
│    AnnualPrice (DECIMAL)    │
│    Description (TEXT)       │
└─────────────────────────────┘
              │
              │ 1
              │
              │
              │ N
              ▼
┌─────────────────────────────┐
│      Subscription           │
├─────────────────────────────┤
│ PK SubscriptionID (INT)     │
│ FK CustomerID (INT)         │
│ FK MagazineID (INT)         │
│    StartDate (DATE)         │
│    EndDate (DATE)           │
│    Status (VARCHAR)         │
│    PaymentMethod (VARCHAR)  │
│    SubscriptionPrice (DEC)  │
└─────────────────────────────┘
              ▲
              │ N
              │
              │
              │ 1
              │
┌─────────────────────────────┐
│         Customer            │
├─────────────────────────────┤
│ PK CustomerID (INT)         │
│    FirstName (VARCHAR)      │
│    LastName (VARCHAR)       │
│    Email (VARCHAR) UNIQUE   │
│    Phone (VARCHAR)          │
│    Address (VARCHAR)        │
│    City (VARCHAR)           │
│    State (VARCHAR)          │
│    PostalCode (VARCHAR)     │
│    Country (VARCHAR)        │
│    DateRegistered (DATE)    │
└─────────────────────────────┘
```

## Relationships

- **Magazine** to **Subscription**: One-to-Many
  - One magazine can have multiple subscriptions
  - Each subscription is for exactly one magazine

- **Customer** to **Subscription**: One-to-Many
  - One customer can have multiple subscriptions
  - Each subscription belongs to exactly one customer

## Constraints

1. **Primary Keys**: Each table has an auto-incrementing integer primary key
2. **Foreign Keys**: 
   - Subscription.CustomerID → Customer.CustomerID (ON DELETE CASCADE)
   - Subscription.MagazineID → Magazine.MagazineID (ON DELETE CASCADE)
3. **Unique Constraints**: Customer.Email must be unique
4. **Check Constraints**:
   - Subscription.EndDate must be greater than StartDate
   - Subscription.Status must be one of: 'Active', 'Expired', 'Cancelled', 'Pending'
5. **Not Null Constraints**: Essential fields like names, dates, and IDs cannot be null

## Indexes

- `idx_customer_email`: Index on Customer(Email) for fast email lookups
- `idx_subscription_customer`: Index on Subscription(CustomerID) for customer queries
- `idx_subscription_magazine`: Index on Subscription(MagazineID) for magazine queries
- `idx_subscription_status`: Index on Subscription(Status) for status filtering
