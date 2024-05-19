SELECT DISTINCT Sh.CompanyName, O.OrderID
FROM Shippers Sh
INNER JOIN Orders O
ON O.ShipVia = Sh.ShipperID
INNER JOIN OrderDetails OD
ON O.OrderID = OD.OrderID
WHERE OD.UnitPrice > (
    SELECT AVG(UnitPrice)
    FROM OrderDetails
);

SELECT s.CompanyName, o.OrderID, MAX(od.TotalQuantity) as MaxQuantity
FROM (
    SELECT TOP 1 OrderID, SUM(Quantity) AS TotalQuantity
    FROM [Order Details]
    GROUP BY OrderID
    ORDER BY TotalQuantity DESC
) AS od
JOIN Orders o ON od.OrderID = o.OrderID
JOIN Shippers s ON o.ShipVia = s.ShipperID
GROUP BY s.CompanyName, o.OrderID;
SELECT 
    s.CompanyName, 
    SUM(od.Quantity) AS TotalQuantity
FROM 
    Shippers s
JOIN 
    Orders o ON s.ShipperID = o.ShipVia
JOIN 
    [Order Details] od ON o.OrderID = od.OrderID
GROUP BY 
    s.CompanyName
ORDER BY 
    TotalQuantity DESC;

