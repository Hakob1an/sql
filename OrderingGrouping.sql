use Northwind

-- List categories and the count of products in each, ordered by the count of products.
select Categories.CategoryName,count(Products.ProductName) as ProductsCount
from Categories join Products on Categories.CategoryID=Products.CategoryID
group by Categories.CategoryName
order by count(Products.ProductName);

-- Show average price of products grouped by category, having average price greater than 50.
select Categories.CategoryName,round(avg(Products.UnitPrice),2) as AvgPrice
from Categories join Products on Categories.CategoryID=Products.CategoryID
group by Categories.CategoryName
having avg(Products.UnitPrice) > 50;

-- Order customers by country, then by city.
select Orders.ShipCountry,Orders.ShipCity from Orders
group by Orders.ShipCountry,Orders.ShipCity;

-- Group orders by month, showing counts of orders per month.
select datename("m",Orders.OrderDate) as OrderMonth, count(Orders.OrderID) as OrderCount from Orders
group by datename("m",Orders.OrderDate);

-- List employees with their total number of managed territories, having more than 5 territories.
select Employees.EmployeeID,Employees.FirstName,Employees.LastName, count(EmployeeTerritories.TerritoryID) as TerritoryCount
from Employees join EmployeeTerritories on Employees.EmployeeID=EmployeeTerritories.EmployeeID
group by Employees.EmployeeID,Employees.FirstName,Employees.LastName
having count(EmployeeTerritories.TerritoryID) > 5;

