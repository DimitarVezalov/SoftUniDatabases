CREATE TABLE Persons (
	PersonID INT NOT NULL,
	FirstName NVARCHAR(30) NOT NULL,
	Salary DECIMAL(9,2) NOT NULL,
	PassportID INT NOT NULL
)

CREATE TABLE Passports(
	PassportID INT PRIMARY KEY NOT NULL,
	PassportNumber VARCHAR(20) NOT NULL
)

INSERT INTO Persons (PersonID, FirstName, Salary, PassportID)
	VALUES
		(1, 'Roberto', 43300.00, 102),
		(2, 'Tom', 56100.00, 103),
		(3, 'Yana', 60200.00, 101)

INSERT INTO Passports (PassportID, PassportNumber)
	VALUES
		(101, 'N34FG21B'),
		(102, 'K65LO4R7'),
		(103, 'ZE657QP2')


ALTER TABLE Persons
ADD PRIMARY KEY (PersonID)

ALTER TABLE Persons
ADD FOREIGN KEY (PassportID) REFERENCES Passports (PassportID) 

ALTER TABLE Persons
ADD UNIQUE (PassportID) 