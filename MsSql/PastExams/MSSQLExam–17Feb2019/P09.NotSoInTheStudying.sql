SELECT CONCAT(s.FirstName, ' ', ISNULL(s.MiddleName + ' ' , ''), s.LastName) AS [Full Name]
	FROM Students AS s
	LEFT JOIN StudentsSubjects AS ss ON s.Id = ss.StudentId
	LEFT JOIN Subjects AS su ON ss.SubjectId = su.Id
	WHERE su.Id IS NULL
	ORDER BY [Full Name]

