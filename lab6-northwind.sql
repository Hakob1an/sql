/*a*/
SELECT CompanyName 
FROM Customers
WHERE CustomerID = (SELECT CustomerID FROM Orders WHERE OrderID = 10290);

/*b*/
SELECT CompanyName 
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE YEAR(OrderDate) = 1997);

SELECT CompanyName 
FROM Customers
WHERE CustomerID IN (SELECT CustomerID FROM Orders WHERE OrderDate BETWEEN '1997-01-01' AND '1997-12-31');

/*c*/
SELECT ProductName 
FROM Products
WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName = 'Seafood');

/*d*/
SELECT CompanyName
FROM Suppliers
WHERE SupplierID IN (SELECT SupplierID FROM Products WHERE CategoryID IN (SELECT CategoryID FROM Categories WHERE CategoryName = 'Seafood'));

/*e*/
SELECT Employees.FirstName, Employees.LastName, Orders.OrderDate
FROM Employees
INNER JOIN Orders
ON Employees.EmployeeID = Orders.EmployeeID
ORDER BY Orders.OrderDate DESC;

/*fg*/
SELECT City, SUM(ECount) AS TotalEmployees, SUM(CCount) AS TotalCustomers
FROM (
    SELECT City, COUNT(EmployeeID) AS ECount, 0 AS CCount
    FROM Employees
    GROUP BY City
    UNION ALL
    SELECT City, 0, COUNT(CustomerID)
    FROM Customers
    GROUP BY City
) AS AllCounts
GROUP BY City;

--f
SELECT City, COUNT(EmployeeID) AS employeeCount
FROM Employees
GROUP BY City;

--g
SELECT City, COUNT(CustomerID) AS employeeCount
FROM Customers
GROUP BY City;


/*h*/
SELECT DISTINCT
    C.CompanyName,
    C.ContactName,
    O.ShipCountry,
    O.ShipCity,
    P.ProductName
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
JOIN OrderDetails OD ON O.OrderID = OD.OrderID
JOIN Products P ON OD.ProductID = P.ProductID
WHERE OD.Discount = 0.2;

/*i*/
SELECT Customers.CompanyName, AVG(OrderDetails.discount) AS averageDiscount
FROM  Customers
JOIN  Orders ON Customers.customerID = Orders.customerID
JOIN  OrderDetails ON Orders.OrderID = OrderDetails.OrderID
GROUP BY Customers.CompanyName;



