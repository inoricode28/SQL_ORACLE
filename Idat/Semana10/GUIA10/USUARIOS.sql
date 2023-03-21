--BORRANDO EL TABLESPACE, USUARIO Y ROL, SI EXISTIERAN
DROP USER USER10;
DROP ROLE ROL10;
DROP TABLESPACE IDAT10;

--1 Creando el TableSpace
Create TableSpace IDAT10 DataFile 'C:\IDAT\IDAT_10.DBF' Size 150M;
--2 Verificando la creación del TableSpace
Select * From v$tablespace;
--3 Ahora crearemos al usuario cuya contraseña será: XXXXX
Create User USER10 Identified by "123456"
Default TableSpace IDAT10
Temporary TableSpace TEMP
Quota unlimited on IDAT10;
--4 Creamos un Rol el cual contendrá los permisos, en este caso
-- el Role tendrá el nombre PERMITIR.
Create Role ROL10;
--5 Asignaremos los permisos (GRANT) de usuario pertinentes.
--Los permisos son: CONNECT, CREATE TABLE, CREATE ANY TABLE, RESOURCE.
--y otros, los asociamos al Rol PERMITIR ya antes creado.

Grant CONNECT, CREATE TABLE, RESOURCE, 
      ALTER ANY INDEX, ALTER ANY SEQUENCE, ALTER ANY TABLE,
      ALTER ANY TRIGGER, CREATE ANY INDEX, CREATE ANY SEQUENCE,
      CREATE ANY SYNONYM, CREATE ANY TABLE, CREATE ANY TRIGGER,
      CREATE ANY VIEW, CREATE PROCEDURE, CREATE PUBLIC SYNONYM, 
      CREATE TRIGGER, CREATE VIEW, DROP ANY INDEX,
      DROP ANY SEQUENCE, DROP ANY TABLE, DROP ANY TRIGGER, DROP ANY VIEW,
      INSERT ANY TABLE, QUERY REWRITE, SELECT ANY TABLE,
      UNLIMITED TABLESPACE To ROL10;
--6 Asociamos (GRANT) el Rol PERMITIR con el usuario USER1,
--de esta manera el usuario USER1, podrá realizar las tareas
--i/o permisos que el Rol tiene.
Grant ROL10 To USER10;
--7. CERRAR TODO, DESCONECTAR E INICIAR NUEVAMENTE, EN ESTA OCASION USAR
--   AL USUARIO USER1

