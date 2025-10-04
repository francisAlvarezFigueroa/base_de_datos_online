
-- CASO  1: IMPLEMENTACION DEL MODELO --------------------------------------------------------------------------------------------------------------
CREATE TABLE administrativo 
    ( 
     id_empleado NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE administrativo 
    ADD CONSTRAINT administrativo_pk PRIMARY KEY ( id_empleado ) ;

CREATE TABLE afp 
    ( 
     id_afp  NUMBER (5) GENERATED ALWAYS AS IDENTITY 
     START WITH 210 
     MINVALUE 210
     NOMAXVALUE
     INCREMENT BY 6 
     NOT NULL, 
     nom_afp VARCHAR2 (255)  NOT NULL 
    ) 
;

ALTER TABLE afp 
    ADD CONSTRAINT afp_pk PRIMARY KEY ( id_afp ) ;

CREATE TABLE categoria 
    ( 
     id_categoria     NUMBER (3)  NOT NULL , 
     nombre_categoria VARCHAR2 (255)  NOT NULL 
    ) 
;

ALTER TABLE categoria 
    ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria ) ;

CREATE TABLE comuna 
    ( 
     id_comuna  NUMBER (4)  NOT NULL , 
     nom_comuna VARCHAR2 (100)  NOT NULL , 
     cod_region NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE comuna 
    ADD CONSTRAINT comuna_pk PRIMARY KEY ( id_comuna ) ;

CREATE TABLE detalle_venta 
    ( 
     cod_venta    NUMBER (4)  NOT NULL , 
     cod_producto NUMBER (4)  NOT NULL , 
     cantidad     NUMBER (6)  NOT NULL 
    ) 
;

ALTER TABLE detalle_venta 
    ADD CONSTRAINT detalle_venta_pk PRIMARY KEY ( cod_venta, cod_producto ) ;

CREATE TABLE empleado 
    ( 
     id_empleado        NUMBER (4)  NOT NULL , 
     rut_empleado       VARCHAR2 (10)  NOT NULL , 
     nombre_empleado    VARCHAR2 (25)  NOT NULL , 
     apellido_paterno   VARCHAR2 (25)  NOT NULL , 
     apellido_materno   VARCHAR2 (25)  NOT NULL , 
     fecha_contratacion DATE  NOT NULL , 
     sueldo_base        NUMBER (10)  NOT NULL , 
     bono_jefatura      NUMBER (10) , 
     activo             CHAR (1)  NOT NULL , 
     tipo_empleado      VARCHAR2 (25)  NOT NULL , 
     cod_empleado       NUMBER (4) , 
     cod_salud          NUMBER (4)  NOT NULL , 
     cod_afp            NUMBER (5)  NOT NULL 
    ) 
;

ALTER TABLE empleado 
    ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado ) ;

CREATE TABLE marca 
    ( 
     id_marca     NUMBER (3)  NOT NULL , 
     nombre_marca VARCHAR2 (25)  NOT NULL 
    ) 
;

ALTER TABLE marca 
    ADD CONSTRAINT marca_pk PRIMARY KEY ( id_marca ) ;

CREATE TABLE medio_pago 
    ( 
     id_mpago     NUMBER (3)  NOT NULL , 
     nombre_mpago VARCHAR2 (50)  NOT NULL 
    ) 
;

ALTER TABLE medio_pago 
    ADD CONSTRAINT medio_pago_pk PRIMARY KEY ( id_mpago ) ;

CREATE TABLE producto 
    ( 
     id_producto     NUMBER (4)  NOT NULL , 
     nombre_producto VARCHAR2 (100)  NOT NULL , 
     precio_unitario NUMBER  NOT NULL , 
     origen_nacional CHAR (1)  NOT NULL , 
     stock_minimo    NUMBER (3)  NOT NULL , 
     activo          CHAR (1)  NOT NULL , 
     cod_marca       NUMBER (3)  NOT NULL , 
     cod_categoria   NUMBER (3)  NOT NULL , 
     cod_proveedor   NUMBER (5)  NOT NULL 
    ) 
;

ALTER TABLE producto 
    ADD CONSTRAINT producto_pk PRIMARY KEY ( id_producto ) ;

CREATE TABLE proveedor 
    ( 
     id_proveedor     NUMBER (5)  NOT NULL , 
     nombre_proveedor VARCHAR2 (150)  NOT NULL , 
     rut_proveedor    VARCHAR2 (10)  NOT NULL , 
     telefono         VARCHAR2 (10)  NOT NULL , 
     email            VARCHAR2 (200)  NOT NULL , 
     direccion        VARCHAR2 (200)  NOT NULL , 
     cod_comuna       NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE proveedor 
    ADD CONSTRAINT proveedor_pk PRIMARY KEY ( id_proveedor ) ;

CREATE TABLE region 
    ( 
     id_region  NUMBER (4)  NOT NULL , 
     nom_region VARCHAR2 (255)  NOT NULL 
    ) 
;

ALTER TABLE region 
    ADD CONSTRAINT region_pk PRIMARY KEY ( id_region ) ;

CREATE TABLE salud 
    ( 
     id_salud  NUMBER (4)  NOT NULL , 
     nom_salud VARCHAR2 (40)  NOT NULL 
    ) 
;

ALTER TABLE salud 
    ADD CONSTRAINT salud_pk PRIMARY KEY ( id_salud ) ;

CREATE TABLE vendedor 
    ( 
     id_empleado    NUMBER (4)  NOT NULL , 
     comision_venta NUMBER (5,2)  NOT NULL 
    ) 
;

ALTER TABLE vendedor 
    ADD CONSTRAINT vendedor_pk PRIMARY KEY ( id_empleado ) ;

CREATE TABLE venta 
    ( 
     id_venta     NUMBER (4)GENERATED ALWAYS AS IDENTITY
     START WITH 5050
     MINVALUE 5050
     NOMAXVALUE
     INCREMENT BY 3
     NOT NULL, 
     fecha_venta  DATE  NOT NULL , 
     total_venta  NUMBER (10)  NOT NULL , 
     cod_mpago    NUMBER (3)  NOT NULL , 
     cod_empleado NUMBER (4)  NOT NULL 
    ) 
;

ALTER TABLE venta 
    ADD CONSTRAINT venta_pk PRIMARY KEY ( id_venta ) ;

ALTER TABLE administrativo 
    ADD CONSTRAINT admin_fk_empleado FOREIGN KEY 
    ( 
     id_empleado
    ) 
    REFERENCES empleado 
    ( 
     id_empleado
    ) 
;

ALTER TABLE comuna 
    ADD CONSTRAINT comuna_fk_region FOREIGN KEY 
    ( 
     cod_region
    ) 
    REFERENCES region 
    ( 
     id_region
    ) 
;

ALTER TABLE detalle_venta 
    ADD CONSTRAINT det_venta_fk_producto FOREIGN KEY 
    ( 
     cod_producto
    ) 
    REFERENCES producto 
    ( 
     id_producto
    ) 
;

ALTER TABLE detalle_venta 
    ADD CONSTRAINT det_venta_fk_venta FOREIGN KEY 
    ( 
     cod_venta
    ) 
    REFERENCES venta 
    ( 
     id_venta
    ) 
;

ALTER TABLE empleado 
    ADD CONSTRAINT empleado_fk_afp FOREIGN KEY 
    ( 
     cod_afp
    ) 
    REFERENCES afp 
    ( 
     id_afp
    ) 
;

ALTER TABLE empleado 
    ADD CONSTRAINT empleado_fk_empleado FOREIGN KEY 
    ( 
     cod_empleado
    ) 
    REFERENCES empleado 
    ( 
     id_empleado
    ) 
;

ALTER TABLE empleado 
    ADD CONSTRAINT empleado_fk_salud FOREIGN KEY 
    ( 
     cod_salud
    ) 
    REFERENCES salud 
    ( 
     id_salud
    ) 
;

ALTER TABLE producto 
    ADD CONSTRAINT producto_fk_categoria FOREIGN KEY 
    ( 
     cod_categoria
    ) 
    REFERENCES categoria 
    ( 
     id_categoria
    ) 
;

ALTER TABLE producto 
    ADD CONSTRAINT producto_fk_marca FOREIGN KEY 
    ( 
     cod_marca
    ) 
    REFERENCES marca 
    ( 
     id_marca
    ) 
;

ALTER TABLE producto 
    ADD CONSTRAINT producto_fk_proveedor FOREIGN KEY 
    ( 
     cod_proveedor
    ) 
    REFERENCES proveedor 
    ( 
     id_proveedor
    ) 
;

ALTER TABLE proveedor 
    ADD CONSTRAINT proveedor_fk_comuna FOREIGN KEY 
    ( 
     cod_comuna
    ) 
    REFERENCES comuna 
    ( 
     id_comuna
    ) 
;

ALTER TABLE vendedor 
    ADD CONSTRAINT vendedor_fk_empleado FOREIGN KEY 
    ( 
     id_empleado
    ) 
    REFERENCES empleado 
    ( 
     id_empleado
    ) 
;

ALTER TABLE venta 
    ADD CONSTRAINT venta_fk_empleado FOREIGN KEY 
    ( 
     cod_empleado
    ) 
    REFERENCES empleado 
    ( 
     id_empleado
    ) 
;

ALTER TABLE venta 
    ADD CONSTRAINT venta_fk_medio_pago FOREIGN KEY 
    ( 
     cod_mpago
    ) 
    REFERENCES medio_pago 
    ( 
     id_mpago
    ) 
;




--CASO 2: MODIFICACION DEL MODELO ---------------------------------------------------------------------------------------------------------------------------------------


ALTER TABLE EMPLEADO 
ADD CONSTRAINT ck_sueldo_min
CHECK (sueldo_base>=400000);


ALTER TABLE VENDEDOR
ADD CONSTRAINT ck_comision
CHECK (comision_venta BETWEEN 0 AND 0.025);

ALTER TABLE PRODUCTO 
ADD CONSTRAINT ck_stock_minimo
CHECK (stock_minimo>=3);

ALTER TABLE PROVEEDOR 
ADD CONSTRAINT un_email_proveedor
UNIQUE (email); 

ALTER TABLE MARCA 
ADD CONSTRAINT un_nombre_marca
UNIQUE (nombre_marca);

ALTER TABLE DETALLE_VENTA
ADD CONSTRAINT ck_cantidad_stock 
CHECK (cantidad>=1);


-- CASO 3: POBLAMIENTO DEL MODELO -----------------------------------------------------------------------------------------------------------------------


CREATE SEQUENCE seq_id_salud
START WITH 2050
MINVALUE 2050
NOMAXVALUE
INCREMENT BY 10
NOCYCLE; 

INSERT INTO salud VALUES (seq_id_salud.NEXTVAL,'Fonasa');
INSERT INTO salud VALUES (seq_id_salud.NEXTVAL,'Isapre Colmena');
INSERT INTO salud VALUES (seq_id_salud.NEXTVAL,'Isapre Banmédica');
INSERT INTO salud VALUES (seq_id_salud.NEXTVAL,'Isapre Cruz Blanca');

CREATE SEQUENCE seq_empleado
START WITH 750
MINVALUE 750
NOMAXVALUE
INCREMENT BY 3
NOCYCLE;




INSERT INTO afp (nom_afp) VALUES ('AFP Habitat'); 
INSERT INTO afp (nom_afp) VALUES ('AFP Cuprum');
INSERT INTO afp (nom_afp) VALUES ('AFP Banmedica'); 
INSERT INTO afp (nom_afp) VALUES ('AFP Cruz Blanca');


INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,11111111-1,'Marcela','González', 'Pérez','15-03-2022', 950000, 80000, 'S', 'Administrativo', null, 2050 ,210);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,22222222-2,'José','Muñoz','Ramírez','10-07-2021',900000,75000,'S','Administrativo',null, 2060 , 216);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,33333333-3,'Verónica','Soto','Alarcón','05-01-2020',880000,70000,'S','Vendedor',750 , 2060 , 228);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,44444444-4,'Luis','Reyes','Fuentes','01-04-2023',560000,null,'S','Vendedor', 750 , 2070 , 228);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,55555555-5,'Claudia','Fernández','Lagos','15-04-2023',600000,null,'S','Vendedor', 753 , 2070 ,210);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,66666666-6,'Carlos','Navarro','Vega','01-05-2023',610000,null,'S','Administrativo', 753 , 2060 ,210);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,77777777-7,'Javiera','Pino','Rojas','10-05-2023',650000,null,'S','Administrativo', 750 , 2050 , 210);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,88888888-8,'Diego','Mella','Contreras','12-05-2023',620000,null,'S','Vendedor', 750 , 2060 , 222);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,99999999-9,'Fernanda','Salas','Herrera','18-05-2023',570000,null,'S','Vendedor', 753 , 2070 , 228);
INSERT INTO empleado VALUES(seq_empleado.NEXTVAL,10101010-0,'Tomás','Vidal','Espinoza','01-06-2023',530000,null,'S','Vendedor',null, 2050 , 222);

 

CREATE SEQUENCE seq_mpago
START WITH 11
MINVALUE 11
NOMAXVALUE
INCREMENT BY 1
NOCYCLE;

INSERT INTO medio_pago VALUES (seq_mpago.nextval, 'Efectivo');
INSERT INTO medio_pago VALUES (seq_mpago.nextval, 'Tarjeta Débito');
INSERT INTO medio_pago VALUES (seq_mpago.nextval, 'Tarjeta Crédito');
INSERT INTO medio_pago VALUES (seq_mpago.nextval, 'Cheque');

INSERT INTO venta (fecha_venta, total_venta, cod_mpago, cod_empleado) VALUES ('12-05-2023', 225990, 12, 771);
INSERT INTO venta (fecha_venta, total_venta, cod_mpago, cod_empleado) VALUES ('23-10-2023', 524990, 13, 777);
INSERT INTO venta (fecha_venta, total_venta, cod_mpago, cod_empleado) VALUES ('17-02-2023', 466990, 11, 759);


-- CASO 4: RECUPERACION DE DATOS 

--INFORME 1

SELECT 
id_empleado AS "IDENTIFICADOR",
nombre_empleado || ' ' || apellido_paterno || ' ' || apellido_materno AS "NOMBRE COMPLETO",
sueldo_base AS "SALARIO",
bono_jefatura AS "BONIFICACION",
sueldo_base + bono_jefatura AS "SALARIO SIMULADO"
FROM empleado
WHERE bono_jefatura IS NOT NULL
  AND activo = 'S'
ORDER BY "SALARIO SIMULADO" DESC, apellido_paterno DESC;

--INFORME 2

SELECT 
nombre_empleado || ' ' || apellido_paterno || ' ' || apellido_materno AS "EMPLEADO",
sueldo_base AS "SUELDO",
sueldo_base*0.08 AS "POSIBLE AUMENTO",
sueldo_base + (sueldo_base*0.08) AS "SALARIO SIMULADO"
FROM empleado
WHERE sueldo_base BETWEEN 550000 AND 800000
ORDER BY sueldo_base ASC;






