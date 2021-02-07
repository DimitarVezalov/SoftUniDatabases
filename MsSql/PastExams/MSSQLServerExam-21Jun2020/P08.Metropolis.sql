SELECT TOP(10) c.Id,
		c.[Name] AS [City],
		c.CountryCode AS [Country],
		COUNT(*) As [Accounts]
	FROM Cities AS c
	JOIN Accounts AS a ON c.Id = a.CityId
	GROUP BY c.Id, c.[Name], CountryCode
	ORDER BY Accounts DESC