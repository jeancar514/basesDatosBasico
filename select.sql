DROP TABLE IF EXISTS ordenes;
DROP TABLE IF EXISTS productos;
DROP TABLE IF EXISTS clientes;

CREATE TABLE clientes(;
	cliente_id SERIAL PRIMARY KEY,
	cliente_nombre VARCHAR(80) NOT NULL
);
 CREATE TABLE productos(;
	 producto_id SERIAL PRIMARY KEY,
	 producto_nombre VARCHAR(80) NOT NULL,
	 producto_precio NUMERIC(6,2) CHECK(producto_precio > 0),
	 producto_stock SMALLINT CHECK(producto_stock >= 0) DEFAULT 0,
	 producto_tipo VARCHAR(80) 
 );
 CREATE TABLE ordenes(
	 orden_id SERIAL PRIMARY KEY,
	 orden_cliente_id INT REFERENCES clientes(cliente_id),
	 orden_producto_id INT REFERENCES productos(producto_id)
 );
 
INSERT INTO clientes (cliente_nombre);
 	VALUES;
		('María'),
		('Carmen'),
		('Josefa'),
		('Antonio'),
		('José'),
		('Manuel'),
		('David'),
		('Daniel');
		
SELECT * FROM clientes;

INSERT INTO productos;
	(producto_nombre,producto_precio,producto_stock,producto_tipo)
	VALUES
		('Latte', 2.50, 100, 'café'),
		('Cappuccino', 1.90, 100, 'café'),
		('Dulce de leche Latte', 20.50, 100, 'café'),
		('Café Americano', 3.50, 100, 'café'),
		('Iced Café Americano', 0.50, 100, 'ice café'),
		('Café Mocha', 50, 100, 'café'),
		('Caramel Macchiato', 3.2, 100, 'café'),
		('Iced Mocha', 2.50, 100, 'ice café'),
		('Mocha Blanco', 2.50, 0, null),
		('Vanilla Latte', 2.50, 100, 'té'),
		('Flat White', 2.50, 100, 'té'),
		('Espresso', 2.50, 100, 'café'),
		('Espresso Macchiato', 0.90, 0, 'café'),
		('Espresso Con Panna', 1.50, 100, 'café'),
		('Café Cortado', 3.50, 100, 'café'),
		('Torta Cuatro Leches', 4.50, 100, 'postre'),
		('Pie de Berries', 5.50, 0, 'postre'),
		('Bagel', 2.50, 100, 'postre'),
		('Donut Rellena', 6.50, 100, 'donut'),
		('Scone de 4 quesos', 7.50, 100, 'sandwich'),
		('Muffin Zanahoria Nuez', 8.50, 100, 'muffin'),
		('Media luna', 9.50, 100, 'donut'),
		('Pan de Queso', 11.50, 100, 'sandwich'),
		('Praline Cake', 12.50, 100, 'sandwich'),
		('Lemon Cake', 22.50, 100, null),
		('Muffin con Chips', 33.50, 100, 'muffin'),
		('Muffin de Arándano', 454.50, 10, 'muffin');

SELECT * FROM productos;


SELECT producto_nombre,producto_precio FROM productos;

-- concatenar con || , AS se renombra la tabla que se trae 
-- """" comillas dobles para nombres de variables con espacios
SELECT 
    producto_nombre || ' el precio es ' || producto_precio
	AS "NOMBRE Y PRECIO",
	producto_stock
FROM productos;

SELECT 
	producto_nombre,
	producto_precio * 100
FROM productos
--acendente
ORDER BY producto_precio ASC;


SELECT 
	producto_nombre,
	producto_precio * 100
FROM productos
-- decendente
ORDER BY producto_precio DESC;

 -- LENGTH NOS DEVUELVE EN NUMERO DE ELEMNETOS DE UNA CADENA;
SELECT 
	producto_nombre,
	LENGTH(producto_nombre) AS len
FROM productos
ORDER BY len DESC;

/*DISTINCT (opens new window): se utiliza en la declaración 
SELECT para eliminar filas duplicadas de un conjunto de resultados.
*/
SELECT 
	DISTINCT producto_tipo
FROM productos;

-------------------------------------------------;
/*;
WHERE: SELECT devuelve todas las filas de una o 
más columnas en una tabla. Para seleccionar filas que satisfagan 
una condición específica, use una WHERE.

Operadores: =, >, <, >=, <=, <>, !=, AND, OR,

IN: Devuelve verdadero si un valor coincide con cualquier valor en una lista.
BETWEEN: Devuelve verdadero si un valor está entre un rango de valores.
LIKE: Devuelve verdadero si un valor coincide con un patrón.
IS NULL: Devuelve verdadero si un valor es NULL.
NOT: Negar el resultado de otros operadores.
*/

SELECT 
	producto_nombre,
	producto_precio,
	producto_tipo,
	producto_stock
	FROM productos
	WHERE producto_tipo = 'café' AND producto_stock > 0;

-- devuelve todos los tipo cafe y te
SELECT 
	producto_nombre,
	producto_precio,
	producto_tipo,
	producto_stock
	FROM productos
	WHERE producto_tipo IN ('café','té')

-- devuelve todos los que no son tipo cafe y te
SELECT 
	producto_nombre,
	producto_precio,
	producto_tipo,
	producto_stock
	FROM productos
	WHERE producto_tipo NOT IN ('café','té')

-- devuelve el primero que conicida por defecto 
--  % devuelve todos los que coincidan;
SELECT 
	producto_nombre,
	producto_precio,
	producto_tipo,
	producto_stock
	FROM productos
	WHERE producto_nombre LIKE 'Espresso%'
 /*
SELECT
	'foo' LIKE 'foo', -- true
	'foo' LIKE 'f%', -- true
	'foo' LIKE '_o_', -- true
	'bar' LIKE 'b_'; -- false
*/
-- dentro de un rango 
SELECT 
	producto_nombre,
	producto_precio 
FROM productos
WHERE producto_precio BETWEEN 1 AND 4;

-- LAS PRIMERAS 3 OPCIONES;
SELECT 
	producto_nombre,
	producto_precio 
FROM productos
WHERE producto_precio BETWEEN 1 AND 4
LIMIT 3;

-- OMITE LAS PRIMERAS 3  Y MANDA LAS TRES SIGUIENTES;
SELECT 
	producto_nombre,
	producto_precio 
FROM productos
WHERE producto_precio BETWEEN 1 AND 4
LIMIT 3 OFFSET 3;

/*
IS NULL(opens new window)
En el mundo de las bases de datos, NULL significa información 
faltante o no aplicable.
NULL no es un valor, por lo tanto, no puede compararlo con 
otros valores como números o cadenas.
La comparación de NULL con un valor siempre dará como resultado NULL, 
lo que significa un resultado desconocido.
Además, NULL no es igual a NULL.
*/

SELECT 
	producto_nombre,
	producto_precio,
	producto_tipo
FROM productos;
WHERE producto_tipo IS NULL;

SELECT 
	producto_nombre,
	producto_precio,
	producto_tipo
FROM productos;
WHERE producto_tipo IS NOT NULL;

--------------------------------------------------------;
/*
GROUP BY (opens new window): Devuelve las filas en grupos.
Para cada grupo, puede aplicar una función agregada, por ejemplo, SUM() 
para calcular la suma de elementos 
o COUNT() para obtener el número de elementos en los grupos.
*/
SELECT 
	producto_tipo,
	COUNT(producto_nombre) AS "cantidad de productos de cada tipo"
FROM productos
GROUP BY producto_tipo;

/*
HAVING(opens new window)
La cláusula WHERE le permite filtrar filas según una condición 
específica. Sin embargo, la cláusula HAVING le permite filtrar grupos 
de filas de acuerdo con una condición específica.
En otras palabras, la cláusula WHERE se aplica a filas mientras que 
la cláusula HAVING se aplica a grupos de filas.
*/

SELECT 
	producto_tipo,
	COUNT(producto_nombre) AS cantidad de productos de cada tipo
FROM productos
GROUP BY producto_tipo
HAVING COUNT(producto_nombre) > 2;
