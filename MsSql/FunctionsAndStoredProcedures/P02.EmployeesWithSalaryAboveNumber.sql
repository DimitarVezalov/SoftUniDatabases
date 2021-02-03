CREATE PROCEDURE usp_GetEmployeesSalaryAboveNumber (@Number DECIMAL(18,4))
AS
BEGIN
	SELECT FirstName,
			LastName
		FROM Employees
		WHERE Salary >= @Number
END

EXECUTE usp_GetEmployeesSalaryAboveNumber 48100