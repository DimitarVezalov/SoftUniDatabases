CREATE PROCEDURE usp_CancelFlights
AS
BEGIN

	UPDATE Flights
	SET DepartureTime = NULL, ArrivalTime = NULL
	WHERE ArrivalTime > DepartureTime

END

SELECT *
	FROM Flights 
	WHERE ArrivalTime > DepartureTime