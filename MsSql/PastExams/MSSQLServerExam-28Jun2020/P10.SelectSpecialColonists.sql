SELECT *
	FROM (
			SELECT tc.JobDuringJourney,
					CONCAT(c.FirstName, ' ', c.LastName) AS [FullName],
					DENSE_RANK () OVER(PARTITION BY tc.JobDuringJourney ORDER BY c.BirthDate ASC) AS [JobRank]
				FROM Colonists AS c
				JOIN TravelCards AS tc ON c.Id = tc.ColonistId
		 ) AS RankingQuery
	WHERE JobRank = 2
	
	