DROP TABLE IF EXISTS cliente_ordenes_productos;
DROP TABLE IF EXISTS cliente_ordenes;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS productos; --  eliminar tablas

CREATE TABLE clientes (
	cliente_id SERIAL PRIMARY KEY,
	cliente_nombre VARCHAR(50)
);

CREATE TABLE productos (
	producto_id SERIAL PRIMARY KEY,
	producto_nombre VARCHAR(50),
	producto_precio NUMERIC(6,2) CHECK(producto_precio >= 0),
	producto_stock SMALLINT CHECK(producto_stock >= 0) DEFAULT 0,
	producto_tipo VARCHAR(20)
);

CREATE TABLE cliente_ordenes (
	cliente_orden_id SERIAL PRIMARY KEY,
	cliente_id INT REFERENCES clientes(cliente_id),
	orden_fecha DATE DEFAULT NOW()
);

CREATE TABLE cliente_ordenes_productos (
	cliente_orden_id INT REFERENCES cliente_ordenes(cliente_orden_id),
	producto_id INT REFERENCES productos(producto_id),
	cantidad SMALLINT DEFAULT 1
);

INSERT INTO productos 
(producto_nombre, producto_precio, producto_stock, producto_tipo)
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

INSERT INTO clientes (cliente_nombre)
VALUES 
	('María'),
	('Carmen'),
	('Josefa'),
	('Antonio'),
	('José'),
	('Manuel'),
	('David'),
	('Daniel');

SELECT * FROM clientes;
SELECT * FROM productos;

INSERT INTO cliente_ordenes(cliente_id)
VALUES(3);

SELECT * FROM cliente_ordenes;

INSERT INTO cliente_ordenes_productos(cliente_orden_id,producto_id,cantidad)
VALUES(1,12,2);

UPDATE productos
SET producto_stock = producto_stock - 2 
WHERE productos.producto_id = 11;

SELECT * FROM cliente_ordenes_productos;

/*
a unión o join de PostgreSQL se utiliza para combinar columnas de una o más tablas, en función de los valores de las columnas comunes entre tablas relacionadas.
Existen diferentes tipos de join:
INNER JOIN o JOIN
LEFT JOIN
RIGHT JOIN
FULL JOIN o FULL OUTER JOIN
y otros... saquen su autodidacta interior

SELECT 
FROM 
INNER JOIN 
ON 
*/

SELECT *
FROM productos As p
INNER JOIN cliente_ordenes_productos As cop
ON p.producto_id = cop.producto_id;

SELECT p.producto_nombre, cop.cantidad
FROM productos As p
INNER JOIN cliente_ordenes_productos As cop
ON p.producto_id = cop.producto_id;

SELECT p.producto_nombre, cop.cantidad, 
	p.producto_precio * cop.cantidad
FROM productos As p
INNER JOIN cliente_ordenes_productos As cop
ON p.producto_id = cop.producto_id;