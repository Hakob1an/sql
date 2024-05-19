USE my_db;

/*1*/
SELECT MAX(rating_cust) AS max_rating
FROM Customers;

/*2*/
SELECT YEAR(date_ord), AVG(sum_ord)
FROM Orders
GROUP BY YEAR(date_ord);

/*3*/
SELECT lname_cust, rating_cust 
FROM Customers
Where city_cust = 'Yerevan';

/*4*/
SELECT * FROM Sellers
WHERE LEFT(name_sel, 1) = 'M';

SELECT * FROM Sellers
WHERE name_sel LIKE('M%');

SELECT * FROM Sellers
WHERE SUBSTRING(name_sel, 1, 1) = 'M';

/*5*/
SELECT * FROM Customers
WHERE lname_cust LIKE('%yan');

SELECT * FROM Customers
WHERE SUBSTRING(lname_cust, LEN(lname_cust) - 2, 3) = 'yan';

SELECT * FROM Customers
WHERE RIGHT(lname_cust, 3) = 'yan';

/*6*/
SELECT * FROM Sellers
WHERE name_sel = REVERSE(name_sel);

/*7*/
SELECT /*id_cust,*/ MIN(price * quantity) AS min_price
FROM Goods
--GROUP BY id_cust;

SELECT id_cust, MIN(price * quantity) AS min_price
FROM Goods
GROUP BY id_cust;