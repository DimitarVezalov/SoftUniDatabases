SELECT TOP(50)
	   e.EmployeeID,
	   e.FirstName + ' ' + e.LastName AS [EmployeeName],
	   me.FirstName + ' ' + me.LastName AS [ManagerName],
	   d.[Name] AS [DepartmentName]
	FROM Employees AS e
	JOIN Employees AS me ON e.ManagerID = me.EmployeeID
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	ORDER BY e.EmployeeID