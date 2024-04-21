USE mintclassics;

#How much space is occupied in each warehouse
CREATE VIEW warehouse_space_cap AS
SELECT warehouseCode AS WarehouseCode, warehouseName AS WarehouseName, warehousePctCap AS PctCap, (100 -  warehousePctCap) AS PctOpen
FROM warehouses
ORDER BY PctCap DESC;

#Just exploring the data
SELECT * FROM products;
SELECT * FROM orders;
SELECT * FROM orderdetails;

#Data pulled for approx. 2.5 years
CREATE VIEW dates_data_pulled AS
SELECT MIN(orderDate) AS FirstOrderDate, MAX(orderDate) AS LastOrderDate
FROM orders;

#Orders by the date
CREATE VIEW orders_by_date AS
SELECT o.orderDate AS Date, od.productCode AS Code, p.productLine AS Line, SUM(od.quantityOrdered) AS Ordered
FROM orders o 
JOIN orderdetails od
ON o.orderNumber = od.orderNumber
JOIN products p
ON p.ProductCode = od.productCode
GROUP BY Date, Code, Line;

#How many orders per product
CREATE VIEW order_count_per_product AS
SELECT od.productCode AS Code, p.productName AS Name, p.productLine AS Line, SUM(od.quantityOrdered) AS TotalOrders, ROW_NUMBER() OVER(ORDER BY SUM(od.quantityOrdered) DESC) AS OrderRank
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
GROUP BY od.productCode;


#How many of each product were ordered
CREATE VIEW total_ordered AS
SELECT Line, SUM(TotalOrders) AS TotalOrdered
FROM (SELECT od.productCode AS Code, p.productName AS Name, p.productLine AS Line, SUM(od.quantityOrdered) AS TotalOrders, ROW_NUMBER() OVER(ORDER BY SUM(od.quantityOrdered)) AS OrderRank
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
GROUP BY od.productCode) AS TotalProductCount
GROUP BY Line
ORDER BY TotalOrdered DESC;

#Just exploring the data, may be used to solve other business solutions
SELECT * FROM payments;
SELECT * FROM customers;

#Where are customers located
CREATE VIEW customers_country AS
SELECT country AS Country, COUNT(customerName) AS CustomerCount
FROM customers
GROUP BY country
ORDER BY COUNT(customerName) DESC;

# Where the items are stored
CREATE VIEW products_storage AS
SELECT p.productName AS Name, p.productLine AS Line, p.quantityInStock AS StockCount, p.warehouseCode AS WarehouseCode, w.warehouseName AS WarehouseName
FROM products p
LEFT JOIN warehouses w
ON p.warehouseCode = w.warehouseCode
GROUP BY p.productName, p.productLine, p.quantityInStock, p.warehouseCode
ORDER BY WarehouseCode, StockCount DESC;

#How many products are stored in each warehouse
CREATE VIEW warehouse_storage_inventory AS
SELECT DISTINCT p.productLine AS Line, SUM(p.quantityInStock) AS TotalStock, w.warehouseName AS WarehouseName
FROM products p
LEFT JOIN warehouses w
ON p.warehouseCode = w.warehouseCode
GROUP BY productLine, w.warehouseName
ORDER BY TotalStock DESC;


#Total sales for each category
SELECT SUM(od.quantityOrdered * od.priceEach) AS total_ClassicCar_sales
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
WHERE p.productLine = "Classic Cars";

SELECT SUM(od.quantityOrdered * od.priceEach) AS total_VintageCar_sales
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
WHERE p.productLine = "Vintage Cars";

SELECT SUM(od.quantityOrdered * od.priceEach) AS total_Motorcycle_sales
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
WHERE p.productLine = "Motorcycles";

SELECT SUM(od.quantityOrdered * od.priceEach) AS total_Plane_sales
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
WHERE p.productLine = "Planes";

SELECT SUM(od.quantityOrdered * od.priceEach) AS total_TruckandBus_sales
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
WHERE p.productLine = "Trucks and Buses";

SELECT SUM(od.quantityOrdered * od.priceEach) AS total_ship_sales
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
WHERE p.productLine = "Ships";

SELECT SUM(od.quantityOrdered * od.priceEach) AS total_train_sales
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
WHERE p.productLine = "Trains";

#Total sales figures per product line
CREATE VIEW total_sales_figures_per_product AS
SELECT p.productLine AS Line, SUM(od.quantityOrdered * od.priceEach) AS TotalSalesPerProduct, ROW_NUMBER() OVER(ORDER BY SUM(od.quantityOrdered * od.priceEach) DESC) AS SaleRank
FROM orderdetails od
JOIN products p
ON od.productCode = p.productCode
GROUP BY Line;
