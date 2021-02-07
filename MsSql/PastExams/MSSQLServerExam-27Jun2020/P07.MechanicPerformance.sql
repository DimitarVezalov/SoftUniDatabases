SELECT Mechanic,
		AVG(DaysCount) AS [Average Days]
		FROM
			(	
				SELECT m.MechanicId,
						CONCAT(m.FirstName, ' ', m.LastName) AS [Mechanic],
						DATEDIFF(DAY, j.IssueDate, j.FinishDate) AS [DaysCount]
					FROM Mechanics AS m
					JOIN Jobs AS j ON m.MechanicId = j.MechanicId
					WHERE j.[Status] = 'Finished'
			)AS MainQuery
	GROUP BY Mechanic, MechanicId
	ORDER BY MechanicId
	
