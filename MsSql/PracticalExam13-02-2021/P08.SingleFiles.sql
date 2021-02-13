SELECT f.Id,
		f.[Name],
		CAST(f.Size AS NVARCHAR) + 'KB' AS [Size]
	FROM Files AS f
	LEFT JOIN Files AS ff ON f .Id = ff.ParentId
	WHERE ff.Id IS NULL 
	ORDER BY f.Id ASC, f.[Name] ASC, f.Size DESC