SELECT TOP(3) e.EmployeeID,
	   e.FirstName	
	FROM Employees AS e
	LEFT JOIN EmployeesProjects AS ep ON e.EmployeeID = ep.EmployeeID
	LEFT JOIN Projects AS p ON ep.ProjectID = p. ProjectID
	WHERE ep.EmployeeID IS NULL
	ORDER BY e.EmployeeID ASC