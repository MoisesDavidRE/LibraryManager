-- =========================================================================
-- Author: Moisés David Ramón Esteban
-- Create Date: 2026-03-29
-- Description: Contingencia de Base de datos
-- P06R01_BD_MDRE: D_DropDatabase
-- =========================================================================

-- Cambiar el contexto antes de eliminar la BD GenMar
USE master;
GO

-- Eliminar la BD ShopDB
BEGIN TRY
    -- Cerrar todas las conexiones a excepción de la propia, cerrar todas las transacciones
    ALTER DATABASE ShopDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE IF EXISTS ShopDB;
    PRINT 'Base de datos eliminada correctamente.';
END TRY
BEGIN CATCH
    PRINT ERROR_MESSAGE();
    THROW;
END CATCH;
GO