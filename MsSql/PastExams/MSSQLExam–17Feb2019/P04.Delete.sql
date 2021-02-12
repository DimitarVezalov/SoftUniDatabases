DELETE FROM StudentsTeachers 
WHERE TeacherId IN (SELECT Id 
	FROM Teachers
	WHERE Phone LIKE '%72%') 

DELETE FROM Teachers 
WHERE Id IN (SELECT Id 
	FROM Teachers
	WHERE Phone LIKE '%72%') 