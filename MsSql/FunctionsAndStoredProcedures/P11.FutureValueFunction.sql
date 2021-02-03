CREATE FUNCTION ufn_CalculateFutureValue (@Sum DECIMAL(18,4), @YearlyInterest FLOAT, @Years INT)
RETURNS DECIMAL(18,4)
AS
BEGIN

	DECLARE @FutureValue DECIMAL(18,4) = @Sum * POWER((1 + @YearlyInterest), @Years);
	RETURN @FutureValue;

END

SELECT dbo.ufn_CalculateFutureValue(1000, 10, 5)