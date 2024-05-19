use Northwind

-- Show products that have a unit price above the average unit price of all products.
select Products.ProductName, avg(Products.UnitPrice) as AvgUnitPrice from Products
group by Products.ProductName
having avg(Products.UnitPrice) > (select avg(Products.UnitPrice) from Products);

-- Find employees who have been hired after the company's first order date.
SELECT Employees.FirstName,Employees.LastName,Employees.HireDate
from Employees
where Employees.HireDate > (
    select min(Orders.OrderDate) from Orders
);

-- Identify suppliers who provide products in more than 3 categories.

select Suppliers.SupplierID, Suppliers.CompanyName
from Suppliers
where Suppliers.SupplierID in (
    select Products.SupplierID
    from Products 
    group by Products.SupplierID
    having count(distinct Products.CategoryID) > 3
)

