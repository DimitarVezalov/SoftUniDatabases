SELECT TOP(2) DepositGroup
	FROM
		(
			SELECT DepositGroup,
					AVG(MagicWandSize) AS [AvgSize]
				FROM WizzardDeposits
				GROUP BY DepositGroup
		) AS GroupQuery
	ORDER BY AvgSize ASC
	