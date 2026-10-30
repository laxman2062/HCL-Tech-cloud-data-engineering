CREATE DATABASE EnterpriseDB1;
USE EnterpriseDB1;

CREATE TABLE Departments (
DepartmentID INT PRIMARY KEY,
DepartmentName VARCHAR(30) NOT NULL,
Location VARCHAR(50) NOT NULL);

CREATE TABLE Employees1 (
EmployeeID INT PRIMARY KEY,
EmployeeName VARCHAR(50) NOT NULL,
DepartmentID INT,
Salary DECIMAL(10, 2),
JoiningDate DATE NOT NULL,
ManagerID INT,
FOREIGN KEY (DepartmentID)REFERENCES Departments(DepartmentID),
FOREIGN KEY (ManagerID)REFERENCES Employees1(EmployeeID));

INSERT INTO Departments (DepartmentID, DepartmentName, Location) VALUES
(1, 'IT', 'Bengaluru'),
(2, 'Finance', 'Mumbai'),
(3, 'HR', 'Delhi'),
(4, 'Marketing', 'Chennai'),
(5, 'Legal', 'Hyderabad');


INSERT INTO Employees1 (EmployeeID, EmployeeName, DepartmentID,Salary, JoiningDate, ManagerID)VALUES
(105, 'Kiran', 1, 70000, '2022-05-12', 101),
(106, 'Divya', 1, 70000, '2023-01-08', 101),
(107, 'Vikram', 1, 60000, '2023-04-18', 101),
(108, 'Meera', 1, 50000, '2024-06-25', 101),
(109, 'Anil', 2, 65000, '2021-09-14', 102),
(110, 'Kavya', 2, 55000, '2022-11-03', 102),
(111, 'Rohan', 2, 45000, '2024-02-17', 102),
(112, 'Pooja', 3, 60000, '2020-08-22', 103),
(113, 'Amit', 3, 50000, '2022-12-11', 103),
(114, 'Neha', 4, 60000, '2021-05-30', 104),
(115, 'Sanjay', 4, 55000, '2023-10-09', 104);

SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees1 WHERE Salary < (SELECT MAX(Salary) FROM Employees1);

SELECT
E.EmployeeName AS EmployeeName,
D.DepartmentName AS DepartmentName,
M.EmployeeName AS ManagerName
FROM Employees1 E
LEFT JOIN Departments D ON E.DepartmentID = D.DepartmentID
LEFT JOIN Employees1 M ON E.ManagerID = M.EmployeeID;

SELECT
E.EmployeeID,
E.EmployeeName,
E.DepartmentID,
E.Salary
FROM Employees1 E
WHERE E.Salary > (
SELECT AVG(E2.Salary) FROM Employees1 E2 WHERE E2.DepartmentID = E.DepartmentID);