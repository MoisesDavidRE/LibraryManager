USE Library
GO
-- =========================================================================
-- Authors: Leslie Teresa Miranda Flores, Levi Merari Bartolo Martínez, Moisés David Ramón Esteban
-- Create Date: 2026-04-06
-- Description: Creación de Tablas
-- P13R01_BD: 02CrearTablas
-- =========================================================================

-- Crear la tabla Autor
BEGIN TRANSACTION
BEGIN TRY
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Autor')
    BEGIN
        CREATE TABLE Autor (
        id_autor INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL
    );
    END
    ELSE
        PRINT 'La tabla [dbo].[Autor] ya existe'
    COMMIT TRANSACTION;
END TRY 
BEGIN CATCH 
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
        THROW;
END CATCH;
GO

-- Crear la tabla Libro
BEGIN TRANSACTION
BEGIN TRY
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Libro')
    BEGIN
        CREATE TABLE Libro (
        id_libro INT PRIMARY KEY IDENTITY(1,1),
        titulo VARCHAR(200) NOT NULL,
        id_autor INT,
        isbn VARCHAR(20) UNIQUE,
        FOREIGN KEY (id_autor) REFERENCES Autor(id_autor)
    );
    END
    ELSE
        PRINT 'La tabla [dbo].[Libro] ya existe'
    COMMIT TRANSACTION;
END TRY 
BEGIN CATCH 
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
        THROW;
END CATCH;
GO

-- Crear la tabla Copia
BEGIN TRANSACTION
BEGIN TRY
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Copia')
    BEGIN
        CREATE TABLE Copia (
        id_copia INT PRIMARY KEY IDENTITY(1,1),
        id_libro INT,
        tipo VARCHAR(20) NOT NULL,
        estado VARCHAR(20) NOT NULL,
        precio DECIMAL(10,2),
        FOREIGN KEY (id_libro) REFERENCES Libro(id_libro)
        );
    END
    ELSE
        PRINT 'La tabla [dbo].[Copia] ya existe'
    COMMIT TRANSACTION;
END TRY 
BEGIN CATCH 
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
        THROW;
END CATCH;
GO

-- Crear la tabla Cliente
BEGIN TRANSACTION
BEGIN TRY
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Cliente')
    BEGIN
        CREATE TABLE Cliente (
        id_cliente INT PRIMARY KEY IDENTITY(1,1),
        nombre VARCHAR(100) NOT NULL,
        email VARCHAR(100) UNIQUE,
        telefono VARCHAR(20)
        );
    END
    ELSE
        PRINT 'La tabla [dbo].[Cliente] ya existe'
    COMMIT TRANSACTION;
END TRY 
BEGIN CATCH 
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
        THROW;
END CATCH;
GO

-- Crear la tabla Venta
BEGIN TRANSACTION
BEGIN TRY
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Venta')
    BEGIN
        CREATE TABLE Venta (
        id_venta INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT,
        fecha_venta DATETIME DEFAULT CURRENT_TIMESTAMP,
        total DECIMAL(10,2),
        FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente)
        );
    END
    ELSE
        PRINT 'La tabla [dbo].[Venta] ya existe'
    COMMIT TRANSACTION;
END TRY 
BEGIN CATCH 
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
        THROW;
END CATCH;
GO
 
-- Crear la tabla Detalle_Venta
BEGIN TRANSACTION
BEGIN TRY
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Detalle_Venta')
    BEGIN
        CREATE TABLE Detalle_Venta (
        id_detalle INT PRIMARY KEY IDENTITY(1,1),
        id_venta INT,
        id_copia INT,
        precio_unitario DECIMAL(10,2),
        FOREIGN KEY (id_venta) REFERENCES Venta(id_venta),
        FOREIGN KEY (id_copia) REFERENCES Copia(id_copia)
        );
    END
    ELSE
        PRINT 'La tabla [dbo].[Detalle_Venta] ya existe'
    COMMIT TRANSACTION;
END TRY 
BEGIN CATCH 
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
        THROW;
END CATCH;
GO

-- Crear la tabla Prestamo
BEGIN TRANSACTION
BEGIN TRY
    IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'Prestamo')
    BEGIN
        CREATE TABLE Prestamo (
        id_prestamo INT PRIMARY KEY IDENTITY(1,1),
        id_cliente INT,
        id_copia INT,
        fecha_prestamo DATETIME DEFAULT CURRENT_TIMESTAMP,
        fecha_limite DATETIME NOT NULL,
        fecha_devolucion DATETIME,
        estado VARCHAR(20) DEFAULT 'Activo',
        FOREIGN KEY (id_cliente) REFERENCES Cliente(id_cliente),
        FOREIGN KEY (id_copia) REFERENCES Copia(id_copia)
        );
    END
    ELSE
        PRINT 'La tabla [dbo].[Prestamo] ya existe'
    COMMIT TRANSACTION;
END TRY 
BEGIN CATCH 
    IF @@TRANCOUNT > 0
        ROLLBACK TRANSACTION;
        THROW;
END CATCH;
GO