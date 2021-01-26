SELECT TOP(1) AverageSAlaries AS [MinAverageSalary] FROM 
	(
		SELECT AVG(Salary) AS [AverageSAlaries]
			FROM Employees
			GROUP BY DepartmentID

	) AS SalariesQuery
ORDER BY AverageSAlaries ASC


 