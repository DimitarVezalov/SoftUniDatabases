SELECT p.PartId,
		p.Description,
		pn.Quantity AS [Required],
		p.StockQty AS [In Stock],
		IIF(o.Delivered = 0, op.Quantity, 0) AS [Ordered]
	FROM Parts AS p
	LEFT JOIN PartsNeeded AS pn ON p.PartId = pn.PartId
	LEFT JOIN OrderParts AS op ON p.PartId = op.PartId
	LEFT JOIN Jobs AS j ON pn.JobId = j.JobId
	LEFT JOIN Orders AS o ON j.JobId = o.JobId
	WHERE j.Status != 'Finished' AND p.StockQty + 
	IIF(o.Delivered = 0, op.Quantity, 0) < pn.Quantity
	ORDER BY P.PartId ASC