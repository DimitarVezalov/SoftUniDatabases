SELECT CONCAT(m.FirstName, ' ', m.LastName) AS [Available]
	FROM Mechanics AS m
	LEFT JOIN Jobs AS j ON  m.MechanicId = j.MechanicId
	WHERE 
		(
			SELECT COUNT(JobId)
				FROM Jobs
				WHERE [Status] != 'Finished' AND MechanicId = m.MechanicId
				GROUP BY MechanicId, [Status]
		) IS NULL
	GROUP BY CONCAT(m.FirstName, ' ', m.LastName), m.MechanicId
		

