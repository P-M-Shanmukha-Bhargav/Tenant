CREATE PROCEDURE [ROM].[GetRoomDetailsByRoomId_V1]
	@RoomId UNIQUEIDENTIFIER
AS
BEGIN
	SELECT TRD.TenantUId, TRD.IsAdvancePaid, TRD.RentedOn, R.IsRentOpen, R.IsForBachelor, R.IsOccupied,
		R.MaintenanceAmount, R.RentAmount, R.AdvanceMoneyInMonths
	FROM ROM.Rooms R
	INNER JOIN ROM.TenantRoomDetails TRD ON TRD.RoomId = R.RoomId
	WHERE R.RoomId = @RoomId AND R.IsActive = 1 AND TRD.IsActive = 1
END