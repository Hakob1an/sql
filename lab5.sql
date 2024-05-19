USE my_db;

/*1*/
INSERT INTO Sellers
VALUES ('Hripsime', 'Hakobyan', 'Charentsavan', 20, 'Grigoryan V.', 150);

INSERT INTO Sellers
VALUES ('Aram', 'Hakobyan', 'Charentsavan', 18, 'Grigoryan V.', 100);

INSERT INTO Customers
VALUES ('John', 'Aramyan', 'Yerevan', 58, 102000);

/*2*/
INSERT INTO Goods(goods_name, quantity, id_cust)
VALUES ('Keyboard Pentium99', 20, 10);

/*3*/
SELECT * INTO Yerevan_Sellers
FROM Sellers
WHERE city_sel = 'Yerevan';

/*4*/
DELETE FROM Yerevan_Sellers;

/*5*/
DELETE FROM Goods 
WHERE id_cust IN (SELECT id_cust FROM Customers WHERE rating_cust < 50);
DELETE FROM Orders
WHERE id_cust IN (SELECT id_cust FROM Customers WHERE rating_cust < 50);
DELETE FROM Customers
WHERE rating_cust < 50;

/*6*/
UPDATE Customers
SET credit = credit * 1.1;
SELECT * FROM Customers;

/*7*/
UPDATE Orders
SET sum_ord = 0
WHERE YEAR(date_ord) = 2012;
SELECT * FROM Orders;