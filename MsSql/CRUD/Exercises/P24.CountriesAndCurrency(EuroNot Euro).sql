SELECT CountryName,
		CountryCode,
		CASE
			WHEN CurrencyCode LIKE 'EUR' THEN 'Euro'
			ELSE 'Not Euro'
		END
	FROM Countries
	ORDER BY CountryName ASC