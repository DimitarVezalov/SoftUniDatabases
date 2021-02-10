SELECT d.[Name] AS [DistributorName],
		i.[Name] AS [IngredientName],
		p.[Name] AS [ProductName],
		AVG(f.Rate) AS [AverageRate]
 	FROM Products AS p
	JOIN Feedbacks AS f ON p.Id = f.ProductId
	JOIN ProductsIngredients AS pin ON p.Id = pin.ProductId
	JOIN Ingredients AS i ON pin.IngredientId = i.Id
	JOIN Distributors AS d ON i.DistributorId = d.Id
	GROUP BY d.Name, i.Name, p.Name
	HAVING AVG(f.Rate) BETWEEN 5 AND 8
	ORDER BY DistributorName ASC, IngredientName ASC, ProductName ASC