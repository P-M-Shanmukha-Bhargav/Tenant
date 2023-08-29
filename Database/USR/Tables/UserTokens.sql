CREATE TABLE [USR].[UserTokens]
(
	[UserTokenId] INT NOT NULL IDENTITY,
	[UserId] INT NOT NULL,
	[RefreshToken] NVARCHAR(MAX) NOT NULL,
	[ExpiryTime] DATETIME NOT NULL,
    [IsActive] BIT NOT NULL,
    [UpdatedBy] INT NOT NULL,
    [UpdatedDate] DATETIME NOT NULL,
	
	CONSTRAINT PK_User_Token_Id PRIMARY KEY(UserTokenId),
	CONSTRAINT FK_User_Id FOREIGN KEY(UserId) REFERENCES [USR].[UserData](UserId)
)

