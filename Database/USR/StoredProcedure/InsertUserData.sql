CREATE PROCEDURE [USR].[InsertUserData]
	@UserId INT OUTPUT,
	@DisplayName NVARCHAR(225),
	@UserTypeId INT,
	@EmailId NVARCHAR(225),
	@MobileNumber NVARCHAR(225),
	@PasswordHash NVARCHAR(225),
	@UpdatedBy INT,
	@IsActive BIT = 0
AS
BEGIN
	INSERT INTO [USR].[UserData](
		[DisplayName],
		[UserTypeId],
		[EmailId],
		[MobileNumber],
		[PasswordHash],
		[IsActive],
		[UpdatedBy],
		[UpdatedDate])
	VALUES(
		@DisplayName,
		@UserTypeId,
		@EmailId,
		@MobileNumber,
		@PasswordHash,
		@IsActive,
		@UpdatedBy,
		GETDATE())

	SELECT @UserId = SCOPE_IDENTITY();
END