USE my_db;

CREATE TABLE Customers (
    id_cust INT NOT NULL IDENTITY(1, 1),
    name_cust NVARCHAR(20) NOT NULL,
    lname_cust NVARCHAR(30) NOT NULL,
    city_cust NVARCHAR(30),
    rating_cust INT, 
    credit MONEY
    PRIMARY KEY(id_cust)
);

CREATE TABLE Sellers (
    id_sel INT NOT NULL IDENTITY(1, 1),
    name_sel NVARCHAR(20) NOT NULL,
    lname_sel NVARCHAR(50) NOT NULL,
    city_sel NVARCHAR(30),
    comis_sel DECIMAL,
    leader VARCHAR(40),
    plan_sel INT,
    PRIMARY KEY(id_sel)
);

CREATE TABLE Orders (
    id_ord INT NOT NULL IDENTITY(1, 1),
    sum_ord DECIMAL,
    date_ord DATETIME,
    id_sel INT NOT NULL,
    id_cust INT NOT NULL,
    PRIMARY KEY(id_ord),
    FOREIGN KEY(id_sel) REFERENCES Sellers,
    FOREIGN KEY(id_cust) REFERENCES Customers
);

CREATE TABLE Goods (
    id_goods INT NOT NULL IDENTITY(1, 1),
    goods_name NVARCHAR(50) NOT NULL,
    price MONEY,
    quantity INT,
    id_cust INT NOT NULL,
    PRIMARY KEY(id_goods),
    FOREIGN KEY(id_cust) REFERENCES Customers
);

