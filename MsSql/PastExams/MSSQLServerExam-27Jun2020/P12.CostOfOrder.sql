CREATE FUNCTION udf_GetCost (@JobId INT)
RETURNS DECIMAL(18,2)
AS
BEGIN 
	
	DECLARE @Sum DECIMAL(18,2) = (
									SELECT 
											SUM(p.Price) AS [Sum]
										FROM Jobs AS j
										JOIN Orders AS o ON j.JobId = o.JobId	
										JOIN OrderParts AS op ON o.OrderId = op.OrderId
										JOIN Parts AS p ON op.PartId = p.PartId
										WHERE j.JobId = @JobId
										GROUP BY j.JobId
								 ) 

	IF (@Sum IS NULL)
		RETURN 0;

	RETURN @Sum;
END