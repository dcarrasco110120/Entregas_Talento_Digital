-- ========================================================
-- ACTIVIDAD 4: ANÁLISIS DE FINANZAS PERSONALES CON SQL
-- ========================================================

-- Crear la tabla de finanzas personales
DROP TABLE IF EXISTS finanzas_personales;

CREATE TABLE finanzas_personales
(
    nombre character varying(20) COLLATE pg_catalog."default" NOT NULL,
    me_debe integer,
    cuotas_cobrar integer,
    le_debo integer,
    cuotas_pagar integer,
    CONSTRAINT finanzas_personales_pkey PRIMARY KEY (nombre)
);

-- Insertar datos iniciales
insert into finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
values ('tía carmen', 0, 0, 5000, 1);
insert into finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
values ('papá', 0, 0, 15000, 3);
insert into finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
values ('nacho', 10000, 2, 7000, 1);
insert into finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
values ('almacén esquina', 0, 0, 13000, 2);
insert into finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
values ('vicios varios', 0, 0, 35000, 35);
insert into finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
values ('compañero trabajo', 50000, 5, 0, 0);

-- ========================================================
-- PREGUNTA 1: ¿A quién(es) le debe más dinero y cuánto?
-- ========================================================
-- Respuesta: Se debe encontrar el registro con el máximo valor en le_debo
SELECT 
    nombre,
    le_debo as 'Deuda'
FROM finanzas_personales
WHERE le_debo = (SELECT MAX(le_debo) FROM finanzas_personales);

-- ========================================================
-- PREGUNTA 2: ¿Quién(es) le debe más dinero a usted y cuánto?
-- ========================================================
-- Respuesta: Se debe encontrar el registro con el máximo valor en me_debe
SELECT 
    nombre,
    me_debe as 'Lo que le deben'
FROM finanzas_personales
WHERE me_debe = (SELECT MAX(me_debe) FROM finanzas_personales);

-- ========================================================
-- PREGUNTA 3: ¿Cuánto dinero debe en total?
-- ========================================================
-- Respuesta: Suma de todos los valores en la columna le_debo
SELECT 
    SUM(le_debo) as 'Deuda Total'
FROM finanzas_personales;

-- ========================================================
-- PREGUNTA 4: ¿Cuánto dinero debe en promedio?
-- ========================================================
-- Respuesta: Promedio de los valores en la columna le_debo
SELECT 
    AVG(le_debo) as 'Deuda Promedio'
FROM finanzas_personales;

-- ========================================================
-- PREGUNTA 5: ¿Cuántos meses demoraría en saldar su deuda?
-- Suponiendo que no puede pagar más de una cuota al mes
-- ========================================================
-- Respuesta estándar: Suma total de cuotas a pagar
SELECT 
    SUM(cuotas_pagar) as 'Meses para saldar deuda'
FROM finanzas_personales;

-- Respuesta experta: Mostrar años y meses
SELECT 
    (SUM(cuotas_pagar) / 12) as 'Años',
    (SUM(cuotas_pagar) % 12) as 'Meses'
FROM finanzas_personales;

-- ========================================================
-- PREGUNTA 6: Si cobra todo lo que le deben...
-- ¿A cuánto ascendería su nueva deuda reducida?
-- ========================================================
-- Respuesta: Deuda total - Dinero a cobrar
SELECT 
    SUM(le_debo) as 'Deuda Total',
    SUM(me_debe) as 'Dinero a Cobrar',
    (SUM(le_debo) - SUM(me_debe)) as 'Nueva Deuda Reducida'
FROM finanzas_personales;

-- ¿Cuánto tendría que pagar mensualmente para pagar todo en las cuotas acordadas?
-- Se debe sumar todos los le_debo y dividir entre la suma de cuotas_pagar
SELECT 
    SUM(le_debo) as 'Deuda Total',
    SUM(cuotas_pagar) as 'Total Cuotas',
    ROUND(CAST(SUM(le_debo) as FLOAT) / SUM(cuotas_pagar), 2) as 'Valor Cuota Mensual'
FROM finanzas_personales;

-- ========================================================
-- PREGUNTA 7: Insertar un nuevo registro
-- Se olvidó de la pareja: 50000 de deuda en 1 cuota
-- ========================================================
INSERT INTO finanzas_personales (nombre, me_debe, cuotas_cobrar, le_debo, cuotas_pagar)
VALUES ('pareja', 0, 0, 50000, 1);

-- Verificar los datos después del insert
SELECT * FROM finanzas_personales;

-- ========================================================
-- PREGUNTA 8: ¿De cuánto será la cuota a pagar este mes?
-- Después de insertar a la pareja
-- ========================================================
SELECT 
    SUM(le_debo) as 'Deuda Total',
    SUM(cuotas_pagar) as 'Total Cuotas',
    ROUND(CAST(SUM(le_debo) as FLOAT) / SUM(cuotas_pagar), 2) as 'Valor Cuota Mensual'
FROM finanzas_personales;

-- ========================================================
-- PREGUNTA 9: Update - Almacén esquina permite 13 cuotas
-- Cambiar el número de cuotas del almacén esquina de 2 a 13
-- ========================================================
UPDATE finanzas_personales
SET cuotas_pagar = 13
WHERE nombre = 'almacén esquina';

-- Verificar los datos después del update
SELECT * FROM finanzas_personales;

-- ========================================================
-- PREGUNTA 10: ¿De cuánto será la cuota a pagar este mes?
-- Después del update del almacén esquina
-- ========================================================
SELECT 
    SUM(le_debo) as 'Deuda Total',
    SUM(cuotas_pagar) as 'Total Cuotas',
    ROUND(CAST(SUM(le_debo) as FLOAT) / SUM(cuotas_pagar), 2) as 'Valor Cuota Mensual'
FROM finanzas_personales;

-- ========================================================
-- RESUMEN FINAL: Estado de finanzas personales
-- ========================================================
SELECT 
    nombre,
    me_debe as 'Me Deben',
    cuotas_cobrar as 'Cuotas a Cobrar',
    le_debo as 'Le Debo',
    cuotas_pagar as 'Cuotas a Pagar'
FROM finanzas_personales
ORDER BY nombre;
