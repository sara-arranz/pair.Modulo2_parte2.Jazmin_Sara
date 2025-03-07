-- PAIR SUBCOSNULTAS

USE northwind;

-- 1. Extraed los pedidos con el máximo "order_date" para cada empleado.
-- Nuestro jefe quiere saber la fecha de los pedidos más recientes que ha gestionado 
-- cada empleado. Para eso nos pide que lo hagamos con una query correlacionada.

SELECT OrderDate, EmployeeID
FROM Orders;

SELECT EmployeeID, MAX(OrderDate)
FROM Orders
GROUP BY EmployeeID;

SELECT OrderID, CustomerID, EmployeeID, OrderDate, RequiredDate
FROM Orders AS o1
WHERE OrderDate IN (SELECT MAX(OrderDate)
					FROM Orders AS o2
                    WHERE o2.EmployeeID = o1.EmployeeID);


-- 2. Extraed información de los productos "Beverages".
-- En este caso nuestro jefe nos pide que le devolvamos toda la información necesaria para identificar un tipo de producto. 
-- En concreto, tienen especial interés por los productos con categoría "Beverages". 
-- Devuelve el ID del producto, el nombre del producto y su ID de categoría.

SELECT CategoryID, ProductName
FROM Products;

SELECT CategoryName
FROM Categories
WHERE CategoryName IN ("Beverages");

SELECT ProductID,ProductName,CategoryID
	FROM Products
    WHERE CategoryID IN (SELECT CategoryID
						FROM Categories
						WHERE CategoryName IN ("Beverages"));


-- 3. Extraed la lista de países donde viven los clientes, pero no hay ningún proveedor ubicado en ese país
-- Suponemos que si se trata de ofrecer un mejor tiempo de entrega a los clientes, entonces podría dirigirse a estos países 
-- para buscar proveedores adicionales.

SELECT Country
FROM Customers;

SELECT Country
FROM Suppliers;

SELECT DISTINCT c.Country
FROM Customers AS c
WHERE c.Country NOT IN (SELECT s.Country
						FROM Suppliers AS s);


-- 4. Extraer los clientes que compraron mas de 20 artículos "Grandma's Boysenberry Spread"
-- Extraed el OrderId y el nombre del cliente que pidieron más de 20 artículos 
-- del producto "Grandma's Boysenberry Spread" (ProductID 6) en un solo pedido.

SELECT OrderID
FROM orderdetails
WHERE Quantity > 20;

SELECT ProductName
FROM Products
WHERE ProductID = 6;


SELECT CompanyName, CustomerID
FROM Customers;

SELECT OrderID, CustomerID
FROM Orders;

-- ESTA QUERY ESTÁ BIEN ESTRUCTURADA PERO NO DEVUELVE LO QUE PIDE EL EJERCICIO
SELECT CustomerID, CompanyName
FROM Customers AS c
WHERE EXISTS ( SELECT 1
				FROM Orders AS o
					WHERE c.CustomerID = o.CustomerID 
						AND EXISTS (SELECT 1
										FROM orderdetails AS od
											WHERE od.OrderID = o.OrderID
												AND od.Quantity > 20));
                    
						
--------------------------------------------
SELECT OrderID,
	(SELECT CustomerID
		FROM Orders AS o
			WHERE o.OrderID = od.OrderID) AS CustomerID
											FROM orderdetails AS od
												WHERE od.ProductID = 6
														AND od.Quantity > 20;