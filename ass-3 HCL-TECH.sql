CREATE DATABASE EnterpriseDB;
USE EnterpriseDB;

drop table employees;
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(30) NOT NULL,
    Location VARCHAR(50) NOT NULL
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    JoiningDate DATE NOT NULL,
    ManagerID INT,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID),
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
);

CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    EmployeeName VARCHAR(50) NOT NULL,
    DepartmentID INT,
    Salary DECIMAL(10, 2),
    JoiningDate DATE NOT NULL,
    ManagerID INT,
    FOREIGN KEY (DepartmentID)REFERENCES Departments(DepartmentID),
    FOREIGN KEY (ManagerID)REFERENCES Employees(EmployeeID));
    
    
    
INSERT INTO Departments (DepartmentID, DepartmentName, Location) VALUES
(1, 'IT', 'Bengaluru'),
(2, 'Finance', 'Mumbai'),
(3, 'HR', 'Delhi'),
(4, 'Marketing', 'Chennai'),
(5, 'Legal', 'Hyderabad');

INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID,Salary, JoiningDate, ManagerID) VALUES
(101, 'Arjun', 1, 90000, '2021-01-15', NULL),
(102, 'Priya', 2, 85000, '2022-03-18', NULL),
(103, 'Rahul', 3, 80000, '2019-07-28', NULL),
(104, 'Sneha', 4, 75000, '2022-02-01', NULL);

INSERT INTO Employees (EmployeeID, EmployeeName, DepartmentID,Salary, JoiningDate, ManagerID)VALUES
(105, 'Kiran', 1, 70000, '2022-05-12', 101),
(106, 'Divya', 1, 70000, '2023-01-08', 101),
(107, 'Vikram', 1, 60000, '2023-04-18', 101),
(108, 'Meera', 1, 50000, '2024-06-05', 101),
(109, 'Anil', 2, 65000, '2021-09-14', 102),
(110, 'Kavya', 2, 55000, '2022-11-14', 102),
(111, 'Rohan', 2, 45000, '2024-02-17', 102),
(112, 'Pooja', 3, 60000, '2020-08-22', 103),
(113, 'Amit', 3, 50000, '2022-12-11', 103),
(114, 'Neha', 4, 60000, '2021-05-30', 104),
(115, 'Sanjay', 4, 55000, '2023-10-09', 104);

SELECT
    E.EmployeeName AS EmployeeName,
    D.DepartmentName AS DepartmentName,
    M.EmployeeName AS ManagerName
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
LEFT JOIN Employees M ON E.ManagerID = M.EmployeeID;

SELECT
    E.EmployeeID,
    E.EmployeeName,
    E.DepartmentID,
    E.Salary
FROM Employees E
WHERE E.Salary > (
    SELECT AVG(E2.Salary)
    FROM Employees E2
    WHERE E2.DepartmentID = E.DepartmentID
);

SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees1
WHERE Salary < (SELECT MAX(Salary) FROM Employees1);


CREATE DATABASE sales1;
USE sales1;

CREATE TABLE Sales1 (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    SaleDate DATE,
    ProductName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

CREATE DATABASE sales1;
USE sales1;

CREATE TABLE Sales1 (
    SaleID INT PRIMARY KEY,
    CustomerID INT,
    SaleDate DATE,
    ProductName VARCHAR(100),
    Quantity INT,
    UnitPrice DECIMAL(10, 2)
);

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
    ProductName,
    SUM(Quantity * UnitPrice) AS TotalRevenue
FROM Sales1
GROUP BY ProductName
ORDER BY TotalRevenue DESC;

SELECT
    DATE_FORMAT(SaleDate, '%Y-%m') AS SalesMonth,
    SUM(Quantity * UnitPrice) AS MonthlyRevenue,
    LAG(SUM(Quantity * UnitPrice)) OVER (
        ORDER BY DATE_FORMAT(SaleDate, '%Y-%m')
    ) - SUM(Quantity * UnitPrice) AS RevenueChange
FROM Sales1
GROUP BY DATE_FORMAT(SaleDate, '%Y-%m')
ORDER BY SalesMonth;

SELECT *
FROM Sales1
WHERE SaleDate >= '2025-01-01'
    AND SaleDate < '2026-01-01';
    
    
    