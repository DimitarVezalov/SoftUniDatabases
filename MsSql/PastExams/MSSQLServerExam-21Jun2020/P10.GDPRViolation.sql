SELECT t.Id,
		a.FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName AS [Full Name],
		ca.[Name] AS [From],
		c.[Name] AS [To],
		CASE 
			WHEN t.CancelDate IS NOT NULL THEN 'Canceled'
			ELSE CAST(DATEDIFF(DAY, t.ArrivalDate, t.ReturnDate) AS VARCHAR(50)) + ' days'
		END AS [Duration]
	FROM Trips AS t
	JOIN AccountsTrips AS atr ON t.Id = atr.TripId
	JOIN Accounts AS a ON atr.AccountId = a.Id
	JOIN Rooms AS r ON t.RoomId = r.Id
	JOIN Hotels AS h ON r.HotelId = h.Id 
	JOIN Cities AS c ON h.CityId = c.Id
	JOIN Cities AS ca ON a.CityId = ca.Id
	ORDER BY [Full Name] ASC, t.Id ASC