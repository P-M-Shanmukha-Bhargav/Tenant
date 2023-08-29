CREATE PROCEDURE [ROM].[UpdateTeantRoomExitDetails_V1]
	@TenantId NVARCHAR(100)
AS
BEGIN
	DECLARE @months INT
	SELECT @months = R.AdvanceMoneyInMonths FROM ROM.Rooms R
	INNER JOIN ROM.TenantRoomDetails TRD ON TRD.RoomId = R.RoomId
	WHERE TRD.TenantUId = @TenantId and TRD.IsActive = 1

	UPDATE ROM.TenantRoomDetails
	SET ExitRequestedOn = GETDATE(), ExitApproved = 0, 
	UpdatedDate = GETDATE(), UpdatedBy = @TenantId
	WHERE TenantUId = @TenantId and IsActive = 1
END