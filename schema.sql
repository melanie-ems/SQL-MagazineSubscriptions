-- Magazine Subscription Database Schema
-- This script creates tables for managing magazine subscriptions

-- Drop tables if they exist (for clean setup)
DROP TABLE IF EXISTS Subscription;
DROP TABLE IF EXISTS Customer;
DROP TABLE IF EXISTS Magazine;

-- Create Magazine table
CREATE TABLE Magazine (
    MagazineID INT PRIMARY KEY AUTO_INCREMENT,
    MagazineName VARCHAR(100) NOT NULL,
    Publisher VARCHAR(100),
    Category VARCHAR(50),
    IssueFrequency VARCHAR(20),
    AnnualPrice DECIMAL(10, 2),
    Description TEXT
);

-- Create Customer table
CREATE TABLE Customer (
    CustomerID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) UNIQUE NOT NULL,
    Phone VARCHAR(20),
    Address VARCHAR(200),
    City VARCHAR(50),
    State VARCHAR(50),
    PostalCode VARCHAR(20),
    Country VARCHAR(50),
    DateRegistered DATE DEFAULT CURRENT_DATE
);

-- Create Subscription table
CREATE TABLE Subscription (
    SubscriptionID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerID INT NOT NULL,
    MagazineID INT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    Status VARCHAR(20) DEFAULT 'Active',
    PaymentMethod VARCHAR(50),
    SubscriptionPrice DECIMAL(10, 2),
    FOREIGN KEY (CustomerID) REFERENCES Customer(CustomerID) ON DELETE CASCADE,
    FOREIGN KEY (MagazineID) REFERENCES Magazine(MagazineID) ON DELETE CASCADE,
    CONSTRAINT chk_dates CHECK (EndDate > StartDate),
    CONSTRAINT chk_status CHECK (Status IN ('Active', 'Expired', 'Cancelled', 'Pending'))
);

-- Create indexes for better query performance
CREATE INDEX idx_customer_email ON Customer(Email);
CREATE INDEX idx_subscription_customer ON Subscription(CustomerID);
CREATE INDEX idx_subscription_magazine ON Subscription(MagazineID);
CREATE INDEX idx_subscription_status ON Subscription(Status);
