SELECT AccountId,
		FullName,
		MAX(TripDays) AS [LongestTrip],
		MIN(TripDays) AS [ShortestTrip]
	FROM
		(
			SELECT a.Id AS [AccountId],
					CONCAT(FirstName, ' ', LastName) AS [FullName],
					DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate) AS [TripDays]
				FROM Accounts AS a
				JOIN AccountsTrips AS act ON a.Id = act.AccountId
				JOIN Trips AS t ON act.TripId = t.Id
				WHERE a.MiddleName IS NULL AND t.CancelDate IS NULL
		) AS RankQuery
	GROUP BY AccountId, FullName
	ORDER BY LongestTrip DESC, ShortestTrip ASC