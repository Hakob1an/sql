USE my_db;

/*1*/
SELECT S.id_sel, S.city_sel, Orders.sum_ord
FROM Sellers AS S
JOIN Orders
ON S.id_sel = Orders.id_sel 
GROUP BY S.id_sel, S.city_sel, Orders.sum_ord
HAVING sum_ord <= 55000

SELECT * FROM Sellers;
SELECT * FROM Orders;

/*2*/
SELECT Sellers.lname_sel, Sellers.leader, Orders.sum_ord
FROM Sellers
JOIN Orders
ON Sellers.id_sel = Orders.id_sel;

/*3*/
SELECT Customers.name_cust, Customers.rating_cust, Orders.sum_ord
FROM Customers 
LEFT JOIN Orders
On Customers.id_cust = Orders.id_cust;

/*4*/
SELECT Sellers.id_sel, Sellers.lname_sel, Orders.date_ord
FROM Sellers
JOIN Orders
ON Sellers.id_sel = Orders.id_sel
WHERE Sellers.city_sel = 'Yerevan' AND YEAR(Orders.date_ord) < 2013;


/*5*/
SELECT Customers.lname_cust, Customers.city_cust, AVG(Orders.sum_ord) AS average_sum
FROM Customers
JOIN Orders ON Customers.id_cust = Orders.id_cust
WHERE YEAR(Orders.date_ord) = 2012
GROUP BY Customers.lname_cust, Customers.city_cust;

/*6*/
SELECT *
FROM Customers
LEFT JOIN Goods
ON Customers.id_cust = Goods.id_cust

SELECT *
FROM Customers
RIGHT JOIN Goods
ON Customers.id_cust = Goods.id_cust