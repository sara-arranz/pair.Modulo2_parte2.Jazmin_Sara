USE northwind;

-- Productos más baratos y caros de nuestra la bases de datos: Desde la división de productos nos piden conocer el precio de los productos 
-- que tienen el precio más alto y más bajo. Dales el alias lowestPrice y highestPrice.

SELECT MIN(UnitPrice) AS lowesPrice, MAX(UnitPrice) AS highestPrice
	FROM Products;

-- Conociendo el numero de productos y su precio medio: Adicionalmente nos piden que diseñemos otra consulta para conocer el número de productos 
-- y el precio medio de todos ellos (en general, no por cada producto).

SELECT COUNT(*), ROUND(AVG (UnitPrice),2)
	FROM Products;

-- Sacad la máxima y mínima carga de los pedidos de UK: Nuestro siguiente encargo consiste en preparar una consulta que devuelva la máxima y mínima cantidad de carga 
-- para un pedido (freight) enviado a Reino Unido (United Kingdom).

SELECT MIN(Freight) AS min_cantidad, MAX(Freight) AS max_cantidad
	FROM Orders
    WHERE ShipCountry IN ('UK');

-- Qué productos se venden por encima del precio medio:

-- Después de analizar los resultados de alguna de nuestras consultas anteriores, desde el departamento de Ventas quieren conocer qué productos en concreto se venden 
-- por encima del precio medio para todos los productos de la empresa, ya que sospechan que dicho número es demasiado elevado. 
-- También quieren que ordenemos los resultados por su precio de mayor a menor.

SELECT ROUND(AVG(UnitPrice),2)
	FROM Products;
-- PRECIO MEDIO = 28,87
SELECT ProductName, UnitPrice 
FROM Products
WHERE UnitPrice > 28.87
ORDER BY UnitPrice DESC;

-- Qué productos se han descontinuado: De cara a estudiar el histórico de la empresa nos piden una consulta para conocer el número de productos que se han descontinuado. 
-- El atributo Discontinued es un booleano: si es igual a 1 el producto ha sido descontinuado.

SELECT COUNT(ProductName)
	FROM Products
    WHERE Discontinued = 1;

-- SOLUCIÓN = 8 productos

-- Detalles de los productos de la query anterior: Adicionalmente nos pedir detalles de aquellos productos no descontinuados, sobre todo el ProductID y ProductName. Como puede salir de sí demasiados resultados, 
-- nos piden que el límite sea a los 10 con ID más elevado, que van a ser los últimos más. No nos pueden decir del departamento si han tenido pocos resultados, pero lo limitamos por si acaso.

SELECT ProductID, ProductName
	FROM Products
    WHERE Discontinued = 0
	ORDER BY ProductID DESC
    LIMIT 10;

-- Relación entre número de pedidos y carga máxima: Desde Internet nos llamó el número de pedidos y la cantidad máxima de carga de entre los mismos (freight) 
-- que han sido enviados por cada empleado (mostrando el ID de empleado en cada caso).

SELECT COUNT(OrderID)
	FROM Orders;
-- 830 pedidos

SELECT MAX(Freight)
	FROM Orders;
-- 1007.64

SELECT EmployeeID, 
       COUNT(OrderID) AS TotalPedidos, 
       ROUND(MAX(Freight),2) AS CargaMaxima
FROM Orders
GROUP BY EmployeeID;

-- Descartar pedidos sin fecha y ordénalos: Una vez han revisado los datos de la consulta anterior, nos han pedido afinar un poco más el "disparo". 
-- En el resultado anterior se han incluido muchos pedidos cuya fecha de envío estaba vacía, por lo que tenemos que mejorar la consulta en este aspecto. 
-- También nos piden que ordenemos los resultados según el ID de empleado para que la visualización sea más sencilla.

SELECT EmployeeID, 
       COUNT(OrderID) AS TotalPedidos, 
       ROUND(MAX(Freight),2) AS CargaMaxima
	FROM Orders
    WHERE ShippedDate IS NOT NULL
	GROUP BY EmployeeID
    ORDER BY EmployeeID ASC;
    

-- BONUS: 

-- Números de pedidos por día: El siguiente paso en el análisis de los pedidos va a consistir en conocer mejor la distribución de los mismos según las fechas. 
-- Por lo tanto, tendremos que generar una consulta que nos saque el número de pedidos para cada día, mostrando de manera separada el día (DAY()), el mes (MONTH()) y el año (YEAR()).

SELECT YEAR(OrderDate) AS Año, 
       MONTH(OrderDate) AS Mes, 
       DAY(OrderDate) AS Día, 
       COUNT(OrderID) AS TotalPedidos
	FROM Orders
	GROUP BY Año, Mes, Día;

-- Número de pedidos por mes y año: La consulta anterior nos muestra el número de pedidos para cada día concreto, pero esto es demasiado detalle. 
-- Genera una modificación de la consulta anterior para que agrupe los pedidos por cada mes concreto de cada año.

SELECT YEAR(OrderDate) AS Año, 
       MONTH(OrderDate) AS Mes, 
       COUNT(OrderID) AS TotalPedidos
	FROM Orders
	GROUP BY Año, Mes;
		
-- Seleccionad las ciudades con 4 o más empleadas: Desde recursos humanos nos piden seleccionar los nombres de las ciudades 
-- con 4 o más empleadas de cara a estudiar la apertura de nuevas oficinas.

SELECT City, COUNT(EmployeeID) AS NumEmpleadas
	FROM Employees
    GROUP BY city
		HAVING COUNT(EmployeeID) >= 4;

-- Cread una nueva columna basándonos en la cantidad monetaria: Necesitamos una consulta que clasifique los pedidos en dos categorías ("Alto" y "Bajo") 
-- en función de la cantidad monetaria total que han supuesto: por encima o por debajo de 2000 euros.

SELECT Freight, 
       CASE 
           WHEN Freight <= 50 THEN 'Bajo'
           ELSE 'Alto'
       END AS Categoria
FROM Orders;


