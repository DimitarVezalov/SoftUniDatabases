SELECT p.FirstName AS [First Name],
		p.LastName AS [Last Name],
		p.Age
	FROM Passengers AS p
	LEFT JOIN Tickets AS t ON p.Id = t.PassengerId
	WHERE t.Id IS NULL
	ORDER BY p.Age DESC, p.FirstName ASC, p.LastName ASC