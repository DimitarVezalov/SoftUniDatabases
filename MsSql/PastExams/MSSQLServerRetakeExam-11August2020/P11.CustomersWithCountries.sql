CREATE VIEW v_UserWithCountries 
AS
SELECT CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
		c.Age,
		c.Gender,
		co.[Name] AS [CountryName]
	FROM Customers AS c
	JOIN Countries as co ON c.CountryId = co.Id