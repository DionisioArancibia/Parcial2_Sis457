CREATE DATABASE Parcial2Dioai;
GO
USE [master]
GO
CREATE LOGIN [usrparcial2] WITH PASSWORD = N'12345678',
	DEFAULT_DATABASE = [Parcial2Dioai],
	CHECK_EXPIRATION = OFF,
	CHECK_POLICY = ON
GO
USE [Parcial2Dioai]
GO
CREATE USER [usrparcial2] FOR LOGIN [usrparcial2]
GO
ALTER ROLE [db_owner] ADD MEMBER [usrparcial2]
GO
DROP TABLE Serie;
GO
CREATE TABLE Serie (
  id INT NOT NULL PRIMARY KEY IDENTITY(1,1),
  titulo VARCHAR(250) NOT NULL,
  sinopsis VARCHAR(5000) NOT NULL,
  director VARCHAR(100) NOT NULL,
  episodios BIGINT NOT NULL,
  fechaEstreno DATETIME NOT NULL DEFAULT GETDATE(),
  idiomaPrincipal VARCHAR(50) NOT NULL,
  estado SMALLINT NOT NULL DEFAULT 1 -- -1: Eliminado, 0: Inactivo, 1: Activo
);
GO
CREATE PROCEDURE paSerieListar @parametro NVARCHAR(100)
AS
BEGIN
    SELECT * FROM Serie
    WHERE estado <> -1 AND titulo LIKE '%' + REPLACE(@parametro, ' ', '%') + '%'
    ORDER BY titulo;
END;
GO
ALTER PROCEDURE paSerieListar @parametro VARCHAR(50)
AS
  SELECT * FROM Serie
  WHERE estado<>-1 AND titulo LIKE '%'+REPLACE(@parametro,' ','%')+'%';
GO

-- DML
SELECT * FROM Serie WHERE estado<>-1;


-- Insertar datos de ejemplo en la tabla Serie
INSERT INTO Serie (titulo, sinopsis, director, episodios, fechaEstreno, idiomaPrincipal, estado)
VALUES 
('Breaking Bad', 'Un profesor de química se convierte en un productor de metanfetaminas.', 'Vince Gilligan', 62, '2008-01-20', 'Inglés', 1),
('Stranger Things', 'Un grupo de niños enfrenta eventos sobrenaturales en su ciudad.', 'Matt Duffer, Ross Duffer', 34, '2016-07-15', 'Inglés', 1),
('La Casa de Papel', 'Un grupo de criminales planea un gran atraco a la Fábrica Nacional de Moneda y Timbre.', 'Álex Pina', 41, '2017-05-02', 'Español', 1),
('Dark', 'Una serie alemana que explora el viaje en el tiempo y sus repercusiones familiares.', 'Baran bo Odar', 26, '2017-12-01', 'Alemán', 1),
('Game of Thrones', 'Basada en los libros de George R.R. Martin, muestra una lucha de poder en un mundo medieval.', 'David Benioff, D.B. Weiss', 73, '2011-04-17', 'Inglés', 1),
('Narcos', 'La historia del ascenso y caída del narcotraficante Pablo Escobar y el cártel de Medellín.', 'Chris Brancato, Carlo Bernard, Doug Miro', 30, '2015-08-28', 'Español', 1),
('The Witcher', 'Un cazador de monstruos intenta encontrar su lugar en un mundo plagado de criaturas y magia.', 'Lauren Schmidt Hissrich', 24, '2019-12-20', 'Inglés', 1),
('Attack on Titan', 'Los humanos luchan por sobrevivir en un mundo dominado por gigantes.', 'Tetsurō Araki', 87, '2013-04-07', 'Japonés', 1),
('Friends', 'Un grupo de amigos navega por las complicaciones de la vida y el amor en Nueva York.', 'David Crane, Marta Kauffman', 236, '1994-09-22', 'Inglés', 1),
('Money Heist: Korea', 'Versión coreana de la popular serie La Casa de Papel.', 'Kim Hong-sun', 12, '2022-06-24', 'Coreano', 1);
GO

-- Ejecutar el procedimiento almacenado de ejemplo
EXEC paSerieListar 'Casa';
GO

-- Consultar los datos insertados
SELECT * FROM Serie WHERE estado <> -1;
GO

