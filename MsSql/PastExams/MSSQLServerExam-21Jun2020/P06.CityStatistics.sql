SELECT c.[Name] AS [City],
		COUNT(*) AS [Hotels]
	FROM Cities AS c
	JOIN Hotels AS h ON c.Id = h.CityId
	GROUP BY c.Name
	HAVING COUNT(*) > 0
	ORDER BY Hotels DESC, City