-- =========================================================================
-- Authors: Leslie Teresa Miranda Flores, Levi Merari Bartolo Martínez, Moisés David Ramón Esteban
-- Create Date: 2026-04-06
-- Description: Creación de BD
-- P13R01_BD: 01CrearBD 
-- =========================================================================
DECLARE @NombreBD VARCHAR(25) = 'Library';
DECLARE @SQLQuery NVARCHAR(MAX) = 'CREATE DATABASE ' + QUOTENAME(@NombreBD);

BEGIN TRY
    EXEC sp_executesql @SQLQuery;
    PRINT 'La base de datos ' + @NombreBD + ' fue creada exitosamente.';
END TRY
BEGIN CATCH
    PRINT 'La base de datos ' + @NombreBD + ' ya existe o hubo un error.';
END CATCH;
GO