CREATE PROCEDURE [USR].[InsertUserTokens]
	@UserTokenId INT OUTPUT,
	@UserId INT,
	@RefreshToken NVARCHAR(225),
	@ExpiryTime DATETIME,
	@UpdatedBy INT,
	@IsActive BIT = 0
AS
BEGIN
	INSERT INTO [USR].[UserTokens](
		[UserId],
		[RefreshToken],
		[ExpiryTime],
		[IsActive],
		[UpdatedBy],
		[UpdatedDate])
	VALUES(
		@UserId,
		@RefreshToken,
		@ExpiryTime,
		@IsActive,
		@UpdatedBy,
		GETDATE())

	SELECT @UserTokenId = SCOPE_IDENTITY();
END