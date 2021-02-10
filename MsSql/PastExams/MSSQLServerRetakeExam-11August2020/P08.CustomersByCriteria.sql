SELECT cus.FirstName,
		cus.Age,
		cus.PhoneNumber
	FROM Customers AS cus
	JOIN Countries AS c ON cus.CountryId = c.Id
	WHERE (cus.Age >= 21 AND cus.FirstName LIKE '%an%')
	OR (cus.PhoneNumber LIKE '%38' AND c.[Name] != 'Greece')
	ORDER BY cus.FirstName ASC, cus.Age DESC