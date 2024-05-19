USE my_db;

/*1*/
SELECT Sellers.id_sel, Sellers.city_sel, Orders.sum_ord
FROM Sellers
INNER JOIN Orders
ON Sellers.id_sel = Orders.id_sel 
WHERE sum_ord <= 55000
ORDER BY Orders.sum_ord DESC


/*2*/
SELECT Sellers.lname_sel, Sellers.leader, Orders.sum_ord
FROM Sellers
INNER JOIN Orders
ON Sellers.id_sel = Orders.id_sel;

SELECT Sellers.lname_sel, Sellers.leader, SUM(Orders.sum_ord) AS Sum
FROM Sellers
INNER JOIN Orders
ON Sellers.id_sel = Orders.id_sel
GROUP BY Sellers.id_sel, Sellers.lname_sel, Sellers.leader;

/*3*/
SELECT Customers.name_cust, Customers.rating_cust, Orders.sum_ord
FROM Customers 
INNER JOIN Orders
On Customers.id_cust = Orders.id_cust;

SELECT Customers.name_cust, Customers.rating_cust, SUM(Orders.sum_ord)
FROM Customers 
INNER JOIN Orders
On Customers.id_cust = Orders.id_cust
GROUP BY Orders.id_cust, Customers.name_cust, Customers.rating_cust;

/*4*/
SELECT Sellers.id_sel, Sellers.lname_sel, Orders.date_ord
FROM Sellers
INNER JOIN Orders
ON Sellers.id_sel = Orders.id_sel
WHERE Sellers.city_sel = 'Yerevan' AND YEAR(Orders.date_ord) < 2013;

SELECT * FROM Sellers;
SELECT * FROM Orders;

/*5*/
SELECT Customers.lname_cust, Customers.city_cust, AVG(Orders.sum_ord) AS average_sum
FROM Customers
INNER JOIN Orders ON Customers.id_cust = Orders.id_cust
WHERE YEAR(Orders.date_ord) = 2012
GROUP BY Customers.lname_cust, Customers.city_cust;

/*6*/
SELECT Customers.*
FROM Customers
LEFT JOIN Goods
ON Customers.id_cust = Goods.id_cust

SELECT * FROM Customers;
SELECT * FROM Goods;

SELECT Customers.*
FROM Customers
RIGHT JOIN Goods
ON Customers.id_cust = Goods.id_cust;

SELECT * FROM Customers;
SELECT * FROM Goods;