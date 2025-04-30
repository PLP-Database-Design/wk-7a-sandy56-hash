-- Question 1

-- Create a new table to store the 1NF data. 
-- This avoids altering the original table.
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);
-- Use INSERT with a subquery to split the 'Products' string into individual rows.
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
SELECT
    OrderID,
    CustomerName,
-- TRIM removes leading and trailing spaces from the extracted product names.
    TRIM(substring_index(Products, ',', n)) AS Product
FROM ProductDetail
CROSS JOIN (
    SELECT 1 AS n UNION ALL
    SELECT 2 UNION ALL
    SELECT 3
    -- Add more UNION ALL statements if you expect more than 3 products in a single string
) AS numbers
WHERE n <= LENGTH(Products) - LENGTH(REPLACE(Products, ',', '')) + 1;

-- Question 2

-- Create a new table for Customers
CREATE TABLE Customers (
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Create a new table for Orders
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID)
);

-- Create a new table for OrderItems
CREATE TABLE OrderItems (
    OrderItemID INT PRIMARY KEY AUTO_INCREMENT,
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Insert data into the Customers table
INSERT INTO Customers (CustomerID, CustomerName)
VALUES
    (1, 'John Doe'),
    (2, 'Jane Smith'),
    (3, 'Emily Clark');

-- Insert data into the Orders table
INSERT INTO Orders (OrderID, CustomerID)
VALUES
    (101, 1),
    (102, 2),
    (103, 3);

-- Insert data into the OrderItems table
INSERT INTO OrderItems (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- Display the resulting tables
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderItems;



