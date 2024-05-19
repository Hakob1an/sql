use Northwind


-- Вывести список всех продуктов, заказанных клиентами из Германии, вместе с именем клиента, названием продукта, количеством и общей стоимостью.
SELECT Customers.CompanyName,Products.ProductName,[Order Details].Quantity,([Order Details].UnitPrice * [Order Details].Quantity) as TotalPrice
FROM Customers
JOIN Orders ON Customers.CustomerID=Orders.CustomerID
JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
JOIN Products ON [Order Details].ProductID=Products.ProductID
WHERE Customers.Country='Germany';


-- Вывести список всех сотрудников, которые не обработали ни одного заказа, вместе с их именем и должностью.
SELECT distinct Employees.EmployeeID,Employees.FirstName, Employees.LastName,Employees.Title
FROM Employees LEFT JOIN Orders ON Employees.EmployeeID=Orders.EmployeeID
WHERE Orders.EmployeeID IS NULL;

-- Вывести список всех продуктов, которые были заказаны более 10 раз, вместе с названием продукта, количеством заказов и средней ценой. 
SELECT 
Products.ProductID,
Products.ProductName,
ROUND(AVG([Order Details].UnitPrice * [Order Details].Quantity),2) AS AvgTotalPrice
FROM Products JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
GROUP BY Products.ProductID,Products.ProductName
HAVING COUNT([Order Details].OrderID) > 10;

-- Вывести список всех категорий продуктов, средняя цена которых превышает 30 долларов, вместе с названием категории и средней ценой.
SELECT Categories.CategoryID,ROUND(AVG(Products.UnitPrice),2) as AvgPrice
FROM Categories JOIN Products ON Categories.CategoryID=Products.ProductID
GROUP BY Categories.CategoryID
HAVING AVG(Products.UnitPrice) > 30;

-- Вывести список всех клиентов, которые сделали заказы на сумму более 1000 долларов, вместе с именем клиента, общей суммой заказов и количеством заказов.
SELECT 
Customers.CustomerID,
Customers.CompanyName,
SUM([Order Details].Quantity * [Order Details].UnitPrice) AS TotalSum,
COUNT(Orders.OrderID) AS OrderNum
FROM Customers
JOIN Orders ON Customers.CustomerID=Orders.CustomerID
JOIN [Order Details] ON [Order Details].OrderID=Orders.OrderID
GROUP BY Customers.CustomerID,Customers.CompanyName
HAVING SUM([Order Details].Quantity * [Order Details].UnitPrice) > 1000;

-- Вывести список всех продуктов, которые были заказаны клиентами из одних и тех же стран, что и сотрудники, которые обработали эти заказы.
SELECT distinct
Products.ProductID,
Products.ProductName,
Customers.Country as CustomerCountry,
Employees.Country as EmployeeCountry
FROM Products
JOIN [Order Details] ON [Order Details].ProductID=Products.ProductID
JOIN Orders ON Orders.OrderID=Products.ProductID
JOIN Customers ON Customers.CustomerID=Orders.CustomerID
JOIN Employees ON Employees.EmployeeID=Orders.EmployeeID
WHERE Customers.Country=Employees.Country;

-- Вывести список всех клиентов, которые сделали заказы на сумму, превышающую среднюю сумму заказов для их страны.

--7
SELECT C.CompanyName, SUM(OD.UnitPrice * OD.Quantity) AS TotalPrice
FROM Customers C
INNER JOIN Orders O
ON O.CustomerID = C.CustomerID
INNER JOIN [Order Details] OD
ON O.OrderID = OD.OrderID
GROUP BY C.CompanyName
HAVING SUM(OD.UnitPrice * OD.Quantity) > (
        SELECT AVG(OD.UnitPrice * OD.Quantity) AS AverageCost
        FROM [Order Details] OD
        INNER JOIN Orders O
        ON OD.OrderId = O.OrderID
        INNER JOIN Customers C
        ON C.CustomerID = O.CustomerID
        WHERE C.Country = O.ShipCountry);

-- Вывести список всех продуктов, которые были заказаны в каждом году, начиная с 1996 года, вместе с названием продукта и количеством заказов в каждом году.
SELECT YEAR(Orders.OrderDate) as OrderYear,Products.ProductID,Products.ProductName,COUNT(Orders.OrderID) as OrderNum
FROM Products 
JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
JOIN Orders ON [Order Details].OrderID=Orders.OrderID
WHERE YEAR(Orders.OrderDate) >= 1996
GROUP BY YEAR(Orders.OrderDate),Products.ProductID,Products.ProductName
ORDER BY OrderYear;

