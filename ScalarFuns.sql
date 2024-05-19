use Northwind

-- Display the upper case of all customer company names.
select UPPER(Customers.CompanyName) as UppercaseNames from Customers;

-- Find the length of each product name.
select Products.ProductName,LEN(Products.ProductName) as ProdNameLength from Products;

-- Show the current date and time.
select GETDATE() as CurrentDateTime;

-- Extract the year from all order dates.
select Orders.OrderID, year(Orders.OrderDate) as OrderDate from Orders;

--. Convert the freight values to integers.
select Orders.OrderID,CAST(Orders.Freight as int) as IntFreight from Orders;