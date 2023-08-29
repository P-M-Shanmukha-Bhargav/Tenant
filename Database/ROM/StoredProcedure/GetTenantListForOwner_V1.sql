CREATE PROCEDURE [ROM].[GetTenantListForOwner_V1]
	@OwnerUId NVARCHAR(100)
AS
BEGIN
	SELECT TRD.TenantUId, R.RoomId, R.RoomNumber
	FROM ROM.Rooms R
	INNER JOIN ROM.TenantRoomDetails TRD ON TRD.RoomId = R.RoomId
	WHERE R.OwnerUId = @OwnerUId AND R.IsActive = 1 AND TRD.IsActive = 1
END