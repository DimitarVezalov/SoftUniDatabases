SELECT TOP(10) s.FirstName AS [First Name],
		s.LastName AS [Last Name],
		CAST(AVG(se.Grade) AS DECIMAL(3,2)) AS [Grade]
	FROM Students AS s
	JOIN StudentsExams AS se ON s.Id = se.StudentId
	JOIN Exams AS e ON se.ExamId = e.Id
	GROUP BY s.FirstName, s.LastName
	ORDER BY Grade DESC, [First Name] ASC, [Last Name] ASC 