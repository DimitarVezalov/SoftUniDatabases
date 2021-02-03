CREATE PROCEDURE usp_GetTownsStartingWith (@String NVARCHAR(30))
AS
BEGIN
	SELECT [Name]
		FROM Towns
		WHERE [Name] LIKE @String + '%'
END

EXECUTE usp_GetTownsStartingWith 'b'