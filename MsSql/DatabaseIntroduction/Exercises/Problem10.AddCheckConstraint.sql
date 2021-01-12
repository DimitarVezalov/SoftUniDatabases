ALTER TABLE Users
ADD CONSTRAINT CHK_PasswordMinLength CHECK(LEN([Password]) >= 5)