CREATE TABLE Directors(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	DirectorName NVARCHAR(100) NOT NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE Genres(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	GenreName NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(1000) NULL 
)

CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	CategoryName NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE Movies(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	Title NVARCHAR(30) NOT NULL,
	DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
	CopyrightYear DATETIME2 NOT NULL,
	[Length] INT NOT NULL,
	GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Rating DECIMAL(3,1) NULL,
	Notes NVARCHAR(1000) NULL
)

INSERT INTO Directors(DirectorName)
	VALUES 
		('Tony Scott'),
		('Ridley Scott'),
		('Quentin Tarantino'),
		('Christopher Nolan'),
		('Martin Scorseze')

INSERT INTO Genres(GenreName)
	VALUES
		('Action'),
		('Comedy'),
		('Fantasy'),
		('Sci-fi'),
		('Thriller')

INSERT INTO Categories(CategoryName)
	VALUES
		('Adult'),
		('Kids'),
		('Mature'),
		('Gore'),
		('18+')

INSERT INTO Movies(Title, DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating)
	VALUES
		('Interstellar', 4, '2014-06-07', 176, 4, 3, 8.9),
		('Man on Fire', 1, '2005-06-07', 134, 1, 3, 8.7),
		('Pulp Fiction', 3, '2001-06-07', 166, 5, 3, 8.8),
		('Frozen', 5, '2017-06-07', 116, 3, 2, 7.0),
		('Alien', 2, '2014-06-07', 176, 4, 3, 8.9)