CREATE FUNCTION ufn_IsWordComprised(@setOfLetters NVARCHAR(MAX), @word NVARCHAR(MAX))
RETURNS BIT
AS
BEGIN
	DECLARE @IsComprised BIT = 1;

	DECLARE @i INT = 1;

	WHILE (@i <= LEN(@word))
		BEGIN
			IF @setOfLetters LIKE '%' + SUBSTRING(@word, @i, 1) + '%'
				SET @i +=1;
			ELSE
				BEGIN
					SET @IsComprised = 0;
					BREAK	
				END
		END

	RETURN @IsComprised;
END


SELECT dbo.ufn_IsWordComprised('ohohoho', 'hoh')
 