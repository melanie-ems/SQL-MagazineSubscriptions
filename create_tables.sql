-- Magazine Subscriptions Database Schema
-- This script creates the necessary tables for a magazine subscription system

-- Drop tables if they exist (for clean recreation)
DROP TABLE IF EXISTS Payments;
DROP TABLE IF EXISTS Subscriptions;
DROP TABLE IF EXISTS Customers;
DROP TABLE IF EXISTS Magazines;

-- Create Magazines table
CREATE TABLE Magazines (
    magazine_id INT PRIMARY KEY AUTO_INCREMENT,
    title VARCHAR(100) NOT NULL,
    publisher VARCHAR(100),
    frequency VARCHAR(20) CHECK (frequency IN ('Weekly', 'Monthly', 'Quarterly', 'Annual')),
    price_per_issue DECIMAL(10, 2) NOT NULL,
    description TEXT,
    CONSTRAINT chk_price CHECK (price_per_issue > 0)
);

-- Create Customers table
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20),
    address_line1 VARCHAR(100),
    address_line2 VARCHAR(100),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(20),
    country VARCHAR(50) DEFAULT 'USA',
    date_registered DATE DEFAULT CURRENT_DATE
);

-- Create Subscriptions table
CREATE TABLE Subscriptions (
    subscription_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    magazine_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) DEFAULT 'Active' CHECK (status IN ('Active', 'Expired', 'Cancelled', 'Suspended')),
    auto_renew BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id) ON DELETE CASCADE,
    FOREIGN KEY (magazine_id) REFERENCES Magazines(magazine_id) ON DELETE RESTRICT,
    CONSTRAINT chk_dates CHECK (end_date > start_date)
);

-- Create Payments table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    subscription_id INT NOT NULL,
    payment_date DATE NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    payment_method VARCHAR(20) CHECK (payment_method IN ('Credit Card', 'Debit Card', 'PayPal', 'Bank Transfer', 'Cash')),
    transaction_id VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Completed' CHECK (status IN ('Pending', 'Completed', 'Failed', 'Refunded')),
    FOREIGN KEY (subscription_id) REFERENCES Subscriptions(subscription_id) ON DELETE CASCADE,
    CONSTRAINT chk_amount CHECK (amount > 0)
);

-- Create indexes for better query performance
CREATE INDEX idx_customer_email ON Customers(email);
CREATE INDEX idx_subscription_customer ON Subscriptions(customer_id);
CREATE INDEX idx_subscription_magazine ON Subscriptions(magazine_id);
CREATE INDEX idx_subscription_status ON Subscriptions(status);
CREATE INDEX idx_payment_subscription ON Payments(subscription_id);
CREATE INDEX idx_payment_date ON Payments(payment_date);
