CREATE FUNCTION ufn_GetSalaryLevel(@salary DECIMAL(18,4)) 
RETURNS NVARCHAR(10)
AS
BEGIN

	DECLARE @SalaryLevel NVARCHAR(10);

	IF @salary < 30000
		SET @SalaryLevel = 'Low';
	ELSE IF @salary <= 50000
		SET @SalaryLevel = 'Average'
	ELSE SET @SalaryLevel = 'High'

	RETURN @SalaryLevel

END

