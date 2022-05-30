-- 1.1 CREATED FRUITMARKET DATABASE
CREATE DATABASE FruitMarket;

USE FruitMarket;

-- 1.2 CREATED SUPPLIERS TABLE
CREATE TABLE Suppliers(
SupplierID VARCHAR(10) PRIMARY KEY,
CompanyName VARCHAR(30) NOT NULL,
ContactPerson VARCHAR(30) NOT NULL,
ContactNo VARCHAR(13) NOT NULL DEFAULT '000-000-0000',
ProductCategory VARCHAR(55) NOT NULL 
);

desc suppliers;

-- 1.3 CREATED PRODUCTS TABLE
CREATE TABLE Products(
ProductID VARCHAR(10) PRIMARY KEY,
ProductName VARCHAR(30) NOT NULL,
Price DECIMAL(10,2) DEFAULT 0.00,
Weight VARCHAR(15) NOT NULL DEFAULT 0,
Stock INT NOT NULL DEFAULT 0,
SupplierID VARCHAR(10) NOT NULL
);

alter table products
modify column
Price DECIMAL(10,2) NOT NULL DEFAULT 0.00;

desc products;

-- ADDING FOREIGN KEY TO PRODUCTS TABLE 
ALTER TABLE Products 
ADD CONSTRAINT prod_supplier FOREIGN KEY(SupplierID)
REFERENCES Suppliers(SupplierID)
ON UPDATE CASCADE
ON DELETE CASCADE;

-- 1.4 ONE-TO-MANY
-- 1.5 SUPPLIERID (PRODUCTS TABLE)

-- 1.6 ADDING RECORDS TO SUPPLIERS TABLE
INSERT INTO Suppliers
VALUES
('SUPP0001', 'Fruit City', 'Themba', '0115062089', 'Fruit'),
('SUPP0002', 'Vegan Veggie Express', 'Chinyere', '0137228936', 'Vegetables'),
('SUPP0003', 'The Nut House', 'Sam', '0216965133', 'Nuts'),
('SUPP0004', 'The Lazy Cow', 'Angelo', '0216964157', 'Dairy');

-- 1.7 ADDING RECORDS TO PRODUCTS TABLE
INSERT INTO Products
VALUES
-- SUPP0001: FRUIT CITY
('1001', 'Lady Finger Bananas', '17.95', '750g', '45', 'SUPP0001'),
('1002', 'Pink Lady Apples', '18.95', '1.5kg', '15', 'SUPP0001'),
('1003', 'Red Anjou Pears', '22.99', '1kg', '24', 'SUPP0001'),
('1004', 'Cavendish Bananas', '12.65', '900g', '18', 'SUPP0001'),
-- SUPP0002: Vegan Veggie Express
('2001', 'Tenderstem Broccoli', '35.90', '400g', '8', 'SUPP0002'),
('2002', 'Portobellini Mushrooms', '18.99', '250g', '16', 'SUPP0002'),
-- SUPP0003: The Nut House
('3001', 'Raw Almonds', '99.00', '1kg', '6', 'SUPP0003'),
('3002', 'Macaroon Butter', '32.95', '410g', '9', 'SUPP0003'),
('3003', 'Organic Coconut Oil', '89.95', '500ml', '15', 'SUPP0003'),
-- SUPP0004: The Lazy Cow
('4001', 'Ayshire Milk', '33.95', '3l', '23', 'SUPP0004'),
('4002', 'Simonzola Blue Cheese', '27.65', '270g', '4', 'SUPP0004');

-- 1.8 Write an SQL query to extract the following ProductId, ProductName, Price, Weight, Stock, 
-- ProductCategory. The query must retrieve records where stock on hand is below 20 order by 
-- Price in descending order as shown below
SELECT ProductId, ProductName, Price, Weight, Stock, ProductCategory
FROM Products
INNER JOIN Suppliers
USING(SupplierID)
WHERE Stock <= 20
ORDER BY Price DESC;

-- 1.9 Create a view called Q9 for the above SQL query to include TotalPrice
CREATE VIEW Q9 AS 
SELECT ProductId, ProductName, Price, Weight, Stock, ProductCategory,
ceil((Price * Stock * 1.15)) AS 'TotalPrice'
FROM Products
INNER JOIN Suppliers
USING(SupplierID)
WHERE Stock <= 20
ORDER BY Price DESC;

SELECT * FROM Q9;

-- 1.10 Write an SQL statement to create a user called ‘yourname_initialofyoursurname’ and grant 
-- INSERT privileges to FruitMarket database Supplier Table. 
CREATE USER 'Abdus-Samad_C'@'localhost'
IDENTIFIED BY 'lifechoices4321';

GRANT INSERT ON FruitMarket.Suppliers
TO 'Abdus-Samad_C'@'localhost';

FLUSH PRIVILEGES; 

-- 1.11 
-- C:\Users\Admin>MySQL -u Abdus-Samad_C -p
-- Enter password: ***************;

-- 1.12 
-- INSERT INTO Suppliers
-- VALUES
-- ('SUPP006', 'Fruit&Veg', 'Abdu', '0216965111', 'Nuts');

-- 1.13
-- SELECT *
-- FROM Suppliers;
-- ERROR 1142 (42000): SELECT command denied to user 'Abdus-Samad_C'@'localhost' for table 'suppliers'

-- 1.14  Create a view called Q1.14 which will display ONLY the new user you created and the root.
CREATE VIEW Q1_14 AS
SELECT user
FROM mysql.user
WHERE user = 'Abdus-Samad_C'
OR user = 'root';

SELECT * 
FROM Q1_14;

-- 1.15 
CREATE VIEW Q15 AS
SELECT *
FROM Products
WHERE Stock <=14 
OR Stock >=22
ORDER BY Stock ASC;

select * FROM Q15;

-- 1.16 
CREATE VIEW Q1_16 AS 
SELECT CompanyName, ContactNo, ProductName, Price
FROM Suppliers
LEFT JOIN Products 
USING (SupplierID);

SELECT * FROM Q1_16;

-- 1.17
CREATE VIEW Q1_17 AS 
SELECT
format(SUM(Price),2) AS 'Total Unit Price',
format((Price),2) AS 'Average Price',
COUNT(ProductName) AS 'Number of Products'
FROM Q1_16;

SELECT *
FROM Q1_17;

-- 1.18 
SELECT DISTINCT SupplierID
FROM Suppliers;


