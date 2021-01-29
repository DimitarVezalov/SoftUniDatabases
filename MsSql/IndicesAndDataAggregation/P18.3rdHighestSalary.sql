SELECT DepartmentID,
		Salary AS [ThirdHighestSalary]
		FROM 
			(
				SELECT DepartmentID,
						Salary,
					DENSE_RANK () OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS [SalaryRank]
					FROM Employees
					GROUP BY DepartmentID, Salary

			) AS SalariesRankingQuery
		WHERE SalaryRank = 3

	