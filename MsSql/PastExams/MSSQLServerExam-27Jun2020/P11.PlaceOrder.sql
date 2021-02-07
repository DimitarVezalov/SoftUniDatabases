CREATE PROC usp_PlaceOrder @JobId int, @SerialNumber varchar(50),@Quantity int
AS
BEGIN
--- Limitations -------  
	IF NOT EXISTS (SELECT JobId FROM Jobs WHERE JobId = @JobId) 
		THROW 50013, 'Job not found!' , 1
	ELSE
		DECLARE @JobStatus varchar(11) = (SELECT [Status] FROM Jobs WHERE JobId = @JobId)

	IF @JobStatus = 'Finished'
		THROW 50011, 'This job is not active!', 1

	IF NOT EXISTS (SELECT PartId FROM Parts WHERE SerialNumber = @SerialNumber)
		THROW 50014, 'Part not found!' , 1
	ELSE
		 DECLARE @PartId int = (SELECT PartId FROM Parts WHERE SerialNumber = @SerialNumber)

	IF @Quantity <= 0 
		THROW 50012, 'Part quantity must be more than zero!', 1

	DECLARE @OrderId int
	---- if order already exists ---------
	IF EXISTS (SELECT OrderId FROM Orders WHERE JobId=@JobId AND IssueDate IS NULL)
		BEGIN
		SET @OrderId =(SELECT TOP(1) OrderId FROM Orders WHERE JobId=@JobId AND 
								IssueDate IS NULL) 
		----- if the part not in that existing order -------- 
		IF NOT EXISTS (SELECT PartId FROM OrderParts 
						WHERE OrderId = @OrderId AND PartId = @PartId)
			BEGIN 
			INSERT INTO OrderParts (OrderId,PartId,Quantity)
				VALUES (@OrderId, @PartId, @Quantity)
			END
		ELSE
		 ----- if the part already in the order --------------
			BEGIN
			UPDATE OrderParts
			SET Quantity +=@Quantity
			WHERE OrderId = @OrderId AND PartId = @PartId
			END
		END
	----- order not exists ----------
	ELSE
		BEGIN
			INSERT INTO Orders (JobId,IssueDate)
					VALUES (@JobId,NULL)
			SET @OrderId = (SELECT OrderId FROM Orders
							  WHERE JobId = @JobId AND IssueDate IS NULL)
			INSERT INTO OrderParts (OrderId,PartId,Quantity)
			VALUES (@OrderId, @PartId,@Quantity)
		END
END 