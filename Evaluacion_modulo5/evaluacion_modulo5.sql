-- ================================================================
-- EVALUACIÓN FINAL MÓDULO 5 - SQL
-- ================================================================
-- Tablas base: reparto_soltera_otra_vez y reparto_papi_ricky
-- ================================================================


-- ----------------------------------------------------------------
-- SETUP: Creo las tablas con los datos del archivo que nos dieron
-- ----------------------------------------------------------------

DROP TABLE IF EXISTS reparto_soltera_otra_vez;
CREATE TABLE reparto_soltera_otra_vez
(
    nombre character varying(255) NOT NULL,
    temporadas integer,
    protagonico boolean,
    sueldo integer,
    PRIMARY KEY (nombre)
);

insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Paz Bascuñán', 3, true, 100);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Pablo Macaya', 3, true, 100);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Cristián Arriagada', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Josefina Montané', 2, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Loreto Aravena', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Lorena Bosch', 2, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Nicolás Poblete', 2, true, 85);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Héctor Morales', 3, true, 80);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Aranzazú Yankovic', 2, true, 80);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Luis Gnecco', 3, true, 95);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Catalina Guerra', 3, true, 90);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Solange Lackington', 2, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Ignacio Garmendia', 2, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Julio González', 3, true, 75);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Antonella Orsini', 3, true, 70);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Tamara Acosta', 1, false, 60);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Silvia Santelices', 1, false, 55);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Alejandro Trejo', 1, false, 55);
insert into reparto_soltera_otra_vez (nombre, temporadas, protagonico, sueldo) values ('Grimanesa Jiménez', 1, false, 60);

DROP TABLE IF EXISTS reparto_papi_ricky;
CREATE TABLE reparto_papi_ricky
(
    nombre character varying(255) NOT NULL,
    capitulos integer,
    protagonico boolean,
    sueldo integer,
    PRIMARY KEY (nombre)
);

insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Jorge Zabaleta', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Belén Soto', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Tamara Acosta', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('María Elena Swett', 135, true, 100);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Juan Falcón', 135, true, 95);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Silvia Santelices', 135, true, 85);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Leonardo Perucci', 135, true, 85);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Teresita Reyes', 135, true, 80);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Luis Gnecco', 135, true, 75);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Alejandro Trejo', 135, true, 65);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Grimanesa Jiménez', 135, true, 60);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Remigio Remedy', 135, true, 60);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('María Paz Grandjean', 135, true, 55);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Héctor Morales', 135, true, 50);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('César Caillet', 135, true, 40);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('José Tomás Guzmán', 135, true, 25);
insert into reparto_papi_ricky (nombre, capitulos, protagonico, sueldo) values ('Manuel Aguirre', 135, true, 30);


-- ================================================================
-- PARTE 1: JOIN
-- ================================================================

-- ----------------------------------------------------------------
-- CONSULTA 1: Actores que actuaron en AMBAS teleseries
-- con su sueldo en cada una y la suma, ordenado por nombre
-- ----------------------------------------------------------------
-- Usé INNER JOIN porque quiero solo los que aparecen en LAS DOS tablas
-- Si alguien está en una sola tabla, no aparece en el resultado
-- El ORDER BY al final ordena alfabéticamente por nombre
SELECT
    s.nombre,
    s.sueldo AS sueldo_en_soltera,
    p.sueldo AS sueldo_en_papi,
    s.sueldo + p.sueldo AS sueldo_sumado
FROM reparto_soltera_otra_vez s
INNER JOIN reparto_papi_ricky p ON s.nombre = p.nombre
ORDER BY s.nombre;


-- ----------------------------------------------------------------
-- CONSULTA 2: Actores que actuaron SOLO en Soltera Otra Vez
-- con sueldo mayor a 90
-- ----------------------------------------------------------------
-- LEFT JOIN trae todos de soltera + los que coinciden en papi
-- WHERE p.nombre IS NULL filtra solo los que NO están en papi
-- (o sea, exclusivos de soltera)
-- Y además pido que el sueldo en soltera sea mayor a 90
SELECT
    s.nombre,
    s.sueldo
FROM reparto_soltera_otra_vez s
LEFT JOIN reparto_papi_ricky p ON s.nombre = p.nombre
WHERE p.nombre IS NULL
  AND s.sueldo > 90;


-- ----------------------------------------------------------------
-- CONSULTA 3: Actores con sueldo menor a 85 que actuaron en
-- CUALQUIERA de las dos teleseries, PERO NO EN LAS DOS
-- ----------------------------------------------------------------
-- Esto se llama diferencia simétrica: actores exclusivos de cada tabla
-- Uso UNION para juntar dos consultas:
-- Primero los que están solo en soltera con sueldo < 85
-- Luego los que están solo en papi con sueldo < 85
SELECT nombre, sueldo
FROM reparto_soltera_otra_vez
WHERE sueldo < 85
  AND nombre NOT IN (SELECT nombre FROM reparto_papi_ricky)

UNION

SELECT nombre, sueldo
FROM reparto_papi_ricky
WHERE sueldo < 85
  AND nombre NOT IN (SELECT nombre FROM reparto_soltera_otra_vez)

ORDER BY nombre;


-- ================================================================
-- PARTE 2: MODELO ENTIDAD RELACIÓN
-- ================================================================
-- El diagrama tiene 3 tablas: actores, reparto_actores, teleseries
-- actores <-- reparto_actores --> teleseries
-- reparto_actores es la tabla intermedia que conecta actores con teleseries
-- (una relación muchos a muchos: un actor puede estar en muchas teleseries
--  y una teleserie puede tener muchos actores)
-- ----------------------------------------------------------------

-- Primero borro las tablas en el orden correcto
-- (primero la del medio porque depende de las otras dos)
DROP TABLE IF EXISTS reparto_actores;
DROP TABLE IF EXISTS actores;
DROP TABLE IF EXISTS teleseries;

-- Tabla actores: guarda la info de cada actor
CREATE TABLE actores (
    id_actor  SERIAL PRIMARY KEY,  -- SERIAL genera el id automáticamente
    nombre    VARCHAR(255) NOT NULL
);

-- Tabla teleseries: guarda la info de cada teleserie
CREATE TABLE teleseries (
    id_teleserie SERIAL PRIMARY KEY,
    titulo       VARCHAR(255) NOT NULL
);

-- Tabla reparto_actores: conecta actores con teleseries
-- Aquí también guardo el sueldo y si el rol es protagonico o no
-- Las dos llaves foráneas apuntan a actores y teleseries
CREATE TABLE reparto_actores (
    id_reparto   SERIAL PRIMARY KEY,
    id_actor     INT NOT NULL,
    id_teleserie INT NOT NULL,
    sueldo       INT,
    protagonico  BOOLEAN,
    CONSTRAINT fk_actor
        FOREIGN KEY (id_actor) REFERENCES actores(id_actor)
        ON DELETE CASCADE,
    CONSTRAINT fk_teleserie
        FOREIGN KEY (id_teleserie) REFERENCES teleseries(id_teleserie)
        ON DELETE CASCADE
);

-- ----------------------------------------------------------------
-- Inserto las dos teleseries
-- ----------------------------------------------------------------
INSERT INTO teleseries (titulo) VALUES ('Soltera Otra Vez');
INSERT INTO teleseries (titulo) VALUES ('Papi Ricky');

-- ----------------------------------------------------------------
-- Inserto todos los actores (sin repetir nombres)
-- Uno por uno para que queden con id único
-- ----------------------------------------------------------------
INSERT INTO actores (nombre) VALUES ('Paz Bascuñán');
INSERT INTO actores (nombre) VALUES ('Pablo Macaya');
INSERT INTO actores (nombre) VALUES ('Cristián Arriagada');
INSERT INTO actores (nombre) VALUES ('Josefina Montané');
INSERT INTO actores (nombre) VALUES ('Loreto Aravena');
INSERT INTO actores (nombre) VALUES ('Lorena Bosch');
INSERT INTO actores (nombre) VALUES ('Nicolás Poblete');
INSERT INTO actores (nombre) VALUES ('Héctor Morales');
INSERT INTO actores (nombre) VALUES ('Aranzazú Yankovic');
INSERT INTO actores (nombre) VALUES ('Luis Gnecco');
INSERT INTO actores (nombre) VALUES ('Catalina Guerra');
INSERT INTO actores (nombre) VALUES ('Solange Lackington');
INSERT INTO actores (nombre) VALUES ('Ignacio Garmendia');
INSERT INTO actores (nombre) VALUES ('Julio González');
INSERT INTO actores (nombre) VALUES ('Antonella Orsini');
INSERT INTO actores (nombre) VALUES ('Tamara Acosta');
INSERT INTO actores (nombre) VALUES ('Silvia Santelices');
INSERT INTO actores (nombre) VALUES ('Alejandro Trejo');
INSERT INTO actores (nombre) VALUES ('Grimanesa Jiménez');
INSERT INTO actores (nombre) VALUES ('Jorge Zabaleta');
INSERT INTO actores (nombre) VALUES ('Belén Soto');
INSERT INTO actores (nombre) VALUES ('María Elena Swett');
INSERT INTO actores (nombre) VALUES ('Juan Falcón');
INSERT INTO actores (nombre) VALUES ('Leonardo Perucci');
INSERT INTO actores (nombre) VALUES ('Teresita Reyes');
INSERT INTO actores (nombre) VALUES ('Remigio Remedy');
INSERT INTO actores (nombre) VALUES ('María Paz Grandjean');
INSERT INTO actores (nombre) VALUES ('César Caillet');
INSERT INTO actores (nombre) VALUES ('José Tomás Guzmán');
INSERT INTO actores (nombre) VALUES ('Manuel Aguirre');

-- ----------------------------------------------------------------
-- Inserto el reparto de Soltera Otra Vez (id_teleserie = 1)
-- ----------------------------------------------------------------
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 100, true FROM actores WHERE nombre = 'Paz Bascuñán';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 100, true FROM actores WHERE nombre = 'Pablo Macaya';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 95, true FROM actores WHERE nombre = 'Cristián Arriagada';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 90, true FROM actores WHERE nombre = 'Josefina Montané';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 95, true FROM actores WHERE nombre = 'Loreto Aravena';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 90, true FROM actores WHERE nombre = 'Lorena Bosch';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 85, true FROM actores WHERE nombre = 'Nicolás Poblete';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 80, true FROM actores WHERE nombre = 'Héctor Morales';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 80, true FROM actores WHERE nombre = 'Aranzazú Yankovic';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 95, true FROM actores WHERE nombre = 'Luis Gnecco';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 90, true FROM actores WHERE nombre = 'Catalina Guerra';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 70, true FROM actores WHERE nombre = 'Solange Lackington';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 70, true FROM actores WHERE nombre = 'Ignacio Garmendia';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 75, true FROM actores WHERE nombre = 'Julio González';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 70, true FROM actores WHERE nombre = 'Antonella Orsini';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 60, false FROM actores WHERE nombre = 'Tamara Acosta';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 55, false FROM actores WHERE nombre = 'Silvia Santelices';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 55, false FROM actores WHERE nombre = 'Alejandro Trejo';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 1, 60, false FROM actores WHERE nombre = 'Grimanesa Jiménez';

-- ----------------------------------------------------------------
-- Inserto el reparto de Papi Ricky (id_teleserie = 2)
-- ----------------------------------------------------------------
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 100, true FROM actores WHERE nombre = 'Jorge Zabaleta';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 100, true FROM actores WHERE nombre = 'Belén Soto';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 100, true FROM actores WHERE nombre = 'Tamara Acosta';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 100, true FROM actores WHERE nombre = 'María Elena Swett';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 95, true FROM actores WHERE nombre = 'Juan Falcón';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 85, true FROM actores WHERE nombre = 'Silvia Santelices';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 85, true FROM actores WHERE nombre = 'Leonardo Perucci';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 80, true FROM actores WHERE nombre = 'Teresita Reyes';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 75, true FROM actores WHERE nombre = 'Luis Gnecco';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 65, true FROM actores WHERE nombre = 'Alejandro Trejo';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 60, true FROM actores WHERE nombre = 'Grimanesa Jiménez';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 60, true FROM actores WHERE nombre = 'Remigio Remedy';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 55, true FROM actores WHERE nombre = 'María Paz Grandjean';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 50, true FROM actores WHERE nombre = 'Héctor Morales';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 40, true FROM actores WHERE nombre = 'César Caillet';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 25, true FROM actores WHERE nombre = 'José Tomás Guzmán';
INSERT INTO reparto_actores (id_actor, id_teleserie, sueldo, protagonico)
SELECT id_actor, 2, 30, true FROM actores WHERE nombre = 'Manuel Aguirre';


-- ----------------------------------------------------------------
-- CONSULTA PARTE 2.3: Todas las teleseries con sus actores de reparto
-- NO incluye actores de rol secundario (protagonico = false)
-- ----------------------------------------------------------------
-- JOIN entre las 3 tablas para conectar todo
-- WHERE protagonico = true filtra solo los protagonistas
SELECT
    t.titulo AS teleserie,
    a.nombre AS actor
FROM teleseries t
JOIN reparto_actores r ON t.id_teleserie = r.id_teleserie
JOIN actores a ON r.id_actor = a.id_actor
WHERE r.protagonico = true
ORDER BY t.titulo, a.nombre;
