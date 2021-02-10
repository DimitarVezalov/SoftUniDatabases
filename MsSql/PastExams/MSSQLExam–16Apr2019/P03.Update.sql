UPDATE Tickets
SET Price = Price + Price * 0.13
WHERE FlightId IN (
					SELECT f.Id	
						FROM Flights AS f
						JOIN Tickets AS t ON f.Id = t.FlightId
						WHERE f.Destination = 'Carlsbad'
				   )