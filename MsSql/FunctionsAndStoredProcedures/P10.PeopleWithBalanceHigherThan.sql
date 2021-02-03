CREATE PROCEDURE usp_GetHoldersWithBalanceHigherThan(@Balance MONEY)
AS
BEGIN
	SELECT
			FirstName,
			LastName
		FROM
			(
				SELECT ah.Id AS [Account Holder ID],
						ah.FirstName,
						ah.LastName,
					SUM(Balance) AS [Balance Sum]
					FROM AccountHolders AS ah
					JOIN Accounts AS a ON ah.Id = a.AccountHolderId 
					GROUP BY ah.FirstName, ah.LastName, ah.Id
			)AS BalanceSumQuery
		WHERE [Balance Sum] > @Balance
		ORDER BY FirstName ASC, LastName ASC
END

EXECUTE usp_GetHoldersWithBalanceHigherThan 30000