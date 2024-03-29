

--ELIMINANDO LAS TABLAS SI EN CASOS EXISTIERAN.
DROP TABLE COMPROBANTE;
DROP TABLE DETALLE_PEDIDO;
DROP TABLE CABECERA_PEDIDO;
DROP TABLE CLIENTE;
DROP TABLE EMPLEADO;
DROP TABLE PRODUCTO;

CREATE TABLE CLIENTE
(
	IdCli                VARCHAR2(5) NOT NULL ,
	Nombre               VARCHAR2(50) NOT NULL ,
	Ruc                  VARCHAR2(11) NOT NULL ,
	Direccion            VARCHAR2(50) NOT NULL ,
	Estado               VARCHAR2(20) NOT NULL ,
    PRIMARY KEY (IdCli)
);

CREATE TABLE EMPLEADO
(
	IdEmp                VARCHAR2(5) NOT NULL ,
	Nombre               VARCHAR2(50) NOT NULL ,
	Ruc                  VARCHAR2(11) NOT NULL ,
	Direccion            VARCHAR2(50) NOT NULL ,
	Estado               VARCHAR2(20) NOT NULL ,
    PRIMARY KEY (IdEmp)
);

CREATE TABLE CABECERA_PEDIDO
(
	IdPedido             VARCHAR2(5) NOT NULL ,
	IdCli                VARCHAR2(5) NULL ,
	IdEmp                VARCHAR2(5) NULL ,
	Estado               VARCHAR2(20) NOT NULL ,
    PRIMARY KEY (IdPedido),
    FOREIGN KEY (IdCli) REFERENCES CLIENTE (IdCli),
    FOREIGN KEY (IdEmp) REFERENCES EMPLEADO (IdEmp)
);

CREATE TABLE COMPROBANTE
(
	TipCom               VARCHAR2(20) NOT NULL ,
	NComp                VARCHAR2(5) NOT NULL ,
	IdPedido             VARCHAR2(5) NULL ,
	Estado               VARCHAR2(20) NOT NULL ,
    PRIMARY KEY (TipCom,NComp),
    FOREIGN KEY (IdPedido) REFERENCES CABECERA_PEDIDO (IdPedido)
);

CREATE TABLE PRODUCTO
(
	IdProd               VARCHAR2(5) NOT NULL ,
	Nombre               VARCHAR2(50) NOT NULL ,
	Precio               NUMBER(10, 2) NOT NULL ,
	Stock                INTEGER NOT NULL ,
	Estado               VARCHAR2(20) NOT NULL ,
    PRIMARY KEY (IdProd)
);

CREATE TABLE DETALLE_PEDIDO
(
	Item                 INTEGER NOT NULL ,
	IdPedido             VARCHAR2(5) NOT NULL ,
	IdProd               VARCHAR2(5) NULL ,
	Cant                 INTEGER NOT NULL ,
    PRIMARY KEY (Item,IdPedido),
    FOREIGN KEY (IdProd) REFERENCES PRODUCTO (IdProd),
    FOREIGN KEY (IdPedido) REFERENCES CABECERA_PEDIDO (IdPedido)
);

INSERT INTO CLIENTE VALUES('C0001','PEREZ CASTRO JORGE','10545878987','AV. PERU 1234 SMP','ACTIVO');
INSERT INTO CLIENTE VALUES('C0002','SANCHEZ SALAS CARMEN','10254587897','AV. SAENZ PE�A 120 CALLAO','BLOQUEADO');
INSERT INTO CLIENTE VALUES('C0003','CAMPOS LOPEZ EDUARDO','10547848757','JR. HUASCAR 323 SJL','ACTIVO');
INSERT INTO CLIENTE VALUES('C0004','VERASTEGUI VARGAS JULIAN','10125458787','AV. LOS TULIPANES 928 SJM','BLOQUEADO');
INSERT INTO CLIENTE VALUES('C0005','FERNANDEZ PEREZ ELIZABETH','10545878987','AV. NICOLAS DE PIEROLA 245 LIMA CERCADO','ACTIVO');
COMMIT;

INSERT INTO EMPLEADO VALUES('E0001','RODRIGUEZ CARPIO ALEXANDRA','10546996567','AV. LOS HEROES 2545 SJM','ACTIVO'); 
INSERT INTO EMPLEADO VALUES('E0002','CARPIO LORENZO JUAN','10456321547','JR. HUARAZ 654 BRE�A','ACTIVO');
INSERT INTO EMPLEADO VALUES('E0003','GAMARRA SANCHEZ ANA','10555989877','JR. LAS ALMENDRAS 323 LOS OLIVOS','BLOQUEADO');
INSERT INTO EMPLEADO VALUES('E0004','JAUREGUI DALTANO JULY','10223235697','AV. PERU 3223 SMP','ACTIVO');
INSERT INTO EMPLEADO VALUES('E0005','PEREZ ARBIETO JUAN','10525656587','JR. LAS CAMPANITAS SAN BORJA','BLOQUEADO');
COMMIT;

INSERT INTO PRODUCTO VALUES('P0001','TV. COLOR LED 42P SMART',1599.99,47,'ACTIVO');
INSERT INTO PRODUCTO VALUES('P0002','TV. COLOR LED 55P SMART',2499.99,0,'BLOQUEADO');
INSERT INTO PRODUCTO VALUES('P0003','REFRIGERADOR 14P3 FROZEN',1299.99,47,'ACTIVO');
INSERT INTO PRODUCTO VALUES('P0004','REFRIGERADOR 16P3 FROZEN',1899.99,0,'BLOQUEADO');
INSERT INTO PRODUCTO VALUES('P0005','LAVADORA 8KG CENTRIFUGADORA LAVA-SECA',2599.99,43,'ACTIVO');
INSERT INTO PRODUCTO VALUES('P0006','LAVADORA 10KG CENTRIFUGADORA LAVA-SECA',2899.99,47,'ACTIVO');
INSERT INTO PRODUCTO VALUES('P0007','HORNO MICROONDAS SMART-COOLER',259.99,0,'BLOQUEADO');
INSERT INTO PRODUCTO VALUES('P0008','BLU-RAY - DVD ',249.99,0,'BLOQUEADO');
INSERT INTO PRODUCTO VALUES('P0009','TV. COLOR LED 32P SMART',999.99,22,'ACTIVO');
INSERT INTO PRODUCTO VALUES('P0010','CPU 3.2GB HD 1T DDR3 4GB PLACA BASE INTEL G8748B',1500.00,45,'ACTIVO');
COMMIT;

--3 PEDIDOS
INSERT INTO CABECERA_PEDIDO VALUES('00001','C0001','E0001','EMITIDO');
INSERT INTO CABECERA_PEDIDO VALUES('00002','C0003','E0002','EMITIDO');
INSERT INTO CABECERA_PEDIDO VALUES('00003','C0005','E0004','EMITIDO');
COMMIT;

--3 DETALLES DE PEDIDO
INSERT INTO DETALLE_PEDIDO VALUES(1,'00001','P0001',3);
INSERT INTO DETALLE_PEDIDO VALUES(2,'00001','P0003',3);
INSERT INTO DETALLE_PEDIDO VALUES(3,'00001','P0005',3);
COMMIT;

INSERT INTO DETALLE_PEDIDO VALUES(1,'00002','P0006',3);
INSERT INTO DETALLE_PEDIDO VALUES(2,'00002','P0009',3);
INSERT INTO DETALLE_PEDIDO VALUES(3,'00002','P0010',3);
COMMIT;

INSERT INTO DETALLE_PEDIDO VALUES(1,'00003','P0009',5);
INSERT INTO DETALLE_PEDIDO VALUES(2,'00003','P0010',2);
INSERT INTO DETALLE_PEDIDO VALUES(3,'00003','P0005',4);
COMMIT;

--REALIZANDO LA VENTA
INSERT INTO COMPROBANTE VALUES('BOLETA','B0001','00001','PAGADO');
INSERT INTO COMPROBANTE VALUES('FACTURA','F0001','00002','PAGADO');
INSERT INTO COMPROBANTE VALUES('BOLETA','B0002','00003','EMITIDA');
COMMIT;

SELECT * FROM CLIENTE;
SELECT * FROM EMPLEADO;
SELECT * FROM PRODUCTO;
SELECT * FROM CABECERA_PEDIDO;
SELECT * FROM DETALLE_PEDIDO;
SELECT * FROM COMPROBANTE;

--A PARTIR DE AQUI CREAR SUS PROCEDIMIENTOS ALMACENADOS Y FUNCIONES NECESARIAS
--PARA LA ACTIVIDAD VIRTUAL.

--EJEMPLO 1: SIN USAR PARAMETROS
--Implementar un PAQUETE pack1  el cual debe contener lo siguiente:
--�	procedimiento1: Mostrara el siguiente mensaje: �PRIMER PROCEDIMIENTO�.
--�	procedimiento2: Mostrara el siguiente mensaje: �SEGUNDO PROCEDIMIENTO�.

--SOLUCION PASO A PASO
--PASO 1: REALIZAR LA ESPECIFICACION.
CREATE OR REPLACE PACKAGE MI_PAQUETE1
IS
    PROCEDURE P1;
    PROCEDURE P2;
END;

--PASO 2: CUERPO DEL PAQUETE.
CREATE OR REPLACE PACKAGE BODY MI_PAQUETE1
IS
    PROCEDURE P1
    IS 
        BEGIN
            DBMS_OUTPUT.PUT_LINE ('PRIMER PROCEDIMIENTO');
        END P1;

    PROCEDURE P2
    IS  
    BEGIN
        DBMS_OUTPUT.PUT_LINE ('SEGUNDO PROCEDIMIENTO');
    END P2;
    
END MI_PAQUETE1;

--EJECUCION
SET SERVEROUTPUT ON;
EXEC MI_PAQUETE1.p1;
EXEC MI_PAQUETE1.p2;




--EJEMPLO 2: CON USO DE PARAMETROS
--Implementar un PAQUETE pack2  el cual debe contener lo siguiente:
--�	procedimiento1: Mostrara la sumatoria de dos n�meros.
--�	procedimiento2: Mostrara la multiplicaci�n de dos n�meros.

--SOLUCION PASO A PASO

--PASO 1: REALIZAR LA ESPECIFICACION.
CREATE OR REPLACE PACKAGE MI_PAQUETE2
IS
    PROCEDURE P1 (A NUMBER, B NUMBER);
    PROCEDURE P2 (X NUMBER, Y NUMBER);
END;

--PASO 2: CUERPO DEL PAQUETE
CREATE OR REPLACE PACKAGE BODY MI_PAQUETE2
IS
    PROCEDURE P1 (A NUMBER, B NUMBER)
    IS
        C NUMBER (5);
    BEGIN
        C:=A+B;
        DBMS_OUTPUT.PUT_LINE ('LA SUMATORIA ES: ' || C);
    END P1;

    PROCEDURE P2 (X NUMBER, Y NUMBER)
    IS 
        Z NUMBER (5);
    BEGIN
        Z:=X*Y;
        DBMS_OUTPUT.PUT_LINE ('LA MULTIPLICACION ES: ' ||  Z);
    END P2;

END MI_PAQUETE2;

--PASO 3: EJECUCION
SET SERVEROUTPUT ON;
EXEC MI_PAQUETE2.P1(10,20);
EXEC MI_PAQUETE2.P2(10,20);


--EJEMPLO 3: PROCEDURE Y FUNCTION COMBINADOS.
--Implementar un PAQUETE MI_PAQUETE3  el cual debe contener lo siguiente:
--�	Procedimiento1: Mostrara la sumatoria de dos n�meros.
--�	Funcion1: Calcular la sumatoria de dos n�meros.

---PASO 1: REALIZAR LA ESPECIFICACION.
CREATE OR REPLACE PACKAGE MI_PAQUETE3
IS
    PROCEDURE P1(A NUMBER,B NUMBER);
    FUNCTION F1(X NUMBER,Y NUMBER) RETURN NUMBER;
END;

--PASO 2: CUERPO DEL PAQUETE.
CREATE OR REPLACE PACKAGE BODY MI_PAQUETE3
IS
    PROCEDURE P1(A NUMBER,B NUMBER)
    IS
        C NUMBER(5);
    BEGIN
        C:=A+B;
        DBMS_OUTPUT.PUT_LINE('LA SUMATORIA ES: ' || C);
    END P1;
    
    FUNCTION F1(X NUMBER,Y NUMBER)
    RETURN NUMBER
    IS 
        Z NUMBER(5);
    BEGIN
        Z:=X*Y;
        RETURN Z;
    END F1;
    
END MI_PAQUETE3;

--PASO 3: EJECUCION

--PROCEDIMIENTO
SET SERVEROUTPUT ON;
EXEC MI_PAQUETE3.P1(10,20);
--FUNCTION
SET SERVEROUTPUT ON;
SELECT  MI_PAQUETE3.F1(10,20) MULTIPLICA FROM DUAL;



--EJEMPLO 4: USANDO DATOS DE TABLAS.
--Implemente un paquete llamado MI_PAQUETE4, el cual contenga los siguientes procedimientos y funciones:
--�	Obtener el conteo de libros
--�	Totalizaci�n de libros
--�	El libro m�s caro
--�	El libro m�s barato

--SI LA TABLA EXISTE, DEBE SER BORRADA
DROP TABLE LIBRO;

--CREANDO LA TABLA LIBRO
CREATE TABLE LIBRO(
            CODLIB VARCHAR2(5) PRIMARY KEY NOT NULL,        
            TITULOLIB  VARCHAR2(32),        
            AUTORLIB   VARCHAR2(24),        
            EDITOLIB    VARCHAR2(13),        
            AREALIB     VARCHAR2(9),        
            PRECIOLIB  NUMERIC(8,2),    
            NHOJASLIB INT,            
            ANOLIB    INT);

---INSERTANDO DATOS EN LA TABLA LIBRO
INSERT INTO LIBRO VALUES('1000','VISUAL FOX','RUBEN IGLESIAS','RAMA','LPROG',60,489,1997);
INSERT INTO LIBRO VALUES('1001','POWER BUILDER 6.','RAMIRO HOOL','UNI','LPROG',80,410,1999);
INSERT INTO LIBRO VALUES('1002','ANALISIS Y DISE�O DE SIST.','KENDALL Y KENDALL','PRINTICE HALL','ANALISIS',100,913,1997);
INSERT INTO LIBRO VALUES('1003','POWER BUILDER 6.','WILLIAM B. HEYS','QUE','LPROG',150,843,1999);
INSERT INTO LIBRO VALUES('1004','VISUAL BASIC','CESAR BUSTAMANTE','GRAPPERU','LPROG',35,390,1997);
INSERT INTO LIBRO VALUES('1005','VISUAL FOX PRO','LES Y JHON PINTER','MC GRAWHILL','LPROG',25,567,1997);
INSERT INTO LIBRO VALUES('1006','GUIA C++','JULIO VASQUEZ PARAGULLAS','UPSMP','LPROG',50,780,1997);
INSERT INTO LIBRO VALUES('1007','MS C++','BECK ZARATIAN','MICROSOFT','LPROG',80,600,1999);
INSERT INTO LIBRO VALUES('1008','VISUAL FOX PRO 6.00','CESAR BUSTAMANTE','UNI','LPROG',35,450,1999);
INSERT INTO LIBRO VALUES('1009','AUTOCAD 2000','J.A. TAJADURA J. LOPEZ','MC GRAW HILL','CAD',40,480,1998);
INSERT INTO LIBRO VALUES('1010','EFECTOS COREL','ANOMINO','MACRO','ARTE',50,400,1998);
INSERT INTO LIBRO VALUES('1011','EL VENDEDOR MAS GRANDE DEL MUNDO','OG MANDINO','DIANA','LIDERAZGO',15,121,1968);
INSERT INTO LIBRO VALUES('1012','EL PODER DEL CARISMA','MIGUEL ANGEL CORNEJO','ESTRELLA','LIDERAZGO',15,123,1992);
INSERT INTO LIBRO VALUES('1013','7 HABITOS DE LA GENTE EFECTIVA','STEPHEN  R. COVER','PAIDOS','LIDERAZGO',50,460,1989);
INSERT INTO LIBRO VALUES('1014','CRITERIOS EVA. PROY.','NASSIR SAPAG CHAIN','MC GRAW HILL','PROYECTOS',10,144,1997);
INSERT INTO LIBRO VALUES('1015','COMO DIRIGIR MICRO EMP.','VICTOR ABAD G.','IPEDE','PROYECTOS',10,110,1995);
INSERT INTO LIBRO VALUES('1016','LA MAGIA DE PENSAR EN GRANDE','DAVID JASEPH SCHWRTZ','HERREROS MEX','LIDERAZGO',10,258,1960);
INSERT INTO LIBRO VALUES('1017','SQL SERVER VB','WILLIAM R. VAUGHN','MICROSOFT','LPROG',60,1000,1999);
INSERT INTO LIBRO VALUES('1018','VISUAL FOX 6.00','MENACHEN BAZIAN','QUE','LPROG',55,1000,1999);
INSERT INTO LIBRO VALUES('1019','INTELIGENCIA EMOCIONAL','DANIEL GOLEMAN','ZETA','LIDERAZGO',48,396,1996);
INSERT INTO LIBRO VALUES('1020','LA TERCERA OLA','ALVIN TOFFLER','MC GRAW HILL','LIDERAZGO',50,250,1998);
COMMIT;

SELECT * FROM LIBRO;


---PASO 1: REALIZAR LA ESPECIFICACION.
CREATE OR REPLACE PACKAGE MI_PAQUETE4
IS
    FUNCTION FCONTEO_LIBROS RETURN NUMBER;
    FUNCTION FTOTALIZAR_LIBROS RETURN NUMBER;
    FUNCTION FLIBRO_CARO RETURN VARCHAR2;
    FUNCTION FLIBRO_BARATO RETURN VARCHAR2;
    PROCEDURE SP_LLAMADA;
END;

--PASO 2: CUERPO DEL PAQUETE.
CREATE OR REPLACE PACKAGE BODY MI_PAQUETE4
IS
    FUNCTION FCONTEO_LIBROS
    RETURN NUMBER
    IS 
        CONTAR NUMBER:=0;
    BEGIN
        SELECT COUNT(CODLIB) INTO CONTAR FROM LIBRO;
        RETURN CONTAR;
    END FCONTEO_LIBROS;
    
    FUNCTION FTOTALIZAR_LIBROS
    RETURN NUMBER
    IS 
        TOTAL NUMBER:=0;
    BEGIN
        SELECT SUM(CODLIB) INTO TOTAL FROM LIBRO;
        RETURN TOTAL;
    END FTOTALIZAR_LIBROS;    

    FUNCTION FLIBRO_CARO
    RETURN Varchar2
    IS
       Precio Number;
       Nombre VARCHAR2(200);
    BEGIN
        SELECT TITULOLIB,PRECIOLIB INTO Nombre, Precio 
        FROM (SELECT TITULOLIB,PRECIOLIB 
              FROM LIBRO ORDER BY PRECIOLIB DESC) WHERE ROWNUM<=1;
        Nombre:= Nombre || ' ' || TO_CHAR(Precio);
    RETURN Nombre;
    END FLIBRO_CARO;

    FUNCTION FLIBRO_BARATO
    RETURN Varchar2
    IS
       Precio Number;
       Nombre VARCHAR2(200);
    BEGIN
        SELECT TITULOLIB,PRECIOLIB INTO Nombre, Precio 
        FROM (SELECT TITULOLIB,PRECIOLIB 
              FROM LIBRO ORDER BY PRECIOLIB) WHERE ROWNUM<=1;
        Nombre:= Nombre || TO_CHAR(Precio);
    RETURN Nombre;
    END FLIBRO_BARATO;
    
    PROCEDURE SP_LLAMADA
    IS
    BEGIN
        DBMS_OUTPUT.PUT_LINE('======================================');
        DBMS_OUTPUT.PUT_LINE('DETALLE DE LIBROS:');
        DBMS_OUTPUT.PUT_LINE('======================================');
        DBMS_OUTPUT.PUT_LINE('CONTEO        : ' || FCONTEO_LIBROS);
        DBMS_OUTPUT.PUT_LINE('TOTALIZACION  : ' || FTOTALIZAR_LIBROS);
        DBMS_OUTPUT.PUT_LINE('EL MAS CARO   : ' || FLIBRO_CARO);
        DBMS_OUTPUT.PUT_LINE('EL MAS BARATO : ' || FLIBRO_BARATO);

    END SP_LLAMADA;
    
END MI_PAQUETE4;

--PASO 3: EJECUCION
SET SERVEROUTPUT ON;
EXEC MI_PAQUETE4.SP_LLAMADA;










