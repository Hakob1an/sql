CREATE PROCEDURE countCompanies
    @month INT, 
    @year INT,
    @totalCustomers INT OUTPUT
AS
BEGIN
    IF @month < 1 OR @month > 12
    BEGIN
        SET @totalCustomers = -1; 
        PRINT 'Enter a valid month number.';
        RETURN;
    END

    SELECT @totalCustomers = COUNT(DISTINCT C.CustomerID)
    FROM Customers C
    INNER JOIN Orders O ON O.CustomerID = C.CustomerID
    WHERE MONTH(O.OrderDate) = @month AND YEAR(O.OrderDate) = @year;
END;
GO


DECLARE @Total INT;
EXEC countCompanies @month = 7, @year = 1996, @totalCustomers = @Total OUTPUT;
SELECT @Total AS TotalUniqueCustomers;
