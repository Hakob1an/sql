use Northwind

-- join Orders and Customers to list all orders with customer names.
select Orders.*,Customers.CompanyName
from Orders join Customers on Orders.CustomerID=Customers.CustomerID; 

-- Find products and their category names.
select Products.ProductName, Categories.CategoryName
from Products join Categories on Products.CategoryID=Categories.CategoryID;

-- List employees and the orders they handled.
select Employees.FirstName,Employees.LastName, Orders.OrderID
from Employees right join Orders on Employees.EmployeeID=Orders.EmployeeID

-- Show customer names along with their order counts.
select Customers.CompanyName,count(Orders.OrderID) as OrderCount
from Customers right join Orders on Customers.CustomerID=Orders.CustomerID
group by Customers.CompanyName;

-- Display products along with supplier information.
select Suppliers.*, Products.ProductName
from Products left join Suppliers on Products.SupplierID=Suppliers.SupplierID;