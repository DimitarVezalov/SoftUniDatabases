CREATE TABLE Users(
	Id BIGINT PRIMARY KEY IDENTITY NOT NULL,
	Username VARCHAR(30) UNIQUE NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture VARBINARY(MAX) NULL
	CHECK(DATALENGTH(ProfilePicture) <= 900 * 1024),
	LastLoginTime DATETIME2 NOT NULL,
	IsDeleted BIT NOT NULL
)

INSERT INTO Users(Username,[Password], ProfilePicture, LastLoginTime, IsDeleted)
	VALUES
		('Pesho1', 'abv3730', NULL, '2020-01-10', 0),
		('Pesho11', 'absdfaxv3730', NULL, '2021-02-11', 1),
		('Pesho12', 'aklpibv3730', NULL, '2021-01-01', 0),
		('Pesho13', 'abv543s3730', NULL, '2010-05-12', 1),
		('Pesho14', 'abvaaawgh3730', NULL, '2015-09-10', 0)