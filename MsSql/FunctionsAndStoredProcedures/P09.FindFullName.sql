CREATE PROCEDURE usp_GetHoldersFullName
AS
BEGIN
	SELECT FirstName + ' ' + LastName AS [Full Name] 
		FROM AccountHolders
END

EXECUTE usp_GetHoldersFullName