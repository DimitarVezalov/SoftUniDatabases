CREATE PROCEDURE usp_ChangeJourneyPurpose(@JourneyId INT, @NewPurpose VARCHAR(20))
AS
BEGIN

	DECLARE @CurrentJourneyId INT = (SELECT Id FROM Journeys WHERE Id = @JourneyId);

	IF(@CurrentJourneyId IS NULL)
		THROW 50001, 'The journey does not exist!', 1;

	DECLARE @CurrentJourneyPurpose VARCHAR(20) = (SELECT Purpose FROM Journeys WHERE Id = @JourneyId);

	IF(@CurrentJourneyPurpose = @NewPurpose)
		THROW 50002, 'You cannot change the purpose!', 1;

	UPDATE Journeys
	SET Purpose = @NewPurpose
	WHERE Id = @JourneyId;
END