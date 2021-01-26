SELECT ContinentCode,
	   CurrencyCode,
	   CurrencyUsage
	FROM
		(
			SELECT c.ContinentCode,
					c.CurrencyCode,
					COUNT(c.CurrencyCode) AS [CurrencyUsage],
					DENSE_RANK () OVER (PARTITION BY c.ContinentCode ORDER BY COUNT(c.CurrencyCode) DESC) AS [Rank]
				FROM Countries AS c
				GROUP BY c.ContinentCode, c.CurrencyCode
				HAVING COUNT(c.CountryCode) > 1

		 )AS CurrencyQuery
	WHERE [Rank] = 1
	
		
