--1
CREATE PROCEDURE 
GetCustomerOrderQuantities @ContactName NVARCHAR(100)
AS
BEGIN
    SELECT C.ContactName, O.OrderID, SUM(OD.Quantity) AS TotalQuantity
    FROM Customers C
    INNER JOIN Orders O
    ON O.CustomerID = C.CustomerID
    INNER JOIN OrderDetails OD
    ON OD.OrderID = O.OrderID
    WHERE C.ContactName = @ContactName
    GROUP BY C.ContactName, O.OrderID
    ORDER BY O.OrderID
END;
GO

--2
CREATE PROC SumOfOrder @month INT, @sumOrd MONEY OUTPUT
AS
BEGIN 
    IF @month >= 1 AND @month <= 12
    BEGIN
        SELECT @sumOrd = SUM(OD.Quantity * OD.UnitPrice)
        FROM OrderDetails OD
        INNER JOIN Orders O
        ON OD.OrderID = O.OrderID
        WHERE MONTH(O.OrderDate) = @month;
    END
    ELSE SET @sumOrd = NULL;
END;
GO

EXEC GetCustomerOrderQuantities @ContactName = 'Maria Anders';

DECLARE @total MONEY;
EXEC SumOfOrder @month = 1, @sumOrd = @total OUTPUT
SELECT @total AS TotalOrderSum;

/*CREATE PROC SumOfOrder2 @month INT, @sumOrd MONEY OUTPUT
AS
BEGIN 
    SET @sumOrd = NULL;
    BEGIN TRY
        IF @month < 1 OR @month > 12
        BEGIN
            RAISERROR('Invalid month value.', 16, 1)
        END;

        SELECT @sumOrd = SUM(OD.Quantity * OD.UnitPrice)
        FROM OrderDetails OD
        INNER JOIN Orders O
        ON OD.OrderID = O.OrderID
        WHERE MONTH(O.OrderDate) = @month;

    END TRY
    BEGIN CATCH
        SET @sumOrd = NULL;
        RAISERROR('An Error occured.', 16, 1)
    END CATCH
END;

DECLARE @total MONEY;
EXEC SumOfOrder2 @month = 1, @sumOrd = @total OUTPUT
SELECT @total AS TotalOrderSum;*/



