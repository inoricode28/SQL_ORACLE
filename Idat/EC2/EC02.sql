---------------------------------------------------------------------------------------------
-- RESOLVER CASOS DE CURSORES
---------------------------------------------------------------------------------------------

/*Pregunta 1:
Crear un cursor el cual muestre los datos de un Libro determinado, ingresando mediante una variable de sustitución 
& el código del libro, por ejemplo ‘1000’, los datos de dicho libro deben ser mostrados.*/
DESCRIBE LIBRO

-- SOLUCIÓN:
SET SERVEROUTPUT ON;
DECLARE
    Codigo LIBRO.CODLIB%TYPE; Titulo LIBRO.TITULOLIB%TYPE;
    Autor  LIBRO.AUTORLIB%TYPE; Editorial LIBRO.EDITOLIB%TYPE;
    Area   LIBRO.AREALIB%TYPE; Precio LIBRO.PRECIOLIB%TYPE;
    CantidadHojas LIBRO.NHOJASLIB%TYPE; AnnoLibro LIBRO.ANOLIB%TYPE;
BEGIN
    SELECT CODLIB, TITULOLIB, AUTORLIB, EDITOLIB, AREALIB,
           PRECIOLIB, NHOJASLIB, ANOLIB
           INTO Codigo, Titulo, Autor, Editorial, Area,
                Precio, CantidadHojas, AnnoLibro
    FROM LIBRO WHERE CODLIB = &Codigo;

    DBMS_OUTPUT.PUT_LINE('DATOS DEL LIBRO     :   ' || Codigo);
    DBMS_OUTPUT.PUT_LINE('============================================');
    DBMS_OUTPUT.PUT_LINE('Código del Libro    :   ' || Codigo);
    DBMS_OUTPUT.PUT_LINE('Título del Libro    :   ' || Titulo);
    DBMS_OUTPUT.PUT_LINE('Autor del Libro     :   ' || Autor);
    DBMS_OUTPUT.PUT_LINE('Editorial del Libro :   ' || Editorial);
    DBMS_OUTPUT.PUT_LINE('Area del Libro      :   ' || Area);
    DBMS_OUTPUT.PUT_LINE('Precio del Libro    :   ' || Precio);
    DBMS_OUTPUT.PUT_LINE('Cantidad de Hojas   :   ' || CantidadHojas);
    DBMS_OUTPUT.PUT_LINE('Año del Libro       :   ' || AnnoLibro);
    DBMS_OUTPUT.PUT_LINE('=============================================');
EXCEPTION --try except
	WHEN NO_DATA_FOUND THEN
	     DBMS_OUTPUT.put_line ('Libro No Existe!!!!');
END;



/*Pregunta 2:
Se desea vender todos los libros de la librería, clasificados por área del libro
(ANALISIS, ARTE, PROYECTOS, LPROG, LIDEREZGO y CAD), crear un cursor en código PL/SQL
que realice dicha acción, con totalizaciones incluidas.  Redacte el código desde el editor
de Oracle PL/SQL..*/

SELECT * FROM LIBRO;

-- SOLUCIÓN:
SET SERVEROUTPUT ON;
DECLARE
    TOTAL_ANALISIS NUMBER:=0;
    TOTAL_ARTE NUMBER:=0;
    TOTAL_PROYECTOS NUMBER:=0;
    TOTAL_LPROG NUMBER:=0;
    TOTAL_LIDERAZGO NUMBER:=0;
    TOTAL_CAD NUMBER:=0;
    TOTAL_IMPORTE NUMBER:=0; IGV NUMBER:=0; TOTAL_GENERAL NUMBER:=0;
BEGIN
    SELECT SUM (PRECIOLIB) INTO TOTAL_ANALISIS 
           FROM LIBRO WHERE AREALIB='ANALISIS';
    SELECT SUM (PRECIOLIB) INTO TOTAL_ARTE 
           FROM LIBRO WHERE AREALIB='ARTE';
    SELECT SUM (PRECIOLIB) INTO TOTAL_PROYECTOS
           FROM LIBRO WHERE AREALIB='PROYECTOS';
    SELECT SUM (PRECIOLIB) INTO TOTAL_LPROG
           FROM LIBRO WHERE AREALIB='LPROG';
    SELECT SUM (PRECIOLIB) INTO TOTAL_LIDERAZGO
           FROM LIBRO WHERE AREALIB='LIDERAZGO';
    SELECT SUM (PRECIOLIB) INTO TOTAL_CAD
           FROM LIBRO WHERE AREALIB='CAD';
     TOTAL_IMPORTE:=TOTAL_ANALISIS + TOTAL_ARTE + TOTAL_PROYECTOS + 
                   TOTAL_LPROG + TOTAL_LIDERAZGO + TOTAL_CAD;
    IGV:= TOTAL_IMPORTE * 0.18;
    TOTAL_GENERAL:= TOTAL_IMPORTE + IGV;
    DBMS_OUTPUT.PUT_LINE('VENTA DE LA LIBRERIA POR AREA DEL LIBRO');
    DBMS_OUTPUT.PUT_LINE('=================================================');
    DBMS_OUTPUT.PUT_LINE('TOTAL LIBROS DE ANALISIS    : ' || TOTAL_ANALISIS);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE LIBROS DE ARTE     : ' || TOTAL_ARTE);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE LIBRO DE PROYECTOS : ' || TOTAL_PROYECTOS);
    DBMS_OUTPUT.PUT_LINE('TOTAL DE LIBRO DE LPROG     : ' || TOTAL_LPROG);
    DBMS_OUTPUT.PUT_LINE('TOTAL LIBRO DE LIDERAZGO    : ' || TOTAL_LIDERAZGO);
    DBMS_OUTPUT.PUT_LINE('TOTAL LIBRO DE CAD          : ' || TOTAL_CAD);
    DBMS_OUTPUT.PUT_LINE('==================================================');
    DBMS_OUTPUT.PUT_LINE('TOTAL IMPORTE               : ' || TOTAL_IMPORTE);
    DBMS_OUTPUT.PUT_LINE('IGV                         : ' || IGV);
    DBMS_OUTPUT.PUT_LINE('TOTAL GENERAL               : ' || TOTAL_GENERAL);
    DBMS_OUTPUT.PUT_LINE('==================================================');
END;

/*Pregunta 3:
Elabore un cursor el cual permita el ingreso del código de un alumno y como
resultado mostrar en un detalle, las asignaturas, profesores y calificaciones
incluyendo el promedio y estado (Aprobado o Desaprobado).*/
SELECT * FROM ALUMNO;

SET SERVEROUTPUT ON;
DECLARE
    CURSOR REGISTRO_NOTAS IS
        SELECT A.NOMBRE ALUMNO, P.NOMBRE PROFESOR, C.DESCRIPCION ASIGNATURA, N.Nota1, N.Nota2, N.Nota3, N.Nota4,
            (N.Nota1*0.04) + (N.Nota2*0.12) + (N.Nota3*0.24) + (N.Nota4*0.6) PROMEDIO,
            CASE
                WHEN (N.Nota1*0.04) + (N.Nota2*0.12) + (N.Nota3*0.24) + (N.Nota4*0.6) > 13 THEN 'APROBADO'
                WHEN (N.Nota1*0.04) + (N.Nota2*0.12) + (N.Nota3*0.24) + (N.Nota4*0.6) <= 12.5 THEN 'DESAPROBADO'
            END ESTADO
        FROM NOTAS N
        INNER JOIN ALUMNO A ON A.COD_ALU = N.COD_ALU
        INNER JOIN CURSOS C ON C.COD_CURSO = N.COD_CURSO
        INNER JOIN PROFESOR P ON P.COD_PROF = N.COD_PROF
        WHERE A.COD_ALU = &CodA;

    Alum ALUMNO.NOMBRE%TYPE;
    Profe PROFESOR.NOMBRE%TYPE;
    Asig CURSOS.DESCRIPCION%TYPE;
    N1 NOTAS.NOTA1%TYPE;
    N2 NOTAS.NOTA2%TYPE;
    N3 NOTAS.NOTA3%TYPE;
    N4 NOTAS.NOTA4%TYPE;
    Prom NUMBER(5, 2);
    Est VARCHAR2(20);

BEGIN
    OPEN REGISTRO_NOTAS;
    FETCH REGISTRO_NOTAS INTO Alum, Profe, Asig, N1, N2, N3, N4, Prom, Est;

    IF REGISTRO_NOTAS%NOTFOUND THEN
        DBMS_OUTPUT.PUT_LINE('El código de alumno ingresado no existe.');
    ELSE
        WHILE REGISTRO_NOTAS%FOUND LOOP
            DBMS_OUTPUT.PUT_LINE('');
            DBMS_OUTPUT.PUT_LINE('=================================================');
            DBMS_OUTPUT.PUT_LINE('INFORMACION DEL ALUMNO : '|| Alum);
            DBMS_OUTPUT.PUT_LINE('=================================================');
            DBMS_OUTPUT.PUT_LINE('PROFESOR       : ' || Profe);
            DBMS_OUTPUT.PUT_LINE('ASIGNATURA     : ' || Asig);
            DBMS_OUTPUT.PUT_LINE('Nota 1: ' || N1 || '  Nota 2: ' || N2 || '  Nota 3: ' || N3 || '  Nota 4: ' || N4);
            DBMS_OUTPUT.PUT_LINE('PROMEDIO       : ' || Prom);
            DBMS_OUTPUT.PUT_LINE('ESTADO         : ' || Est);
            DBMS_OUTPUT.PUT_LINE('=================================================');

            FETCH REGISTRO_NOTAS INTO Alum, Profe, Asig, N1, N2, N3, N4, Prom, Est;
        END LOOP;
    END IF;

    CLOSE REGISTRO_NOTAS;
END;
        
