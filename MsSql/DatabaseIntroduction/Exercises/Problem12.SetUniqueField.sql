ALTER TABLE Users
DROP CONSTRAINT PK_Id_Username

ALTER TABLE Users
ADD CONSTRAINT PK_UserId PRIMARY KEY (Id)

ALTER TABLE Users
ADD CONSTRAINT CHK_UsernameMinLength
CHECK(LEN([Username]) >= 3)