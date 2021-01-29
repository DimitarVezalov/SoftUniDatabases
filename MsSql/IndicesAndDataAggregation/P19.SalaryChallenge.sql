SELECT TOP(10)
		e.FirstName,
		e.LastName,
		e.DepartmentID
	FROM Employees AS e
	JOIN (
			SELECT DepartmentID,
					AVG(Salary) AS [DeptAvgSalary]
				FROM Employees
				GROUP BY DepartmentID 
		 ) AS avgT ON e.DepartmentID = avgT.DepartmentID 
	WHERE Salary > avgT.DeptAvgSalary
	ORDER BY DepartmentID

