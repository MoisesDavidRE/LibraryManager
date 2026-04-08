USE ShopDB;
GO
-- =========================================================================
-- Author: Moisés David Ramón Esteban
-- Create Date: 2026-03-29
-- Description: Contingencia de vistas
-- P06R01_BD_MDRE: C_DropTables 
-- =========================================================================
BEGIN TRY
    BEGIN TRANSACTION;

    -- Eliminar Tablas
    DROP TABLE IF EXISTS [dbo].[Order];
    DROP TABLE IF EXISTS [dbo].[Client];
    DROP TABLE IF EXISTS [dbo].[Product];

    COMMIT TRANSACTION;
    PRINT 'Objetos eliminados correctamente.';
END TRY
BEGIN CATCH
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
    PRINT ERROR_MESSAGE();
    THROW;
END CATCH;
GO