CREATE FUNCTION udf_GetColonistsCount(@PlanetName VARCHAR (30)) 
RETURNS INT
AS
BEGIN

	DECLARE @Count INT = (
							SELECT COUNT(*)
									FROM Planets AS p
									JOIN Spaceports AS s ON p.Id = s.PlanetId
									JOIN Journeys AS j ON s.Id = j.DestinationSpaceportId
									JOIN TravelCards AS tc ON j.Id = tc.JourneyId
									JOIN Colonists AS c ON tc.ColonistId = c.Id
									WHERE p.[Name] = @PlanetName
						 );

	RETURN @Count;
	
END