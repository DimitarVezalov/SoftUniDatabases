SELECT CONCAT(FirstName, ' ', LastName) AS [CustomerName],
		PhoneNumber,
		Gender
	FROM Customers 
	WHERE Id NOT IN (
						SELECT c.Id 
							FROM Customers AS c
							JOIN Feedbacks AS f ON c.Id = f.CustomerId
					)

