CREATE PROCEDURE usp_SwitchRoom(@TripId INT, @TargetRoomId INT)
AS
BEGIN
	
	DECLARE @TripHotelId INT = (SELECT h.Id 
									FROM Trips AS t
									JOIN Rooms AS r ON t.RoomId = r.Id
									JOIN Hotels AS h ON r.HotelId = h.Id
									WHERE t.Id = @TripId);

	DECLARE @TargetRoomHotelId INT = (SELECT HotelId
											FROM Rooms
											WHERE Id = @TargetRoomId);

	IF(@TripHotelId != @TargetRoomHotelId)
		THROW 50001, 'Target room is in another hotel!', 1;
    
	DECLARE @BedsCount INT = (SELECT Beds 
									FROM Rooms
									WHERE Id = @TargetRoomId); 

	DECLARE @AccountsCount INT = (SELECT COUNT(*)
										FROM AccountsTrips
										WHERE TripId = @TripId);

	IF(@BedsCount < @AccountsCount)
		THROW 50002, 'Not enough beds in target room!', 1;

	UPDATE Trips
	SET RoomId = @TargetRoomId
	WHERE Id = @TripId

END