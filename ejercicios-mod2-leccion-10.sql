-- EJERCICIOS PAIR 

USE northwind;

-- 1. Ciudades que empiezan con "A" o "B".

SELECT City AS Ciudad, CompanyName AS Nombre_Compañia, ContactName AS Nombre_Contacto
FROM customers  
WHERE City LIKE 'A%' OR City LIKE 'B%';

-- 2. Número de pedidos que han hecho en las ciudades que empiezan con L.

SELECT c.City AS Ciudad, c.CompanyName AS Empresa, c.ContactName AS Persona_Contacto, COUNT(o.OrderID) AS Numero_Pedidos
FROM customers AS c
INNER JOIN orders AS o
ON c.CustomerID = o.CustomerID
WHERE City LIKE 'L%'
GROUP BY c.CompanyName
HAVING COUNT(o.OrderID);

-- 3. Todos los clientes cuyo "ContactTitle" no incluya "Sales".

SELECT ContactName AS Nombre_Contacto, ContactTitle AS Cargo, CompanyName AS Nombre_Compañia 
FROM customers
WHERE ContactTitle NOT LIKE 'Sales_%';

-- 4. Todos los clientes que no tengan una "A" en segunda posición en su nombre.

SELECT ContactName AS Nombre_Contacto
FROM customers
WHERE ContactName NOT LIKE '_A%';

-- 5. Extraer toda la información sobre las compañías que tengamos en la bases de datos.

SELECT CompanyName, City, ContactName, 'customers' AS RelationShip
FROM customers 
UNION
SELECT CompanyName, City, ContactName, 'suppliers' 
FROM suppliers;

-- 6. Extraer todas las categorías de la tabla categories que contengan en la descripción "sweet" o "Sweet".

SELECT  CategoryName, Description 
FROM categories
WHERE Description REGEXP 'sweet' ; 

SELECT  CategoryName, `Description`
FROM categories
WHERE `Description` REGEXP 'sweet' OR `Description` REGEXP 'Sweet'; 

SELECT  CategoryName, `Description`
FROM categories
WHERE `Description` REGEXP 'sweet';

-- 7. Extraed todos los nombres y apellidos de los clientes y empleados que tenemos en la bases de datos: ¿Ambas tablas tienen las mismas columnas para nombre y apellido? Tendremos que combinar dos columnas usando concat para unir dos columnas.

SELECT ContactName AS Nombre_Completo, 'customers' AS RelationShip
FROM customers 
UNION
SELECT concat(FirstName, " ", LastName) AS Nombre_Completo, 'employees' AS RelationShip
FROM employees;









