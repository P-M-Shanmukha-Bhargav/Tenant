CREATE PROCEDURE [ROM].[InsertRoomAddress_V1]
    @RoomAddressId INT OUTPUT,
	@RoomId	UNIQUEIDENTIFIER,
	@Address1 NVARCHAR(100),
	@Address2 NVARCHAR(100),
	@Address3 NVARCHAR(100),
	@City NVARCHAR(100),
	@State NVARCHAR(100),
	@Zip NVARCHAR(100),
    @IsActive BIT,
    @UpdatedBy NVARCHAR(100)
AS
BEGIN
INSERT INTO [ROM].[RoomAddress]
           ([RoomId]
           ,[Address1]
           ,[Address2]
           ,[Address3]
           ,[City]
           ,[State]
           ,[Zip]
           ,[IsActive]
           ,[UpdatedDate]
           ,[UpdatedBy])
     VALUES
           (@RoomId
           ,@Address1
           ,@Address2
           ,@Address3
           ,@City
           ,@State
           ,@Zip
           ,@IsActive
           ,GETDATE()
           ,@UpdatedBy)

    SELECT @RoomAddressId = SCOPE_IDENTITY();
END

