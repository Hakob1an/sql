SELECT DISTINCT Sh.CompanyName, O.OrderID, OD.UnitPrice 
FROM Shippers Sh
INNER JOIN Orders O
ON Sh.ShipperID = O.ShipVia
INNER JOIN OrderDetails OD
ON OD.OrderID = O.OrderID
WHERE OD.UnitPrice < (
    SELECT AVG(UnitPrice) AS avgPrice
    FROM OrderDetails
);

SELECT AVG(UnitPrice) AS avgPrice
FROM OrderDetails;