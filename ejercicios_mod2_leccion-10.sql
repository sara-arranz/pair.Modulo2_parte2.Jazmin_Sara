USE northwind;

-- 1.Empleadas que sean de la misma ciudad. Desde recursos humanos nos piden realizar una consulta que muestre por pantalla los datos de todas las empleadas 
-- y sus supervisoras. Concretamente nos piden: la ubicación, nombre, y apellido tanto de las empleadas como de las jefas. 
-- Investiga el resultado, ¿sabes decir quién es el director?

SELECT e2.FirstName AS nombre_empleado, e2.LastName AS apellido_empleado, e2.City AS ubicacion_empleado,
e1.FirstName AS nombre_jefe, e1.LastName AS apellido_jefe,e1.City AS ubicacion_jefe
	FROM Employees AS e1, Employees AS e2
    WHERE e2.ReportsTo =  e1.EmployeeID;

-- Otra solución
SELECT A.City AS City, A.FirstName AS NombreEmpleado, A.LastName AS ApellidoEmpleado, 
B.City AS City, B.FirstName AS NombreJefe, B.LastName AS ApellidoJefe
FROM Employees AS A  
JOIN Employees AS B
ON A.ReportsTo = B.EmployeeID;


-- 2. El equipo de marketing necesita una lista con todas las categorías de productos, incluso si no tienen productos asociados. 
-- Queremos obtener el nombre de la categoría y el nombre de los productos dentro de cada categoría. 
-- Podriamos usar un RIGTH JOIN con 'categories'?, usemos tambien la tabla 'products'.

SELECT c.CategoryName, p.ProductName
FROM Categories AS c
RIGHT JOIN Products AS p
ON c.CategoryID = p.CategoryID;


-- 3. Desde el equipo de ventas nos piden obtener una lista de todos los pedidos junto con los datos de las empresas clientes. 
-- Sin embargo, hay algunos pedidos que pueden no tener un cliente asignado. 
-- Necesitamos asegurarnos de incluir todos los pedidos, incluso si no tienen cliente registrado.

SELECT o.OrderID, c.CompanyName
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.CustomerID = o.CustomerID;
-- WHERE OrderID IS NULL;

-- 4. El equipo de Recursos Humanos quiere saber qué empleadas han gestionado pedidos y cuáles no. 
-- Queremos obtener una lista con todas las empleadas y, si han gestionado pedidos, mostrar los detalles del pedido.

SELECT e. EmployeeID, e.FirstName, o.OrderID, o.OrderDate, o.ShippedDate
FROM Employees AS e
LEFT JOIN Orders AS o
ON e.EmployeeID = o.EmployeeID;
-- WHERE ShippedDate IS NULL;


-- AMPLIAMOS EJERCICIO AGRUPANDO POR EMPLEADA, CANTIDAD DE PEDIDOS:
SELECT e. EmployeeID, e.FirstName, COUNT(o.OrderID) AS OrderCount
FROM Employees AS e
LEFT JOIN Orders AS o
ON e.EmployeeID = o.EmployeeID
GROUP BY e.EmployeeID, e.FirstName;


-- 5. Desde el área de logística nos piden una lista de todos los transportistas (shippers) y los pedidos que han enviado. 
-- Queremos asegurarnos de incluir todos los transportistas, incluso si no han enviado pedidos.
SELECT s.ShipperID, s.CompanyName, o.OrderID,o.OrderDate
FROM Shippers AS s
LEFT JOIN Orders AS o
ON s.ShipperID = o.ShipVia;



