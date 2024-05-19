use Northwind

-- Top-Selling Products: List the top 5 best-selling products by total quantity sold.
SELECT TOP 5 Products.ProductName,SUM([Order Details].Quantity) AS TotlaQuantity
FROM Products 
JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
GROUP BY Products.ProductName
ORDER BY SUM([Order Details].Quantity) DESC

-- Employees and Their Orders: For each employee, show how many orders they have processed, but only include employees who have processed more than 10 orders.
SELECT Employees.EmployeeID,Employees.FirstName,Employees.LastName,COUNT(Orders.OrderID) OrdersPlaced
FROM Employees LEFT JOIN Orders ON Employees.EmployeeID=Orders.EmployeeID
GROUP BY Employees.EmployeeID,Employees.FirstName,Employees.LastName
HAVING COUNT(Orders.OrderID) > 10;

-- Customer Orders by Year: Count how many orders each customer placed in the year 1996. Display the customer name and the order count.
SELECT Customers.CustomerID,Customers.CompanyName,COUNT(Orders.OrderID) as OrdersPlaced
FROM Customers LEFT JOIN Orders on Customers.CustomerID=Orders.CustomerID
WHERE YEAR(Orders.OrderDate)=1996
GROUP BY Customers.CustomerID,Customers.CompanyName;

-- Average Freight Costs: Calculate the average freight cost for orders shipped to each country. Display the country and the average cost.
SELECT Orders.ShipCountry,ROUND(AVG(Orders.Freight),2) AS AvgFreight FROM Orders
GROUP BY Orders.ShipCountry;

-- Products Not Ordered: List all products that have never been ordered. Include the product name and ID.
SELECT Products.ProductName 
from Products left join [Order Details] on Products.ProductID = [Order Details].ProductID
where [Order Details].ProductID is null;

-- Sales Trends: For each month in 1997, show total sales (you can calculate this from the quantity and unit price in Order Details). Display the month and the total sales.
SELECT DATENAME("m",Orders.OrderDate) as OrderMonth,SUM([Order Details].Quantity * [Order Details].UnitPrice) as TotalSales
FROM Orders JOIN [Order Details] ON Orders.OrderID=[Order Details].OrderID
GROUP BY DATENAME("m",Orders.OrderDate);


-- Order Details Extended Information: For each order, list the order ID, product name, and an extended price (quantity * unit price * (1 - discount)). 
--Display results for orders placed in January 1997.
SELECT 
Orders.OrderID,
Products.ProductName,
ROUND(SUM([Order Details].Quantity * [Order Details].UnitPrice * (1 - [Order Details].Discount)),2) AS ExtendedPrice
FROM [Order Details] 
JOIN Products ON [Order Details].ProductID=Products.ProductID
JOIN Orders ON [Order Details].OrderID=Orders.OrderID
WHERE MONTH(Orders.OrderDate) = 1 and YEAR(Orders.OrderDate) = 1997
GROUP BY Orders.OrderID,Products.ProductName;

-- Customers and Their Last Order Date: For each customer, find the date of their last order. Include customer name and last order date.
SELECT Customers.CompanyName,MAX(Orders.OrderDate) AS LastOrderDate
FROM Customers JOIN Orders ON Customers.CustomerID=Orders.CustomerID
GROUP BY Customers.CompanyName;

-- Suppliers and Product Count: Show each supplier and the count of products they supply. Only include suppliers with more than 5 products.
SELECT Suppliers.CompanyName,COUNT(Products.ProductID) as ProductCount
FROM Suppliers JOIN Products ON Suppliers.SupplierID=Products.SupplierID
GROUP BY Suppliers.CompanyName
HAVING COUNT(Products.ProductID) > 5;

-- Orders Without Freight: Find all orders placed in 1996 that had no freight cost (freight = 0). List the order ID and order date.
SELECT Orders.OrderID,Orders.Freight FROM Orders
WHERE YEAR(Orders.OrderDate)=1996 AND Orders.Freight=0; 

-- High-Volume Products: Identify products that have been ordered in a total quantity of 100 or more. Show product name and total quantity ordered.
SELECT Products.ProductName,SUM([Order Details].Quantity) AS TotalQuantityOrdered
FROM Products JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
GROUP BY Products.ProductName
HAVING SUM([Order Details].Quantity) > 100;

-- Category Sales for 1997: For each category, calculate the total sales for the year 1997. 
--Sales should be represented as the sum of (unit price * quantity) for all products in the category.
SELECT Categories.CategoryName,ROUND(SUM([Order Details].Quantity * [Order Details].UnitPrice),2) as TotalSales
FROM Categories
JOIN Products ON Products.CategoryID=Categories.CategoryID
JOIN [Order Details] ON Products.ProductID=[Order Details].ProductID
JOIN Orders ON Orders.OrderID=[Order Details].OrderID
WHERE YEAR(Orders.OrderDate)=1997
GROUP BY Categories.CategoryName;

-- Delayed Orders: Identify orders that were shipped after their required date. List order ID, customer ID, and the number of days late.
SELECT Orders.OrderID, ABS(DATEDIFF(DAY,Orders.ShippedDate,Orders.RequiredDate)) as DelayDays
FROM Orders
WHERE DATEDIFF(DAY,Orders.ShippedDate,Orders.RequiredDate) < 0;

-- Customer Order Frequency: Determine how frequently, on average, each customer places an order (i.e., average days between orders).
SELECT Customers.CompanyName,CAST(COUNT(Orders.OrderID) AS decimal)/ (1 + DATEDIFF(DAY,MIN(Orders.OrderDate),MAX(Orders.OrderDate))) as AvgOrderFrequency
FROM Customers join Orders on Customers.CustomerID=Orders.CustomerID
GROUP BY Customers.CompanyName;