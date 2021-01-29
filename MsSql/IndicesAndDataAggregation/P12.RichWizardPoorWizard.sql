SELECT ABS(SUM([Difference])) AS SumDifference
	FROM
		(SELECT hw.FirstName AS [Host Wizard],
				hw.DepositAmount AS [Host Wizard Deposit],
				gw.FirstName AS [Guest Wizard],
				gw.DepositAmount AS [Guest Wizard Deposit],
				hw.DepositAmount - gw.DepositAmount AS [Difference]
			FROM WizzardDeposits AS hw
			JOIN WizzardDeposits AS gw ON hw.Id = gw.Id + 1
		) AS MainQuery