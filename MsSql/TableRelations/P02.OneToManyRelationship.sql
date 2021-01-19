CREATE TABLE Manufacturers(
	ManufacturerID INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] VARCHAR(30) NOT NULL,
	EstablishedOn DATE NOT NULL
)


CREATE TABLE Models(
	ModelID INT PRIMARY KEY IDENTITY(101,1) NOT NULL,
	[Name] NVARCHAR(30) NOT NULL,
	ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers (ManufacturerID)
)

INSERT INTO Manufacturers ([Name], EstablishedOn)
	VALUES 
		('BMW', '1916-04-07'),
		('Tesla', '2003-01-01'),
		('Lada', '1966-05-01')

INSERT INTO Models ([Name], ManufacturerID)
	VALUES 
		('X1', 1),
		('i6', 1),
		('Model S', 2),
		('Model X', 2),
		('Model 3', 2),
		('Nova', 3)