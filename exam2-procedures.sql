--1
create proc n1 @fr money
as
begin
    select distinct(S.CompanyName) from Suppliers S
    inner join Products P
    on P.SupplierID = S.SupplierID
    inner join OrderDetails OD
    on OD.ProductID = P.ProductID
    inner join Orders O
    on O.OrderID = OD.OrderID
    where O.Freight < @fr;
end;

exec n1 @fr = 50.00
go


--2
create proc n2 @phone nvarchar(24), @city nvarchar(15)
as
begin
    select distinct(C.CustomerID), R.RegionDescription
    from Customers C
    inner join Orders O
    on O.CustomerID = C.CustomerID
    inner join Employees E
    on O.EmployeeID = E.EmployeeID
    inner join EmployeeTerritories ET
    on E.EmployeeID = ET.EmployeeID
    inner join Territories T
    on ET.TerritoryID = T.TerritoryID
    inner join Region R
    on R.RegionID = T.RegionID
    where C.Phone = @phone and C.City = @city
end;

exec n2 @phone = '(91) 555 22 82', @city = 'Madrid';
go


--3
create proc n3 @name nvarchar(50), @category nvarchar(50)
as
begin
    select distinct(P.ProductName), Ct.CategoryName, OD.UnitPrice
    from Products P
    inner join OrderDetails OD
    on OD.ProductID = P.ProductID
    inner join Categories Ct
    on P.CategoryID = Ct.CategoryID
    where P.ProductName = @name and Ct.CategoryName = @category
end;

exec n3 'Chai', 'Beverages'
exec n3 'Ikura', 'Seafood'
go

--4
--2-i nman

--7
create proc n7 @pc nvarchar(50)
as
begin
    select count(distinct(EmployeeID)) as EmployeeCount
    from Employees
    where PostalCode = @pc
end;

exec n7 '98401'
go


--10
create proc n10 @id int
as
begin
    select datediff(day, O.RequiredDate, O.ShippedDate) as DateDifference
    from Products P
    inner join OrderDetails OD
    on OD.ProductID = P.ProductID
    inner join Orders O
    on O.OrderID = Od.OrderID
    where P.ProductID = @id
end;

exec n10 11


