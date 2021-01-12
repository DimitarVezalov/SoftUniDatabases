CREATE TABLE Categories(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	CategoryName NVARCHAR(50) NOT NULL,
	DailyRate DECIMAL(5,2) NOT NULL,
	WeeklyRate DECIMAL(7,2) NOT NULL,
	MonthlyRate DECIMAL(9,2) NOT NULL,
	WeekendRate DECIMAL(5,2) NOT NULL
)


CREATE TABLE Cars(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	PlateNumber NVARCHAR(20) NOT NULL,
	Manufacturer NVARCHAR(20) NOT NULL,
	Model NVARCHAR(30) NOT NULL,
	CarYear DATE NOT NULL,
	CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
	Doors TINYINT NOT NULL,
	Picture VARBINARY(MAX) NULL,
	Condition NVARCHAR(50) NULL,
	Available BIT NOT NULL	
)


CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(30) NOT NULL,
	LastName NVARCHAR(30) NOT NULL,
	Title NVARCHAR(30) NOT NULL,
	Notes NVARCHAR(1000) NULL
)


CREATE TABLE Customers(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	DriverLicenceNumber VARCHAR(50) NOT NULL,
	FullName NVARCHAR(50) NOT NULL,
	[Address] NVARCHAR(50) NOT NULL,
	City NVARCHAR(30) NOT NULL,
	ZIPCode VARCHAR(20) NOT NULL,
	Notes NVARCHAR(1000) NULL
)

CREATE TABLE RentalOrders(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
	CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL, 
	CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
	TankLevel NVARCHAR(20) NOT NULL,
	KilometrageStart INT NOT NULL,
	KilometrageEnd INT NOT NULL,
    TotalKilometrage AS KilometrageEnd - KilometrageStart,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL,
    TotalDays AS DATEDIFF(DAY, StartDate, EndDate),
    RateApplied DECIMAL(9, 2),
    TaxRate DECIMAL(9, 2),
    OrderStatus NVARCHAR(50),
    Notes NVARCHAR(MAX)
)


INSERT INTO Categories (CategoryName, DailyRate, WeekLyRate, MonthlyRate, WeekendRate) 
     VALUES 
		('Car', 20, 120, 500, 42.50),
        ('Bus', 250, 1600, 6000, 489.99),
        ('Truck', 500, 3000, 11900, 949.90)


INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Picture, Condition, Available) 
     VALUES 
		('123456ABCD', 'Mazda', 'CX-5', '2016', 1, 5, 123456, 'Perfect', 1),
        ('asdafof145', 'Mercedes', 'Tourismo', '2017', 2, 3, 99999, 'Perfect', 1),
        ('asdp230456', 'MAN', 'TGX', '2016', 3, 2, 123456, 'Perfect', 1)


INSERT INTO Employees (FirstName, LastName, Title, Notes) 
     VALUES 
		('Ivan', 'Ivanov', 'Seller', 'I am Ivan'),
        ('Georgi', 'Georgiev', 'Seller', 'I am Gosho'),
        ('Mitko', 'Mitkov', 'Manager', 'I am Mitko')


INSERT INTO Customers (DriverLicenceNumber, FullName, [Address], City, ZIPCode, Notes)
     VALUES 
		('123456789', 'Gogo Gogov', 'Vitoshka 15', 'Sofia', '1000', 'Good driver'),
        ('347645231', 'Mara Mareva', 'Gurko 29', 'Sofia', 'AFG4-3674', 'Bad driver'),
        ('123574322', 'Strahil Strahilov', 'Solunska 87', 'Sofia', 'KL7-895', 'Good driver')

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, StartDate, EndDate) 
     VALUES 
		(1, 1, 1, 54, 2189, 2456, '2017-11-05', '2017-11-08'),
        (2, 2, 2, 22, 13565, 14258, '2017-11-06', '2017-11-11'),
        (3, 3, 3, 180, 1202, 1964, '2017-11-09', '2017-11-12')

