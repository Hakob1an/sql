--8.2
CREATE PROC pr2 
AS
BEGIN
    SELECT ProductName, UnitPrice
    FROM Products
    WHERE ProductName LIKE 'Ch%' AND UnitPrice < 20
END

EXEC pr2;
GO

--8.3
CREATE PROC pr3 WITH ENCRYPTION
AS
BEGIN
    SELECT ProductName, UnitPrice, UnitsInStock, SUM(UnitPrice * UnitsInStock) AS prod_sum
    FROM Products
    WHERE UnitsInStock <> 0
    GROUP BY ProductName, UnitPrice, UnitsInStock
END;

EXEC pr3;
GO

--8.4
CREATE PROC pr4 @year INT
AS
BEGIN 
    SELECT C.ContactName
    FROM Customers C
    INNER JOIN Orders O
    ON O.CustomerID = C.CustomerID
    WHERE YEAR(OrderDate) = @year
END;

EXEC pr4 1996;
GO

--8.5
CREATE PROC pr5 @CustomerID VARCHAR(20), @title NVARCHAR(20) OUTPUT
AS
BEGIN
    SET @title = (SELECT ContactTitle 
    FROM Customers
    WHERE CustomerID = @CustomerID)
END;

DECLARE @my_title VARCHAR(20)
EXEC pr5 'ALFKI', @my_title OUTPUT
SELECT @my_title;
