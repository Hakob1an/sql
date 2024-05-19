use Northwind

-- Select the total number of products for each category.
select Categories.CategoryName,count(Products.ProductName) as ProductsCount
from Categories left join Products on Categories.CategoryID=Products.CategoryID
group by Categories.CategoryName;

select Categories.CategoryName,count(Products.ProductID) as ProductsCount
from Categories left join Products on Categories.CategoryID=Products.CategoryID
group by Categories.CategoryName;

-- Calculate the average unit price of products in each category.
select Categories.CategoryName,round(avg(Products.UnitPrice),2) as AvgUnitPrice
from Categories left join Products on Categories.CategoryID=Products.CategoryID
group by Categories.CategoryName;

-- Find the maximum and minimum unit price among all products.
select max(Products.UnitPrice) as MaxUnitPrice,min(Products.UnitPrice) as MinUnitPrice
from Products;

-- Count the number of customers in each country.
select Customers.Country,count(Customers.CustomerID)
from Customers
group by Customers.Country;

-- Sum the freight of all orders shipped to a specific country.
select Orders.ShipCountry, round(sum(Orders.Freight),2) as SumFreight from Orders
group by Orders.ShipCountry;

