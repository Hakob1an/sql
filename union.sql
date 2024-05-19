--9.1
SELECT S.name_sel, S.city_sel
FROM Sellers S
UNION
SELECT C.name_cust, C.city_cust
FROM Customers C;

--9.2
SELECT city_sel
FROM Sellers
UNION ALL
SELECT city_cust 
FROM Customers
ORDER BY city_sel DESC;

SELECT city_sel
FROM Sellers
UNION
SELECT city_cust 
FROM Customers
ORDER BY city_sel DESC;


--9.3
CREATE TABLE Products (
  prod_id INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  [name] NVARCHAR(50),
  price INT,
  [description] NVARCHAR(50),
);

CREATE TABLE Sells_2015 (
  id_sel INT PRIMARY KEY NOT NULL IDENTITY(1, 1),
  prod_id INT,
  count INT,
  sel_date DATE,
  FOREIGN KEY (prod_id) REFERENCES Products(prod_id)
);

SELECT * INTO Sells_2016 FROM Sells_2015;
SELECT * INTO Sells_2017 FROM Sells_2015;

--9.4
INSERT INTO Products ([name], [description], price) VALUES
('Notebook Asser 15.6" intel core i5', 'ddr 500', 500),
('Notebook Asser 13.3" intel core i5', 'ssd 125', 600),
('Notebook Asser 13.3" intel core i7', 'ssd 250', 750),
('Notebook HP 13.3" intel core i7', 'ssd 250', 800),
('Notebook HP 15.6" intel core i7', 'ssd 1tb', 600),
('Mouse laser', 'Geniuse', 10),
('Mouse bluetooth', 'HP', 15),
('Mouse pen', '8X6', 20);

INSERT INTO Sells_2015 (prod_id, count, sel_date) VALUES
(2, 1, '2015-04-01'),
(3, 1, '2015-08-25'),
(6, 5, '2015-10-10'),
(2, 1, '2015-10-25'),
(7, 3, '2015-12-23');

INSERT INTO Sells_2016 (prod_id, count, sel_date) VALUES
(2, 1, '2016-02-12'),
(3, 2, '2016-02-26'),
(4, 1, '2016-04-12'),
(5, 2, '2016-06-20'),
(8, 4, '2016-09-23');

INSERT INTO Sells_2017 (prod_id, count, sel_date) VALUES
(2, 1, '2017-04-02'),
(4, 1, '2017-05-14'),
(5, 1, '2017-07-02'),
(7, 5, '2017-09-30');

--9.5
SELECT P.[name], S5.id_sel, S5.count
FROM Products P
INNER JOIN Sells_2015 S5
ON S5.prod_id = P.prod_id
UNION ALL
SELECT P.[name], S6.id_sel, S6.count
FROM Products P
INNER JOIN Sells_2016 S6
ON S6.prod_id = P.prod_id
UNION ALL
SELECT P.[name], S7.id_sel, S7.count
FROM Products P
INNER JOIN Sells_2017 S7
ON S7.prod_id = P.prod_id
ORDER BY count;

SELECT P.[name], S5.id_sel, S5.count
FROM Products P
INNER JOIN Sells_2015 S5
ON S5.prod_id = P.prod_id
UNION
SELECT P.[name], S6.id_sel, S6.count
FROM Products P
INNER JOIN Sells_2016 S6
ON S6.prod_id = P.prod_id
UNION
SELECT P.[name], S7.id_sel, S7.count
FROM Products P
INNER JOIN Sells_2017 S7
ON S7.prod_id = P.prod_id
ORDER BY count;

--9.6
SELECT count, YEAR(sel_date) AS [year]
FROM Sells_2016
UNION ALL
SELECT count, YEAR(sel_date) AS [year]
FROM Sells_2017
ORDER BY [year];

SELECT count, YEAR(sel_date) AS [year]
FROM Sells_2016
UNION 
SELECT count, YEAR(sel_date) AS [year]
FROM Sells_2017
ORDER BY [year];

--9.7
SELECT MAX([count]) as max_count
FROM Sells_2015
UNION
SELECT MAX([count]) as max_count
FROM Sells_2016
UNION
SELECT MAX([count]) as max_count
FROM Sells_2017;

--9.8
SELECT [name]
FROM Products
WHERE prod_id IN (
    SELECT prod_id
    FROM Sells_2015
    EXCEPT 
    SELECT prod_id
    FROM Sells_2016 
);
SELECT * FROM Products;
SELECT * FROM Sells_2015;
SELECT * FROM Sells_2016;

--9.9
SELECT [name]
FROM Products
WHERE prod_id IN (
    SELECT prod_id
    FROM Sells_2015
    INTERSECT 
    SELECT prod_id
    FROM Sells_2016 
    INTERSECT 
    SELECT prod_id
    FROM Sells_2017 
);
SELECT * FROM Products;
SELECT * FROM Sells_2015;
SELECT * FROM Sells_2016;
SELECT * FROM Sells_2017;

--9.11
--1
SELECT * INTO TOTAL_SELLS
FROM Sells_2015
WHERE 1=0; 

--2
INSERT INTO TOTAL_SELLS(prod_id, count, sel_date)
SELECT prod_id, count, sel_date FROM Sells_2015
UNION ALL
SELECT prod_id, count, sel_date FROM Sells_2016
UNION ALL 
SELECT prod_id, count, sel_date FROM Sells_2017;

--3
SELECT [name], [2015], [2016], [2017]
FROM (
    SELECT P.[name], S.count, YEAR(S.sel_date) AS sel_year
    FROM TOTAL_SELLS S
    INNER JOIN Products P
    ON P.prod_id = S.prod_id
) AS RES
PIVOT
(
    SUM(count) FOR sel_year IN ([2015], [2016], [2017])
) AS PivotTable;