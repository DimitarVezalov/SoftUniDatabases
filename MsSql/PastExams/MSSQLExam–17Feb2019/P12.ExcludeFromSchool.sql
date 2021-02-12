CREATE PROCEDURE usp_ExcludeFromSchool(@StudentId INT)
AS 
BEGIN

	DECLARE @CurrentStudentId INT = (SELECT Id	
										FROM Students
										WHERE Id = @StudentId);

	IF(@CurrentStudentId IS NULL)
		THROW 50001, 'This school has no student with the provided id!', 1;

	DELETE FROM StudentsExams
	WHERE StudentId = @CurrentStudentId;

	DELETE FROM StudentsSubjects
	WHERE StudentId = @CurrentStudentId;

	DELETE FROM StudentsTeachers
	WHERE StudentId = @CurrentStudentId;

	DELETE FROM Students
	WHERE Id = @CurrentStudentId;
END