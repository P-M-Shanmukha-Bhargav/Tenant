CREATE PROCEDURE [ROM].[InsertTenantRoomDetails_V1]
    @TenantRoomDetailsId INT OUTPUT,
	@TenantUId NVARCHAR(100),
	@RoomId UNIQUEIDENTIFIER,
	@IsAdvancePaid BIT,
	@AdvancePaidDate DATETIME,
	@AdvancePendingAmount DECIMAL(10,2),
	@RentPaidDate INT,
	@RentedOn DATETIME,
    @IsBillsOwnerControl BIT,
	@IsActive BIT,
	@UpdatedBy NVARCHAR(100)
AS
BEGIN
INSERT INTO [ROM].[TenantRoomDetails]
           ([TenantUId]
           ,[RoomId]
           ,[IsAdvancePaid]
           ,[AdvancePaidDate]
           ,[AdvancePendingAmount]
           ,[RentPaidDate]
           ,[RentedOn]
           ,[ExitRequestedOn]
           ,[ExitApproved]
           ,[IsBillsOwnerControl]
           ,[IsActive]
           ,[UpdatedDate]
           ,[UpdatedBy])
     VALUES
           (@TenantUId
           ,@RoomId
           ,@IsAdvancePaid
           ,@AdvancePaidDate
           ,@AdvancePendingAmount
           ,@RentPaidDate
           ,@RentedOn
           ,NULL
           ,0
           ,@IsBillsOwnerControl
           ,@IsActive
           ,GETDATE()
           ,@UpdatedBy)

    SELECT @TenantRoomDetailsId = SCOPE_IDENTITY();
END