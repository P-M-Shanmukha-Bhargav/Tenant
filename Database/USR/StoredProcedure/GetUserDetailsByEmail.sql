CREATE PROCEDURE [USR].[GetUserDetailsByEmail]
	@EmailId NVARCHAR(225),
	@Password NVARCHAR(225)
AS
BEGIN
	SELECT UserId, UserTypeId, DisplayName FROM [USR].[UserData] 
	WHERE EmailId = @EmailId and PasswordHash = @Password
END