CREATE TABLE People (
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	[Name] NVARCHAR(200) NOT NULL,
	Picture VARBINARY(MAX) NULL
	CHECK(DATALENGTH(Picture) <= (1024 * 1024) * 2),
	Height DECIMAL(3,1) NULL,
	[Weight] DECIMAL(5,2) NULL,
	Gender CHAR(1) NOT NULL,
	Birthdate DATETIME2 NOT NULL,
	Biography NVARCHAR(MAX) NULL
)

INSERT INTO People([Name], Picture, Height, [Weight], Gender, Birthdate, Biography)
	VALUES
		('Pesho', NULL, 1.50, 77.67, 'm', '1959-10-10', 'kasjdlkja;sldlasdkashdilsdjj'),
		('Pesho1', NULL, 1.70, 57.67, 'f', '1989-12-05', 'kasjdlkja;askhgasghfsrd'),
		('Pesho2', NULL, 1.80, 67.67, 'm', '1985-02-10', 'kasjdlkjadgasdasdaewe35654sldlasdkashdilsdjj'),
		('Pesho3', NULL, 1.90, 98.67, 'f', '1983-11-08', NULL),
		('Pesho4', NULL, 1.60, 45.67, 'm', '1957-05-10', 'kasjdlkja;sldlasdkashdilsdjj')