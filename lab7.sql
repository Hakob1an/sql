USE my_db;

--7.1
SELECT * 
FROM Orders
WHERE sum_ord IN (SELECT credit FROM Customers WHERE Orders.id_cust = Customers.id_cust);

--7.2
SELECT * 
FROM Customers
WHERE id_cust IN (SELECT id_cust FROM Orders WHERE sum_ord = 70000);

--7.3
SELECT *
FROM Customers
WHERE id_cust IN (SELECT id_cust FROM Orders);

--7.4
--a
SELECT * 
FROM Customers
WHERE id_cust IN (SELECT id_cust FROM Orders WHERE Orders.sum_ord <= 60000);

--b
SELECT DISTINCT Customers.*
FROM Customers
INNER JOIN Orders
ON Customers.id_cust = Orders.id_cust
WHERE Orders.sum_ord <= 60000;