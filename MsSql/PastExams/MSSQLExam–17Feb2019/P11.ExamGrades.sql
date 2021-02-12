CREATE FUNCTION udf_ExamGradesToUpdate(@studentId INT, @grade DECIMAL(18,2))
RETURNS VARCHAR(100)
AS
BEGIN 

	IF(@grade > 6.00)
		RETURN 'Grade cannot be above 6.00!'
	
	DECLARE @CurrentStudentId INT = (SELECT Id	
										FROM Students
										WHERE Id = @studentId);

	IF(@CurrentStudentId IS NULL)
		RETURN 'The student with provided id does not exist in the school!'

	DECLARE @StudentName NVARCHAR(30) = (SELECT FirstName 
											FROM Students 
											WHERE Id = @CurrentStudentId);

	DECLARE @GradesCount INT = (SELECT COUNT(ss.Grade)
									FROM Students AS s 
									JOIN StudentsSubjects AS ss ON s.Id = ss.StudentId
									WHERE s.Id = @CurrentStudentId
									AND ss.Grade > @grade AND ss.Grade <= @grade + 0.50); 

	RETURN 'You have to update ' + CONVERT(VARCHAR, @GradesCount)+' grades for the student ' + @StudentName;
									
END

