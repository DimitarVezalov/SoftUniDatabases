CREATE PROCEDURE usp_SearchForFiles(@fileExtension NVARCHAR(100))
AS
BEGIN 
	
	SELECT Id,
			[Name],
			CAST(Size AS VARCHAR)+'KB' AS [Size]
		FROM Files
		WHERE [Name] LIKE '%'+@fileExtension
		ORDER BY Id ASC, [Name] ASC, Size DESC


END