CREATE TRIGGER Tr_DeleteProducts
ON dbo.Products
INSTEAD OF DELETE
AS
	DECLARE @ProductId INT = (SELECT p.Id
								FROM Products AS p
								JOIN deleted AS d ON p.Id = d.Id) 

	DELETE FROM ProductsIngredients 
	WHERE ProductId = @ProductId

	DELETE FROM Feedbacks 
	WHERE ProductId = @ProductId

	DELETE FROM Products 
	WHERE Id = @ProductId