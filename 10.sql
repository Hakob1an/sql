--1
CREATE TRIGGER t1 ON Orders
INSTEAD OF INSERT
AS
BEGIN
    IF NOT EXISTS (SELECT * FROM inserted WHERE ShipCountry IS NOT NULL OR ShipCountry = '')
    BEGIN
        RAISERROR ('ShipCountry cannot be empty.', 16, 1) 
    END
    ELSE
    BEGIN
        INSERT INTO Orders (CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry)  select CustomerID, EmployeeID, OrderDate, RequiredDate, ShippedDate, ShipVia, Freight, ShipName, ShipAddress, ShipCity, ShipRegion, ShipPostalCode, ShipCountry
        FROM inserted  
        WHERE OrderID IN (SELECT OrderID
            FROM inserted) 
    END
END

INSERT INTO Orders (OrderDate, CustomerID, ShipCountry) VALUES (GETDATE(), 'VINET', NULL);
INSERT INTO Orders (OrderDate, CustomerID, ShipCountry) VALUES (GETDATE(), 'ALFKI', 'Germany');

SELECT * FROM Orders WHERE CustomerID = 'ALFKI'
GO

--2
CREATE TRIGGER trg_PreventPhoneUpdate
ON Customers
INSTEAD OF UPDATE
AS
BEGIN
    IF UPDATE(Phone)
    BEGIN
        RAISERROR ('Updating phone number is not allowed', 16, 1);
    END
    ELSE
    BEGIN
        UPDATE c
        SET c.ContactName = i.ContactName, c.CompanyName = i.CompanyName, c.ContactTitle = i.ContactTitle,
            c.Address = i.Address, c.City = i.City, c.Region = i.Region, c.PostalCode = i.PostalCode,
            c.Country = i.Country, c.Fax = i.Fax
        FROM Customers c
        JOIN inserted i ON c.CustomerID = i.CustomerID;
    END
END;
GO

UPDATE Customers SET Phone = '123-456-7890' WHERE CustomerID = 'ALFKI';
GO

--3
CREATE TRIGGER trg_PreventDCH
ON DATABASE 
FOR DROP_TABLE, ALTER_TABLE
AS
BEGIN
    RAISERROR ('Altering or dropping tables is not allowed', 16, 1);
    ROLLBACK TRANSACTION;
END;
GO

CREATE TABLE tmp(
    A INT,
    B INT,
);

DROP TABLE tmp; 

--4
SELECT name, type_desc
FROM sys.triggers;

--5
DISABLE TRIGGER trg_PreventPhoneUpdate ON Customers;
UPDATE Customers SET Phone = '123-456-7890' WHERE CustomerID = 'ALFKI';

ENABLE TRIGGER trg_PreventPhoneUpdate ON Customers;
UPDATE Customers SET Phone = '123-456-7890' WHERE CustomerID = 'ALFKI';

--6
DROP TRIGGER IF EXISTS t1;
DROP TRIGGER IF EXISTS trg_PreventDCH;
DROP TRIGGER IF EXISTS trg_PreventPhoneUpdate;

