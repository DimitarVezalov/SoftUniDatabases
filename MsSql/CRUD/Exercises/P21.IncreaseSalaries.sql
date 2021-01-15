UPDATE Employees
	SET Salary = Salary + (Salary * 0.12)
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	WHERE d.[Name] LIKE 'Engineering' OR 
		  d.[Name] LIKE 'Tool Design' OR
		  d.[Name] LIKE 'Marketing' OR	 
		  d.[Name] LIKE 'Information Services'

SELECT Salary FROM Employees