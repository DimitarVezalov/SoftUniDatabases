CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Title NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE Customers(
	AccountNumber BIGINT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	PhoneNumber VARCHAR(30) NOT NULL,
	EmergencyName NVARCHAR(30) NULL,
	EmergencyNumber VARCHAR(30) NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE RoomStatus(
	RoomStatus NVARCHAR(30) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE RoomTypes(
	RoomType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE BedTypes(
	BedType NVARCHAR(50) PRIMARY KEY NOT NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE Rooms(
	RoomNumber INT PRIMARY KEY IDENTITY NOT NULL,
	RoomType NVARCHAR(50) FOREIGN KEY REFERENCES RoomTypes(RoomType) NOT NULL,
	BedType NVARCHAR(50) FOREIGN KEY REFERENCES BedTypes(BedType) NOT NULL,
	Rate DECIMAL(18,2) NOT NULL,
	RoomStatus NVARCHAR(30) FOREIGN KEY REFERENCES RoomStatus(RoomStatus) NOT NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE Payments(
	Id BIGINT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	PaymentDate DATETIME2 NOT NULL,
	AccountNumber BIGINT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	FirstDateOccupied DATETIME2 NOT NULL,
	LastDateOccupied DATETIME2 NOT NULL,
	TotalDays AS DATEDIFF(DAY, LastDateOccupied, FirstDateOccupied),
	AmountCharged DECIMAL(18,2) NOT NULL,
	TaxRate DECIMAL(18,2) NULL,
	TaxAmount DECIMAL(18,2) NULL,
	PaymentTotal DECIMAL(18,2) NULL,
	Notes NVARCHAR(1000) NULl
)

CREATE TABLE Occupancies(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	DateOccupied DATETIME2 NOT NULL,
	AccountNumber BIGINT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
	RoomNumber INT FOREIGN KEY REFERENCES Rooms(RoomNumber) NOT NULL,
	RateApplied DECIMAL(18,2) NOT NULL,
	PhoneCharge DECIMAL(18,2) NULL,
	Notes NVARCHAR(1000) NULL
)

INSERT INTO Employees (FirstName, LastName, Title, Notes) 
     VALUES 
		('Ivan', 'Ivanov', 'Receptionist', 'I am Ivan'),
        ('Martin', 'Martinov', 'Technical support', 'I am Martin'),
        ('Mara', 'Mareva', 'Cleaner', 'I am Marcheto')

INSERT INTO Customers (FirstName, LastName, PhoneNumber, EmergencyNumber)
     VALUES 
		('Pesho', 'Peshov', '+395883333333', '123'),
        ('Gosho', 'Goshov', '+395882222222', '123'),
        ('Kosio', 'Kosiov', '+395888888888', '123')

INSERT INTO RoomStatus (RoomStatus, Notes) 
     VALUES 
		('Clean', 'The room is clean.'),
        ('Dirty', 'The room is dirty.'),
        ('Repair', 'The room is for repair.')

INSERT INTO RoomTypes (RoomType, Notes)
     VALUES
		('Small', 'Room with one bed'),
        ('Medium', 'Room with two beds'),
        ('Large', 'Room with three beds')

INSERT INTO BedTypes (BedType)
     VALUES 
		('Normal'),
        ('Comfort'),
        ('VIP')

INSERT INTO Rooms (RoomType, BedType, Rate, RoomStatus)
     VALUES 
		('Small', 'Normal', 50, 'Dirty'),
        ('Medium', 'Comfort', 70, 'Clean'),
        ('Large', 'VIP', 100, 'Repair')


INSERT INTO Payments(EmployeeId, PaymentDate, AccountNumber, FirstDateOccupied, LastDateOccupied, AmountCharged, TaxRate)
     VALUES (1, '2015-05-06', 1, '2015-06-18', '2015-07-03', 1256.33, 166.23),
            (2, '2017-10-11', 2, '2017-10-12', '2017-10-22', 556, 125.95),
            (3, '2017-10-26', 3, '2017-11-09', '2017-11-11', 146.74, 100)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, RoomNumber, RateApplied)
     VALUES (1,'2010-02-09', 1, 1, 55.55),
            (2,'2018-09-09', 2, 2, 44.44),
            (3,'2020-07-07', 3, 3, 33.33)












