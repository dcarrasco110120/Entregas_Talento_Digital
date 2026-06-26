-- ========================================================
-- EJERCICIO PRÁCTICO: SQL LLAVES
-- ========================================================

-- --------------------------------------------------------
-- PASO 1: CREAR LAS TABLAS CON LLAVES Y RESTRICCIONES
-- --------------------------------------------------------

-- Tabla 1: Clientes
-- PRIMARY KEY: identifica de forma única a cada cliente
-- CHECK: la edad debe estar entre 18 y 85
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY,
    nombre     VARCHAR(100) NOT NULL,
    edad       INT CHECK (edad BETWEEN 18 AND 85) NOT NULL
);

-- Tabla 2: Cuentas
-- PRIMARY KEY: identifica de forma única a cada cuenta
-- FOREIGN KEY: id_cliente debe existir en la tabla Clientes
-- CHECK: el saldo debe estar entre -5000 y 100000
-- ON DELETE CASCADE: si se borra un cliente, sus cuentas se borran automáticamente
-- ON UPDATE CASCADE: si cambia el id_cliente, se actualiza en Cuentas también
CREATE TABLE Cuentas (
    id_cuenta  INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    saldo      NUMERIC(10, 2) CHECK (saldo BETWEEN -5000.00 AND 100000.00) NOT NULL,
    CONSTRAINT fk_cliente
        FOREIGN KEY (id_cliente)
        REFERENCES Clientes(id_cliente)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);

-- Secuencias para autogenerar IDs (útil en PostgreSQL)
CREATE SEQUENCE seq_cliente_id START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE seq_cuenta_id  START WITH 1 INCREMENT BY 1;


-- --------------------------------------------------------
-- PASO 2: INSERTAR 5 CLIENTES (edades entre 18 y 85)
-- --------------------------------------------------------

INSERT INTO Clientes (id_cliente, nombre, edad) VALUES (1, 'Ana García',    78);
INSERT INTO Clientes (id_cliente, nombre, edad) VALUES (2, 'Luis Pérez',    25);
INSERT INTO Clientes (id_cliente, nombre, edad) VALUES (3, 'Maria Soto',    40);
INSERT INTO Clientes (id_cliente, nombre, edad) VALUES (4, 'Carlos Ruiz',   80); -- Cliente con más edad
INSERT INTO Clientes (id_cliente, nombre, edad) VALUES (5, 'Elena Torres',  32);


-- --------------------------------------------------------
-- PASO 2: INSERTAR 15 CUENTAS (saldos entre -5000 y 100000)
-- --------------------------------------------------------

-- Cuentas para Cliente 1 (Ana García): 3 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (101, 1,  50000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (102, 1,  -1200.50); -- Saldo negativo
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (103, 1,    100.00);

-- Cuentas para Cliente 2 (Luis Pérez): 2 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (201, 2,    850.75);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (202, 2,   -500.00); -- Saldo negativo

-- Cuentas para Cliente 3 (Maria Soto): 4 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (301, 3,  15000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (302, 3,    200.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (303, 3,  -4999.99); -- Saldo negativo
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (304, 3,  75000.00);

-- Cuentas para Cliente 4 (Carlos Ruiz - mayor edad): 3 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (401, 4,   1000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (402, 4,   2000.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (403, 4,   3000.00);

-- Cuentas para Cliente 5 (Elena Torres): 3 cuentas
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (501, 5,     50.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (502, 5,    120.00);
INSERT INTO Cuentas (id_cuenta, id_cliente, saldo) VALUES (503, 5,    900.00);


-- --------------------------------------------------------
-- PASO 3: DML - UPDATE Y DELETE
-- --------------------------------------------------------

-- UPDATE: Aumentar el saldo de la cuenta 402 (Carlos) en 500.00
-- Antes: 2000.00 → Después: 2500.00
UPDATE Cuentas
SET saldo = saldo + 500.00
WHERE id_cuenta = 402;

-- DELETE: Borrar la cuenta 503 (Elena Torres con saldo 900.00)
DELETE FROM Cuentas
WHERE id_cuenta = 503;


-- --------------------------------------------------------
-- Q3: Listar el saldo de cada cuenta del cliente con más años de edad
-- El cliente de mayor edad es Carlos Ruiz (80 años, id_cliente = 4)
-- Usamos una subconsulta para encontrar la edad máxima
-- --------------------------------------------------------
SELECT
    c.nombre,
    cu.id_cuenta,
    cu.saldo
FROM Clientes c
JOIN Cuentas cu ON c.id_cliente = cu.id_cliente
WHERE c.edad = (SELECT MAX(edad) FROM Clientes);


-- --------------------------------------------------------
-- Q4: Listar el promedio de edad de los clientes con saldo negativo
-- Un cliente tiene saldo negativo si al menos una de sus cuentas tiene saldo < 0
-- --------------------------------------------------------
SELECT
    AVG(c.edad) AS promedio_edad
FROM Clientes c
WHERE c.id_cliente IN (
    -- Subconsulta: obtengo los id_cliente que tienen al menos una cuenta con saldo negativo
    SELECT DISTINCT id_cliente
    FROM Cuentas
    WHERE saldo < 0
);


-- --------------------------------------------------------
-- Q5: Listar el nombre y cantidad de cuentas de quienes tienen más de una
-- COUNT() cuenta las cuentas por cliente
-- HAVING filtra los grupos con más de 1 cuenta (no se puede usar WHERE con COUNT)
-- --------------------------------------------------------
SELECT
    c.nombre,
    COUNT(cu.id_cuenta) AS cantidad_cuentas
FROM Clientes c
JOIN Cuentas cu ON c.id_cliente = cu.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(cu.id_cuenta) > 1;


-- --------------------------------------------------------
-- Q6: Listar el saldo combinado (suma) de cada cliente con más de una cuenta
-- SUM() suma todos los saldos del cliente
-- HAVING filtra solo los que tienen más de 1 cuenta
-- --------------------------------------------------------
SELECT
    c.nombre,
    SUM(cu.saldo) AS saldo_combinado
FROM Clientes c
JOIN Cuentas cu ON c.id_cliente = cu.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING COUNT(cu.id_cuenta) > 1;


-- --------------------------------------------------------
-- Q7: Listar todos los clientes y su saldo combinado
-- Solo de aquellos que tengan AL MENOS UNA cuenta con saldo negativo
-- --------------------------------------------------------
SELECT
    c.nombre,
    SUM(cu.saldo) AS saldo_combinado
FROM Clientes c
JOIN Cuentas cu ON c.id_cliente = cu.id_cliente
GROUP BY c.id_cliente, c.nombre
HAVING c.id_cliente IN (
    -- Subconsulta: clientes que tienen al menos una cuenta con saldo negativo
    SELECT DISTINCT id_cliente
    FROM Cuentas
    WHERE saldo < 0
);
