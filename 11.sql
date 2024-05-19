SELECT DISTINCT R.RegionID, R.RegionDescription
FROM Region R
INNER JOIN Territories T
ON T.RegionID = R.RegionID
INNER JOIN EmployeeTerritories ET
ON ET.TerritoryID = T.TerritoryID
INNER JOIN Employees E
ON E.EmployeeID = ET.EmployeeID
INNER JOIN (
    SELECT EmployeeID, COUNT(OrderID) AS OrderCount
    FROM Orders
    GROUP BY EmployeeID 
) AS O
ON E.EmployeeID = O.EmployeeID
WHERE O.OrderCount < 200;

