/*SET ANSI_NULLS OFF;

DECLARE @Var INT = NULL;

-- Возвращает UNKNOWN, поэтому условие в IF не выполняется
IF @Var = NULL
    PRINT 'Equals'; -- Этот код не выполнится
ELSE
    PRINT 'Not equals or Unknown'; -- Этот код выполнится
*/

/*SELECT * FROM Customers WHERE EXISTS (SELECT * FROM Orders WHERE Customers.id_cust = Orders.id_cust);
SELECT * FROM Customers;
SELECT * FROM Orders;*/

/*SELECT ProductName
FROM Products
WHERE ProductID = ANY (SELECT ProductID FROM OrderDetails WHERE Quantity > 10);

SELECT ProductName
FROM Products
WHERE ProductID = ALL (SELECT ProductID FROM OrderDetails WHERE Quantity > 10);*/


-- Вычисление разницы в днях между двумя датами
SELECT DATEDIFF(DAY, '2023-01-01', '2023-01-10') AS DaysDifference;

-- Определение количества месяцев между двумя датами
SELECT DATEDIFF(MONTH, '2023-01-01', GETDATE()) AS MonthsDifference;


SELECT 
    ProductID,
    ProductName,
    UnitsInStock,
    CASE
        WHEN UnitsInStock = 0 THEN 'none'
        WHEN UnitsInStock < 10 THEN 'small'
        ELSE 'enough'
    END AS StockStatus
FROM Products;

if IsNumeric ('45')=1
print 'true'
else
print 'false'

SELECT CEILING(1.00000000000000000000000001) AS RoundedValue;

SELECT CAST (3.1258 AS INT);

SELECT COUNT(DISTINCT City) AS NumberOfDepartments
FROM Employees;

