USE ShopDB;
GO
-- =========================================================================
-- Author: Moisés David Ramón Esteban
-- Create Date: 2026-03-29
-- Description: Contingencia de procedimientos almacenados
-- P06R01_BD_MDRE: B_DropStoreProcedures
-- =========================================================================
BEGIN TRY
    BEGIN TRANSACTION;

    -- Eliminar Store Procedures de "Products"
    DROP PROCEDURE IF EXISTS [dbo].[ListProductSP];
    DROP PROCEDURE IF EXISTS [dbo].[ListProductByIdSP];
    DROP PROCEDURE IF EXISTS [dbo].[InsertProductSP];
    DROP PROCEDURE IF EXISTS [dbo].[UpdateProductSP];
    DROP PROCEDURE IF EXISTS [dbo].[DeleteProductSP];

    -- Eliminar Store Procedures de "Client"
    DROP PROCEDURE IF EXISTS [dbo].[ListClientsSP];
    DROP PROCEDURE IF EXISTS [dbo].[InsertClientSP];
    DROP PROCEDURE IF EXISTS [dbo].[UpdateClientSP];
    DROP PROCEDURE IF EXISTS [dbo].[DeleteClientSP];

    -- Eliminar Store Procedures de "Order"
    DROP PROCEDURE IF EXISTS [dbo].[ListOrdersSP];
    DROP PROCEDURE IF EXISTS [dbo].[InsertOrderSP];
    DROP PROCEDURE IF EXISTS [dbo].[UpdateOrderSP];
    DROP PROCEDURE IF EXISTS [dbo].[DeleteOrderSP];

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