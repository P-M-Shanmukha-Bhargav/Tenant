CREATE PROCEDURE [USR].[GetUserDetailsByRefreshToken]
	@RefreshToken NVARCHAR(225),
	@UserId INT
AS
BEGIN
	SELECT U.EmailId, U.PasswordHash FROM [USR].[UserTokens] UT
	INNER JOIN [USR].[UserData] U ON U.UserId = UT.UserId
	WHERE UT.RefreshToken = @RefreshToken AND UT.UserId = @UserId
END