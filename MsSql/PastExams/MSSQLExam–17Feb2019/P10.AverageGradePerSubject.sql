SELECT s.[Name],
		AVG(ss.Grade) AS [AverageGrade]
	FROM Subjects AS s
	JOIN StudentsSubjects AS ss ON s.Id = ss.SubjectId
	GROUP BY s.[Name], s.Id
	ORDER BY s.Id ASC