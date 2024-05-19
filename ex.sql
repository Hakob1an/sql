SELECT Region.RegionID, Region.RegionDescription, COUNT(Orders.OrderID) AS NumberOfOrders
FROM Region
INNER JOIN Territories
ON Region.RegionID = Territories.RegionID
INNER JOIN EmployeeTerritories
ON EmployeeTerritories.TerritoryID = Territories.TerritoryID
INNER JOIN Employees
ON Employees.EmployeeID = EmployeeTerritories.EmployeeID
INNER JOIN Orders
ON Orders.EmployeeID = Employees.EmployeeID
GROUP BY Region.RegionID, Region.RegionDescription
ORDER BY NumberOfOrders DESC;