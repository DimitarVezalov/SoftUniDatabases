CREATE PROCEDURE usp_EmployeesBySalaryLevel (@SalaryLevel NVARCHAR(10))
AS
BEGIN
	SELECT FirstName,
			LastName
		FROM Employees
		WHERE dbo.ufn_GetSalaryLevel(Salary) LIKE @SalaryLevel
END

EXECUTE usp_EmployeesBySalaryLevel 'high'