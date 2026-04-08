USE ShopDB;
GO
-- =========================================================================
-- Author: Moisés David Ramón Esteban
-- Create Date: 2026-03-29
-- Description: Contingencia de vistas
-- P06R01_BD_MDRE: A_DropViews 
-- =========================================================================
BEGIN TRY
    BEGIN TRANSACTION;
    -- Eliminar Views
    DROP VIEW IF EXISTS [dbo].[ViewOrder];
    DROP VIEW IF EXISTS [dbo].[ViewProduct];
    DROP VIEW IF EXISTS [dbo].[ViewClient];

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