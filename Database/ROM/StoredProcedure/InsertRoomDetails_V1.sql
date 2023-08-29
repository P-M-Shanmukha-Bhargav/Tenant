CREATE PROCEDURE [ROM].[InsertRoomDetails_V1]
	@RoomId UNIQUEIDENTIFIER,
    @OwnerUId NVARCHAR(100),
    @AdvanceMoneyInMonths INT,
    @IsForBachelor BIT,
    @IsRentOpen BIT,
    @IsOccupied BIT,
    @MaintenanceAmount DECIMAL(10,2),
    @RoomNumber NVARCHAR(100),
    @RentAmount  DECIMAL(10,2),
    @RoomSize INT,
    @RoomSizeTypeId INT,
    @RoomTypeId INT,
    @IsActive BIT,
    @UpdatedBy NVARCHAR(100)
AS
BEGIN
INSERT INTO [ROM].[Rooms]
           ([RoomId]
           ,[OwnerUId]
           ,[AdvanceMoneyInMonths]
           ,[IsForBachelor]
           ,[IsRentOpen]
           ,[IsOccupied]
           ,[MaintenanceAmount]
           ,[RoomNumber]
           ,[RentAmount]
           ,[RoomSize]
           ,[RoomSizeTypeId]
           ,[RoomTypeId]
           ,[IsActive]
           ,[UpdatedDate]
           ,[UpdatedBy])
     VALUES
           (@RoomId
           ,@OwnerUId
           ,@AdvanceMoneyInMonths
           ,@IsForBachelor
           ,@IsRentOpen
           ,@IsOccupied
           ,@MaintenanceAmount
           ,@RoomNumber
           ,@RentAmount
           ,@RoomSize
           ,@RoomSizeTypeId
           ,@RoomTypeId
           ,@IsActive
           ,GETDATE()
           ,@UpdatedBy)
END