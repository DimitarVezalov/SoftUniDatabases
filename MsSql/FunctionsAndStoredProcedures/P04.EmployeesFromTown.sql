CREATE PROCEDURE usp_GetEmployeesFromTown (@TownName NVARCHAR(30))
AS
BEGIN
	SELECT FirstName,
			LastName
		FROM Employees AS e
		JOIN Addresses AS a ON e.AddressID = a.AddressID
		JOIN Towns AS t ON a.TownID = t.TownID
		WHERE t.[Name] LIKE @TownName
END

EXECUTE usp_GetEmployeesFromTown 'Sofia'