-- tablas fuertes con su propia pk independiente 

CREATE TABLE genero (
id_genero VARCHAR2(3) CONSTRAINT genero_pk PRIMARY KEY,
descripcion_genero VARCHAR2(25)
);


CREATE TABLE titulo (
id_titulo VARCHAR2(3) CONSTRAINT titulo_pk PRIMARY KEY,
descripcion_titulo VARCHAR2(60)
);


CREATE TABLE idioma (
id_idioma NUMBER(3) GENERATED ALWAYS AS IDENTITY (START WITH 25 INCREMENT BY 3),
nombre_idioma VARCHAR2(30),
CONSTRAINT idioma_pk PRIMARY KEY (id_idioma)

);

CREATE TABLE estado_civil(
id_estado_civil VARCHAR2(2) CONSTRAINT estado_civil_pk PRIMARY KEY, 
descripcion_est_civil VARCHAR2(25)
);


CREATE TABLE region (
id_region NUMBER(2) GENERATED ALWAYS AS IDENTITY (START WITH 7 INCREMENT BY 2), 
nombre_region VARCHAR2(25),
CONSTRAINT region_pk PRIMARY KEY (id_region)
);

CREATE TABLE comuna (
id_comuna NUMBER(5)CONSTRAINT comuna_pk PRIMARY KEY,
comuna_nombre VARCHAR2(25),
cod_region NUMBER(2),
CONSTRAINT comuna_fk_region FOREIGN KEY (cod_region) REFERENCES region (id_region)
-- se debe crear el cod_region antes de asignarlo como fk 
);

CREATE TABLE compania(
id_empresa NUMBER(2) CONSTRAINT compania_pk PRIMARY KEY,
nombre_empresa VARCHAR2(25) UNIQUE,  
calle VARCHAR2(50),
numeracion NUMBER(5),
renta_promedio NUMBER(10),
pct_aumento NUMBER(4,3),
cod_comuna NUMBER(5),
cod_region NUMBER(2),
CONSTRAINT compania_fk_comuna FOREIGN KEY (cod_comuna) REFERENCES comuna (id_comuna),
CONSTRAINT compania_fk_region FOREIGN KEY (cod_region) REFERENCES region (id_region)
);


CREATE TABLE personal(
rut_persona NUMBER(8)CONSTRAINT personal_pk PRIMARY KEY,
dv_persona CHAR(1),
primer_nombre VARCHAR2(25),
segundo_nombre VARCHAR2(25),
primer_apellido VARCHAR2(25),
segundo_apellido VARCHAR2(25),
fecha_contratacion DATE,
fecha_nacimiento DATE,
email VARCHAR2(100),
calle VARCHAR2(50),
numeracion NUMBER(5),
sueldo NUMBER(5),
cod_comuna NUMBER (5),
cod_region NUMBER(2),
cod_genero VARCHAR2(3),
cod_estado_civil VARCHAR2(2),
cod_empresa NUMBER(2),
encargado_rut NUMBER(8),
CONSTRAINT personal_fk_compania FOREIGN KEY (cod_empresa) REFERENCES compania (id_empresa),
CONSTRAINT personal_fk_comuna FOREIGN KEY (cod_comuna) REFERENCES comuna(id_comuna),
CONSTRAINT personal_fk_estado_civil FOREIGN KEY (cod_estado_civil) REFERENCES estado_civil (id_estado_civil),
CONSTRAINT personal_fk_genero FOREIGN KEY (cod_genero) REFERENCES genero (id_genero), 
CONSTRAINT personal_fk_personal FOREIGN KEY (encargado_rut) REFERENCES personal (rut_persona)
);



CREATE TABLE titulacion (
cod_titulo VARCHAR2(3),
persona_rut NUMBER (8),
fecha_titulacion DATE,
CONSTRAINT titulacion_pk PRIMARY KEY (cod_titulo, persona_rut),
CONSTRAINT titulacion_fk_personal FOREIGN KEY (persona_rut) REFERENCES personal (rut_persona), 
CONSTRAINT titulacion_fk_titulo FOREIGN KEY (cod_titulo) REFERENCES titulo (id_titulo)
);


CREATE TABLE dominio (
id_idioma NUMBER(3),
persona_rut NUMBER (8),
nivel VARCHAR2 (25),
CONSTRAINT dominio_pk PRIMARY KEY (id_idioma, persona_rut),
CONSTRAINT dominio_fk_idioma FOREIGN KEY (id_idioma) REFERENCES idioma (id_idioma),
CONSTRAINT dominio_fk_personal FOREIGN KEY (persona_rut)REFERENCES personal (rut_persona)
);


-- ALTERACIONES A LAS TABLAS CREADAS 

select * from personal;

ALTER TABLE personal 
ADD CONSTRAINT email_unique UNIQUE (email);

ALTER TABLE personal 
ADD CONSTRAINT dv_check
CHECK ((dv_persona BETWEEN '0' and '9') OR dv_persona = 'K');

ALTER TABLE personal 
ADD CONSTRAINT sueldo_check
CHECK (sueldo>=450000);

ALTER TABLE compania 
MODIFY (id_empresa NOT NULL);


ALTER TABLE compania
MODIFY(
nombre_empresa NOT NULL, 
calle NOT NULL, 
numeracion NOT NULL, 
renta_promedio NOT NULL, 
cod_comuna NOT NULL, 
cod_region NOT NULL);

ALTER TABLE region MODIFY (
nombre_region NOT NULL
);

ALTER TABLE personal MODIFY (
dv_persona NOT NULL, 
primer_nombre NOT NULL,
primer_apellido NOT NULL,
segundo_apellido NOT NULL, 
fecha_contratacion NOT NULL, 
fecha_nacimiento NOT NULL, 
calle NOT NULL,
numeracion NOT NULL, 
sueldo NOT NULL, 
cod_comuna NOT NULL, 
cod_region NOT NULL,
cod_empresa NOT NULL
);

ALTER TABLE genero MODIFY(
descripcion_genero NOT NULL
);

ALTER TABLE titulacion MODIFY (
fecha_titulacion NOT NULL
);

ALTER TABLE titulo MODIFY (
descripcion_titulo NOT NULL
);

ALTER TABLE idioma MODIFY (
nombre_idioma NOT NULL
);

ALTER TABLE dominio MODIFY (
nivel NOT NULL
);

ALTER TABLE estado_civil MODIFY (
descripcion_est_civil NOT NULL
);




-- CREAR OBJETO SECUENCIA 

CREATE SEQUENCE seq_id_comuna_3
START WITH 1101
INCREMENT BY 6
; 

DROP SEQUENCE seq_id_comuna_2;


CREATE SEQUENCE seq_id_empresa
START WITH 10
INCREMENT BY 5;


-- POBLAR TABLAS USANDO DML

INSERT INTO idioma (nombre_idioma) VALUES ('INGLES'); 
INSERT INTO idioma (nombre_idioma) VALUES ('CHINO'); 
INSERT INTO idioma (nombre_idioma) VALUES ('ALEMAN'); 
INSERT INTO idioma (nombre_idioma) VALUES ('ESPAÑOL'); 
INSERT INTO idioma (nombre_idioma) VALUES ('FRANCES'); 


INSERT INTO region (nombre_region) VALUES ('ARICA Y PARINACOTA');
INSERT INTO region (nombre_region) VALUES ('METROPOLITANA');
INSERT INTO region (nombre_region) VALUES ('lA ARAUCANIA');

INSERT INTO comuna (id_comuna, comuna_nombre, cod_region) VALUES(seq_id_comuna_3.nextval,'ARICA', 7);
INSERT INTO comuna (id_comuna, comuna_nombre, cod_region) VALUES(seq_id_comuna_3.nextval, 'SANTIAGO', 9);
INSERT INTO comuna (id_comuna, comuna_nombre, cod_region) VALUES(seq_id_comuna_3.nextval,'TEMUCO', 11);

select * from COMPANIA;

INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'CCyRojas', 'Amapolas', 506, 1857000, 0.5 , 1101, 7); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'SenTTy', 'Los Alamos', 3490, 897000, 0.025 , 1101, 7); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'Praxia LTDA', 'Las Camelias', 11098, 2157000, 0.035 , 1107, 9); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'TIC spa', 'FLORES S.A', 4357, 857000, NULL , 1107, 9); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'SANTANA LTDA', 'AVDA VIC. MACKENNA', 106, 757000, 0.015 , 1101, 7); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'FLORES Y ASOCIADOS', 'PEDRO LATORRE', 557, 589000, 0.015 , 1107, 9); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'J. A. HOFFMAN', 'LATINA D.32', 509, 1857000, 0.025 , 1113, 11); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'CAGLIARI D.', 'ALAMEDA', 206, 1857000, NULL , 1107, 9); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'Rojas HNOS LTDA', 'SUCRE', 106, 957000, 0.005 , 1113, 11); 
INSERT INTO compania (ID_EMPRESA, NOMBRE_EMPRESA, CALLE, NUMERACION, RENTA_PROMEDIO, PCT_AUMENTO, COD_COMUNA,COD_REGION ) VALUES (seq_id_empresa.nextval, 'FRIENDS P. S.A', 'SUECIA', 506, 857000, 0.015 , 1113, 11); 


-- seleccionar datos para realizar informes 


-- INFORME 1 

SELECT 
nombre_empresa AS "Nombre Empresa",
calle || ' #' || numeracion  AS "Dirección",
renta_promedio AS "Renta Promedio",
renta_promedio + (renta_promedio * pct_aumento) AS "Simulación de renta"
FROM compania;

-- INFORME 2

SELECT 
id_empresa AS "CODIGO", 
nombre_empresa AS "EMPRESA",
renta_promedio AS "PROM RENTA ACTUAL",
pct_aumento + 0.15 AS "PCT AUMENTADO EN 15%",
renta_promedio * (pct_aumento + 0.15) AS "RENTA AUMENTADA"
FROM compania;
