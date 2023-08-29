CREATE PROCEDURE [TRX].[GetTenantMonthYearTransactionByUId_V1]
	@TenantUID NVARCHAR(100)
AS
BEGIN
	SELECT 
		BillMonth, 
		BillYear
	FROM TRX.TransactionAmount TA
	INNER JOIN ROM.TenantRoomDetails TRD ON TRD.TenantRoomDetailsId = TA.TenantRoomDetailsId
	WHERE TRD.TenantUId = @TenantUID AND TRD.IsActive = 1
END