
-- PAIR JOIN I

-- 1. Pedidos por empresa en UK:

SELECT customers.CustomerID AS Identificador, customers.CompanyName AS NombreEmpresa, orders.ShipCountry, COUNT(orders.OrderID) AS NumeroPedidos
FROM customers
INNER JOIN orders
ON customers.CustomerID = orders.CustomerID
WHERE ShipCountry= 'UK'
GROUP BY customers.CompanyName
HAVING COUNT(orders.OrderID);

-- 2. Productos pedidos por empresa en UK por año:

SELECT p.ProductID, o.OrderID, o.Quantity
FROM products AS p
INNER JOIN orderdetails AS o
ON p.ProductID = o.ProductID;

SELECT r.ShipName, r.ShipCountry, o.Quantity, YEAR(r.OrderDate) 
FROM orders AS r
INNER JOIN orderdetails AS o
ON r.OrderID = o.OrderID
WHERE ShipCountry= 'UK'
GROUP BY r.ShipName;

SELECT c.CompanyName, YEAR(o.OrderDate), SUM(od.Quantity)
FROM customers AS c
INNER JOIN orders AS o
USING (CustomerID)
INNER JOIN orderdetails AS od
USING (OrderID)
WHERE ShipCountry= 'UK'
GROUP BY c.CompanyName;

-- 3. Pedidos que han realizado cada compañía y su fecha:

SELECT o.OrderID, c.CompanyName, DATE(o.OrderDate)
FROM customers AS c
INNER JOIN orders AS o
USING (CustomerID);

-- 4. Tipos de producto vendidos:

SELECT c.CategoryID, c.CategoryName, p.ProductName, (o.Quantity * o.UnitPrice) AS ProductSales
FROM categories AS c
INNER JOIN products AS p
USING (CategoryID)
INNER JOIN orderdetails AS o
USING (ProductID)
GROUP BY p.ProductName;

-- 5. Qué empresas tenemos en la BBDD Northwind:

SELECT o.OrderID, c.CompanyName, DATE(o.OrderDate)
FROM customers AS c
INNER JOIN orders AS o
USING (CustomerID);

-- 6. Pedidos por cliente de UK: