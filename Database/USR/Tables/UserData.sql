CREATE TABLE [USR].[UserData]
(
	[UserId] INT NOT NULL IDENTITY,
    [DisplayName] NVARCHAR(100) NOT NULL, 
    [EmailId] NVARCHAR(100) NOT NULL UNIQUE,
    [MobileNumber] NVARCHAR(15) NOT NULL UNIQUE,
	[PasswordHash] VARCHAR(100) NOT NULL,
    [UserTypeId] INT NOT NULL,
    [IsActive] BIT NOT NULL,
    [UpdatedBy] INT NOT NULL,
    [UpdatedDate] DATETIME NOT NULL,

    CONSTRAINT PK_UserId PRIMARY KEY (UserId)
)

