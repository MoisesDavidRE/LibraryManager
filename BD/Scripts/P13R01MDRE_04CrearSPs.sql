USE Library;
GO

-- =========================================================================
-- Authors: Leslie Teresa Miranda Flores, Levi Merari Bartolo Martínez, Moisés David Ramón Esteban
-- Create Date: 2026-04-06
-- Description: Creación de procedimientos almacenados INSERT, UPDATE, DELETE Y SELECT
-- P13R01_BD: 03CrearSPs
-- =========================================================================

-- =========================================================================
-- Store Procedures Para la tabla Autor
-- =========================================================================

CREATE OR ALTER PROCEDURE [dbo].[ListAutorSP]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_autor], [nombre] FROM [dbo].[Autor];
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[ListAutorByIdSP]
    @id_autor INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_autor], [nombre] FROM [dbo].[Autor] WHERE [id_autor] = @id_autor;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertAutorSP] 
    @nombre VARCHAR(100)
AS
BEGIN 
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO [dbo].[Autor] ([nombre]) 
        VALUES (@nombre);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[UpdateAutorSP]
    @id_autor INT,
    @nombre VARCHAR(100)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE [dbo].[Autor] SET
            [nombre] = @nombre
        WHERE [id_autor] = @id_autor;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[DeleteAutorSP] 
    @id_autor INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dbo].[Autor] WHERE [id_autor] = @id_autor;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

-- =========================================================================
-- Store Procedures Para la tabla Libro
-- =========================================================================

CREATE OR ALTER PROCEDURE [dbo].[ListLibroSP]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_libro], [titulo], [id_autor], [isbn] FROM [dbo].[Libro];
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[ListLibroByIdSP]
    @id_libro INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_libro], [titulo], [id_autor], [isbn] FROM [dbo].[Libro] WHERE [id_libro] = @id_libro;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertLibroSP] 
    @titulo VARCHAR(200),
    @id_autor INT,
    @isbn VARCHAR(20)
AS
BEGIN 
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO [dbo].[Libro] ([titulo], [id_autor], [isbn]) 
        VALUES (@titulo, @id_autor, @isbn);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[UpdateLibroSP]
    @id_libro INT,
    @titulo VARCHAR(200),
    @id_autor INT,
    @isbn VARCHAR(20)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE [dbo].[Libro] SET
            [titulo] = @titulo,
            [id_autor] = @id_autor,
            [isbn] = @isbn
        WHERE [id_libro] = @id_libro;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[DeleteLibroSP] 
    @id_libro INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dbo].[Libro] WHERE [id_libro] = @id_libro;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

-- =========================================================================
-- Store Procedures Para la tabla Cliente
-- =========================================================================

CREATE OR ALTER PROCEDURE [dbo].[ListClienteSP]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_cliente], [nombre], [email], [telefono] FROM [dbo].[Cliente];
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[ListClienteByIdSP]
    @id_cliente INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_cliente], [nombre], [email], [telefono] FROM [dbo].[Cliente] WHERE [id_cliente] = @id_cliente;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertClienteSP] 
    @nombre VARCHAR(100),
    @email VARCHAR(100),
    @telefono VARCHAR(20)
AS
BEGIN 
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO [dbo].[Cliente] ([nombre], [email], [telefono]) 
        VALUES (@nombre, @email, @telefono);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[UpdateClienteSP]
    @id_cliente INT,
    @nombre VARCHAR(100),
    @email VARCHAR(100),
    @telefono VARCHAR(20)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE [dbo].[Cliente] SET
            [nombre] = @nombre,
            [email] = @email,
            [telefono] = @telefono
        WHERE [id_cliente] = @id_cliente;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[DeleteClienteSP] 
    @id_cliente INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dbo].[Cliente] WHERE [id_cliente] = @id_cliente;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

-- =========================================================================
-- Store Procedures Para la tabla Copia
-- =========================================================================

CREATE OR ALTER PROCEDURE [dbo].[ListCopiaSP]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_copia], [id_libro], [tipo], [estado], [precio] FROM [dbo].[Copia];
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[ListCopiaByIdSP]
    @id_copia INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_copia], [id_libro], [tipo], [estado], [precio] FROM [dbo].[Copia] WHERE [id_copia] = @id_copia;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertCopiaSP] 
    @id_libro INT,
    @tipo VARCHAR(20),
    @estado VARCHAR(20),
    @precio DECIMAL(10,2)
AS
BEGIN 
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO [dbo].[Copia] ([id_libro], [tipo], [estado], [precio]) 
        VALUES (@id_libro, @tipo, @estado, @precio);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[UpdateCopiaSP]
    @id_copia INT,
    @id_libro INT,
    @tipo VARCHAR(20),
    @estado VARCHAR(20),
    @precio DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE [dbo].[Copia] SET
            [id_libro] = @id_libro,
            [tipo] = @tipo,
            [estado] = @estado,
            [precio] = @precio
        WHERE [id_copia] = @id_copia;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[DeleteCopiaSP] 
    @id_copia INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dbo].[Copia] WHERE [id_copia] = @id_copia;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

-- =========================================================================
-- Store Procedures Para la tabla Prestamo
-- =========================================================================

CREATE OR ALTER PROCEDURE [dbo].[ListPrestamoSP]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_prestamo], [id_cliente], [id_copia], [fecha_prestamo], [fecha_limite], [fecha_devolucion], [estado] FROM [dbo].[Prestamo];
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[ListPrestamoByIdSP]
    @id_prestamo INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_prestamo], [id_cliente], [id_copia], [fecha_prestamo], [fecha_limite], [fecha_devolucion], [estado] FROM [dbo].[Prestamo] WHERE [id_prestamo] = @id_prestamo;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertPrestamoSP] 
    @id_cliente INT,
    @id_copia INT,
    @fecha_prestamo DATETIME = NULL,
    @fecha_limite DATETIME,
    @estado VARCHAR(20) = 'Activo'
AS
BEGIN 
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO [dbo].[Prestamo] ([id_cliente], [id_copia], [fecha_prestamo], [fecha_limite], [estado]) 
        VALUES (@id_cliente, @id_copia, ISNULL(@fecha_prestamo, CURRENT_TIMESTAMP), @fecha_limite, @estado);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[UpdatePrestamoSP]
    @id_prestamo INT,
    @id_cliente INT,
    @id_copia INT,
    @fecha_prestamo DATETIME,
    @fecha_limite DATETIME,
    @fecha_devolucion DATETIME,
    @estado VARCHAR(20)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE [dbo].[Prestamo] SET
            [id_cliente] = @id_cliente,
            [id_copia] = @id_copia,
            [fecha_prestamo] = @fecha_prestamo,
            [fecha_limite] = @fecha_limite,
            [fecha_devolucion] = @fecha_devolucion,
            [estado] = @estado
        WHERE [id_prestamo] = @id_prestamo;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[DeletePrestamoSP] 
    @id_prestamo INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dbo].[Prestamo] WHERE [id_prestamo] = @id_prestamo;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

-- =========================================================================
-- Store Procedures Para la tabla Venta
-- =========================================================================

CREATE OR ALTER PROCEDURE [dbo].[ListVentaSP]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_venta], [id_cliente], [fecha_venta], [total] FROM [dbo].[Venta];
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[ListVentaByIdSP]
    @id_venta INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_venta], [id_cliente], [fecha_venta], [total] FROM [dbo].[Venta] WHERE [id_venta] = @id_venta;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertVentaSP] 
    @id_cliente INT,
    @total DECIMAL(10,2),
    @fecha_venta DATETIME = NULL
AS
BEGIN 
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO [dbo].[Venta] ([id_cliente], [fecha_venta], [total]) 
        VALUES (@id_cliente, ISNULL(@fecha_venta, CURRENT_TIMESTAMP), @total);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[UpdateVentaSP]
    @id_venta INT,
    @id_cliente INT,
    @fecha_venta DATETIME,
    @total DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE [dbo].[Venta] SET
            [id_cliente] = @id_cliente,
            [fecha_venta] = @fecha_venta,
            [total] = @total
        WHERE [id_venta] = @id_venta;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[DeleteVentaSP] 
    @id_venta INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dbo].[Venta] WHERE [id_venta] = @id_venta;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

-- =========================================================================
-- Store Procedures Para la tabla Detalle_Venta
-- =========================================================================

CREATE OR ALTER PROCEDURE [dbo].[ListDetalle_VentaSP]
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_detalle], [id_venta], [id_copia], [precio_unitario] FROM [dbo].[Detalle_Venta];
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[ListDetalle_VentaByIdSP]
    @id_detalle INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRANSACTION;
    BEGIN TRY
        SELECT [id_detalle], [id_venta], [id_copia], [precio_unitario] FROM [dbo].[Detalle_Venta] WHERE [id_detalle] = @id_detalle;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[InsertDetalle_VentaSP] 
    @id_venta INT,
    @id_copia INT,
    @precio_unitario DECIMAL(10,2)
AS
BEGIN 
    BEGIN TRANSACTION;
    BEGIN TRY
        INSERT INTO [dbo].[Detalle_Venta] ([id_venta], [id_copia], [precio_unitario]) 
        VALUES (@id_venta, @id_copia, @precio_unitario);
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[UpdateDetalle_VentaSP]
    @id_detalle INT,
    @id_venta INT,
    @id_copia INT,
    @precio_unitario DECIMAL(10,2)
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        UPDATE [dbo].[Detalle_Venta] SET
            [id_venta] = @id_venta,
            [id_copia] = @id_copia,
            [precio_unitario] = @precio_unitario
        WHERE [id_detalle] = @id_detalle;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO

CREATE OR ALTER PROCEDURE [dbo].[DeleteDetalle_VentaSP] 
    @id_detalle INT
AS
BEGIN
    BEGIN TRANSACTION;
    BEGIN TRY
        DELETE FROM [dbo].[Detalle_Venta] WHERE [id_detalle] = @id_detalle;
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
        BEGIN
            ROLLBACK TRANSACTION;
            THROW;
        END;
    END CATCH;
END;
GO