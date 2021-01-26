SELECT TOP(5)
		RankQuery.CountryName,
	    RankQuery.PeakElevation AS [HighestPeakElevation],
	    RankQuery.RiverLength AS [LongestRiverLength]
	FROM
		(
			SELECT c.CountryName,
				   p.Elevation AS [PeakElevation],
				   r.[Length] AS [RiverLength],
				   DENSE_RANK () OVER (PARTITION BY c.CountryName ORDER BY p.Elevation DESC) AS [PeakRank],
				   DENSE_RANK () OVER (PARTITION BY c.CountryName ORDER BY r.[Length] DESC) AS [RiverRank]
				FROM Countries AS c
				LEFT JOIN MountainsCountries AS mc ON c.CountryCode = mc.CountryCode
				LEFT JOIN Mountains AS m ON mc.MountainId = m.Id
				LEFT JOIN Peaks AS p ON m.Id = p.MountainId
				LEFT JOIN CountriesRivers AS cr ON c.CountryCode = cr.CountryCode
				LEFT JOIN Rivers AS r ON cr.RiverId = r.Id
				GROUP BY c.CountryName, p.Elevation, r.Length
		) AS RankQuery
	WHERE RiverRank = 1 AND PeakRank = 1
	ORDER BY HighestPeakElevation DESC, LongestRiverLength DESC
	