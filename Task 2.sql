CREATE DATABASE sales1;
USE sales1;

CREATE TABLE Sales1 (
SaleID INT PRIMARY KEY,
CustomerID INT,
SaleDate DATE,
ProductName VARCHAR(100),
Quantity INT,
UnitPrice DECIMAL(10, 2));

INSERT INTO Sales1 (SaleID, CustomerID, SaleDate, ProductName, Quantity, UnitPrice) VALUES
(1, 101, '2025-01-15', 'Laptop', 2, 50000.00),
(2, 102, '2025-01-20', 'Mobile', 3, 20000.00),
(3, 103, '2025-01-25', 'Headphones', 5, 1500.00),
(4, 101, '2025-02-05', 'Laptop', 1, 50000.00),
(5, 104, '2025-02-12', 'Mobile', 2, 20000.00),
(6, 102, '2025-02-18', 'Headphones', 4, 1500.00),
(7, 105, '2025-03-03', 'Laptop', 3, 50000.00),
(8, 103, '2025-03-10', 'Mobile', 1, 20000.00),
(9, 101, '2025-03-15', 'Headphones', 6, 1500.00),
(10, 104, '2025-04-08', 'Laptop', 2, 50000.00),
(11, 105, '2025-04-14', 'Mobile', 4, 20000.00),
(12, 102, '2025-04-22', 'Headphones', 3, 1500.00),
(13, 103, '2025-05-06', 'Laptop', 1, 50000.00),
(14, 101, '2025-05-16', 'Mobile', 2, 20000.00),
(15, 104, '2025-05-25', 'Headphones', 8, 1500.00);

SELECT
ProductName, SUM(Quantity * UnitPrice) AS TotalRevenue
FROM Sales1
GROUP BY ProductName
ORDER BY TotalRevenue DESC;

SELECT
DATE_FORMAT(SaleDate, '%Y-%m') AS SalesMonth,
SUM(Quantity * UnitPrice) AS MonthlyRevenue,
SUM(Quantity * UnitPrice) -
LAG(SUM(Quantity * UnitPrice)) OVER (
ORDER BY DATE_FORMAT(SaleDate, '%Y-%m')) AS RevenueChange
FROM Sales1
GROUP BY DATE_FORMAT(SaleDate, '%Y-%m')
ORDER BY SalesMonth;

SELECT *
FROM Sales1
WHERE SaleDate >= '2025-01-01'
  AND SaleDate < '2026-01-01';