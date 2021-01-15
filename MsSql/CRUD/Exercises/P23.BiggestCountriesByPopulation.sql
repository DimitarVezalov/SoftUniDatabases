SELECT TOP(30) CountryName, [Population] FROM Countries
	WHERE ContinentCode LIKE 'EU'
	ORDER BY [Population] DESC, CountryName ASC