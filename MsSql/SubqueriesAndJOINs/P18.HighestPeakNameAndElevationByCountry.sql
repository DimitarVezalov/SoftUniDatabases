SELECT TOP(5)
		RankQuery.Country,
		CASE
			WHEN RankQuery.[Peak Name] IS NULL THEN '(no highest peak)'
			ELSE RankQuery.[Peak Name]
		END AS [Highest Peak Name],
		CASE
			WHEN RankQuery.[Peak Elevation] IS NULL THEN 0
			ELSE RankQuery.[Peak Elevation]
		END AS [Highest Peak Elevation],
		CASE
			WHEN RankQuery.[Mountain] IS NULL THEN '(no mountain)'
			ELSE RankQuery.[Mountain]
		END
	FROM 
		(
			SELECT  c.CountryName AS [Country],
					p.PeakName AS [Peak Name],
					p.Elevation AS [Peak Elevation],
					m.MountainRange AS [Mountain],
					DENSE_RANK () OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS [PeakRank]
				FROM Countries AS c
				LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
				LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
				LEFT JOIN Peaks AS p ON m.Id = p.MountainId
				GROUP BY c.CountryName, p.PeakName, p.Elevation, m.MountainRange
		) AS RankQuery
	WHERE PeakRank = 1
	ORDER BY Country ASC, [Highest Peak Name] ASC
	