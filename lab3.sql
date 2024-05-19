USE my_db;

SELECT id_ord, sum_ord, date_ord
FROM Orders;

SELECT * FROM Customers
WHERE id_cust = 8;

SELECT DISTINCT id_sel
FROM Orders;

SELECT * FROM Customers
WHERE rating_cust >= 60 AND NOT city_cust = 'Yerevan';

SELECT * FROM Orders
WHERE DATEPART(MONTH, date_ord) IN (10, 12) AND DATEPART(YEAR, date_ord) IN(2012);

SELECT * FROM Orders
WHERE YEAR(date_ord) = 2012 AND MONTH(date_ord) IN (10, 12);

SELECT id_cust, lname_cust, rating_cust
FROM Customers
ORDER BY rating_cust DESC;

