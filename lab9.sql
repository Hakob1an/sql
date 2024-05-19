--1
CREATE VIEW nview 
AS
SELECT FirstName, LastName
FROM Employees;
GO

--2
CREATE VIEW encrypted_view WITH ENCRYPTION
AS
SELECT E.LastName, MAX(O.Freight) AS MaxFreight
FROM Employees E
INNER JOIN Orders O
ON O.EmployeeID = E.EmployeeID
GROUP BY E.LastName;
GO

--3
CREATE VIEW re_view
AS 
SELECT E1.LastName
FROM Employees E1
JOIN Employees E2
ON E1.ReportsTo = E2.EmployeeID AND E2.LastName = 'Fuller';
GO

--4
CREATE VIEW sview 
AS 
SELECT S.CompanyName, P.ProductName
FROM Suppliers S
INNER JOIN Products P
ON P.SupplierID = S.SupplierID
INNER JOIN OrderDetails OD
ON P.ProductID = OD.ProductID
WHERE OD.Discount <> 0;