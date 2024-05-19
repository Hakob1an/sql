--1
select Sh.CompanyName, E.FirstName, C.CompanyName, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Price
from Shippers Sh
inner join Orders O
on O.ShipVia = Sh.ShipperID
inner join Employees E
on O.EmployeeID = E.EmployeeID
inner join Customers C
on O.CustomerID = C.CustomerID
inner join OrderDetails OD
on O.OrderID = OD.OrderID
where OD.ProductID IN (
    select ProductID from Products 
    where Discontinued = 0
)
group by Sh.CompanyName, E.FirstName, C.CompanyName;


--2
select E.EmployeeID, COUNT(OD.OrderID) as OrderCount, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) as OrderPrice
from Employees E
inner join Orders O
on O.EmployeeID = E.EmployeeID
inner join OrderDetails OD
on OD.OrderID = O.OrderID
where E.EmployeeID in (
    select E.EmployeeID from Employees E
    inner join Orders O
    on O.EmployeeID = E.EmployeeID
    inner join OrderDetails OD
    on OD.OrderID = O.OrderID
    group by E.EmployeeID
    having count(OD.OrderID) > 10
)
group by E.EmployeeID;


--3
select Sh.CompanyName, E.FirstName, C.CompanyName, SUM(OD.UnitPrice * OD.Quantity * (1 - OD.Discount)) AS Price
from Shippers Sh
inner join Orders O
on O.ShipVia = Sh.ShipperID
inner join Employees E
on O.EmployeeID = E.EmployeeID
inner join Customers C
on O.CustomerID = C.CustomerID
inner join OrderDetails OD
on O.OrderID = OD.OrderID
where OD.ProductID IN (
    select ProductID from Products 
    where Discontinued = 1
)
group by Sh.CompanyName, E.FirstName, C.CompanyName;


--4
select distinct(R.RegionDescription)
from Region R
inner join Territories T
on R.RegionID = T.RegionID
inner join EmployeeTerritories ET
On T.TerritoryID = ET.TerritoryID
inner join Employees E
on ET.EmployeeID = E.EmployeeID
where E.EmployeeID in (
    select E.EmployeeID from Employees E
    inner join Orders O
    on O.EmployeeID = E.EmployeeID 
    inner join OrderDetails OD
    on OD.OrderID = O.OrderID
    group by E.EmployeeID
    having count(OD.OrderID) < 200
);


--5
select O.OrderID, P.ProductID, P.ProductName
from Orders O
inner join OrderDetails OD
on OD.OrderID = O.OrderID
inner join Products P
on OD.ProductID = P.ProductID
where P.Discontinued = 0;


--6
select O.OrderID, C.CompanyName, E.FirstName
from Orders O
inner join Customers C
on O.CustomerID = C.CustomerID
inner join Employees E
on E.EmployeeID = O.EmployeeID;


--7
select P.ProductName, OD.Quantity, Ct.CategoryName
from Products P
inner join OrderDetails OD
on P.ProductID = OD.ProductID
inner join Categories Ct
on P.CategoryID = Ct.CategoryID
where P.CategoryID = Ct.CategoryID;


--8
select R.RegionDescription, count(E.EmployeeID) as EmployeeCount
from Region R
inner join Territories T
on R.RegionID = T.RegionID
inner join EmployeeTerritories ET
on ET.TerritoryID = T.TerritoryID
inner join Employees E
on E.EmployeeID = Et.EmployeeID
group by R.RegionDescription;


