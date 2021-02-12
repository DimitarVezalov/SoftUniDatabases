SELECT s.FirstName,
		s.LastName,
		COUNT(*) AS [TeachersCount]
	FROM Students AS s
	JOIN StudentsTeachers AS st ON s.Id = st.StudentId
	JOIN Teachers AS t ON st.TeacherId = t.Id
	GROUP BY s.FirstName, s.LastName