USE Library
GO

-- =========================================================================
-- Authors: Leslie Teresa Miranda Flores, Levi Merari Bartolo Martínez, Moisés David Ramón Esteban
-- Create Date: 2026-04-06
-- Description: Creación de Registros
-- P13R01_BD: 03CrearTablas
-- =========================================================================

-- Insertar datos para la tabla Autor
INSERT INTO Autor (nombre) VALUES
('Gabriel García Márquez'),
('Isabel Allende'),
('Jorge Luis Borges');
GO

-- Insertar datos para la tabla Libro
INSERT INTO Libro (titulo, id_autor, isbn) VALUES
('Cien años de soledad', 1, '978-84-376-0494-7'),
('La casa de los espíritus', 2, '978-84-01-35204-0'),
('Ficciones', 3, '978-84-206-3312-0');
GO

-- Insertar datos para la tabla Copia
INSERT INTO Copia (id_libro, tipo, estado, precio) VALUES
(1, 'Física', 'Disponible', 350.00),
(1, 'Física', 'Vendido', 350.00),
(2, 'Digital', 'Disponible', 150.00),
(3, 'Física', 'Prestado', 280.00);
GO

-- Insertar datos para la tabla Cliente
INSERT INTO Cliente (nombre, email, telefono) VALUES
('Carlos Ruiz', 'carlos.ruiz@email.com', '555-0101'),
('María Fernanda López', 'maria.lopez@email.com', '555-0202');

-- Insertar datos para la tabla Venta
INSERT INTO Venta (id_cliente, total) VALUES
(1, 350.00);

-- Insertar datos para la tabla Detalle_Venta
INSERT INTO Detalle_Venta (id_venta, id_copia, precio_unitario) VALUES
(1, 2, 350.00);

-- Insertar datos para la tabla Prestamo
INSERT INTO Prestamo (id_cliente, id_copia, fecha_limite, estado) VALUES
(2, 4, '2026-04-21 23:59:59', 'Activo');