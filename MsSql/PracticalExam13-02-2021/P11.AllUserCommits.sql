CREATE FUNCTION udf_AllUserCommits(@username NVARCHAR(50))
RETURNS INT
AS
BEGIN

	DECLARE @CommitsCount INT = (
									SELECT
											COUNT(c.Id) AS [count]
										FROM Users AS u
										LEFT JOIN Commits AS c ON u.Id = c.ContributorId
										WHERE u.Username = @username
										GROUP BY u.Username
								);

	IF(@CommitsCount IS NULL)
		RETURN 0;

	RETURN @CommitsCount;

END
