CREATE PROCEDURE usp_GetEmployeesSalaryAbove35000 
AS
BEGIN
	SELECT FirstName,
			LastName
		FROM Employees
		WHERE Salary > 35000
END

EXECUTE usp_GetEmployeesSalaryAbove35000