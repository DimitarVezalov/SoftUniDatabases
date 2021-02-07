SELECT a.Id,
		a.Email,
		c.[Name] AS [City],
		COUNT(*) AS [Trips]
	FROM Accounts AS a
	JOIN AccountsTrips AS atr ON a.Id = atr.AccountId
	JOIN Trips AS t ON atr.TripId = t.Id
	JOIN Cities AS c ON a.CityId = c.Id
	JOIN Hotels AS h ON c.Id = h.CityId
	JOIN Rooms AS r ON h.Id = r.HotelId
	WHERE t.RoomId = r.Id AND h.CityId = a.CityId
	GROUP BY a.Id, a.Email, c.[Name] 
	ORDER BY Trips DESC, A.Id ASC