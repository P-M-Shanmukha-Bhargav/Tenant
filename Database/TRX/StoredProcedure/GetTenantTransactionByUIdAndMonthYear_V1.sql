CREATE PROCEDURE [TRX].[GetTenantTransactionByUIdAndMonthYear_V1]
	@TenantUID NVARCHAR(100),
	@BillMonth NVARCHAR(3),
	@BillYear INT
AS
BEGIN
	SELECT ISNULL(TA.WaterAmount, 0) + ISNULL(TA.PowerAmount, 0) + ISNULL(R.MaintenanceAmount, 0) + ISNULL(TA.OtherAmount, 0) + ISNULL(TB.PendingAmount,0) + R.RentAmount AS TotalAmount, 
	R.RentAmount, R.MaintenanceAmount, TA.WaterAmount, TA.PowerAmount, TA.OtherAmount, TB.PendingAmount,
	CASE WHEN TRD.IsAdvancePaid = 1 THEN 0 ELSE TRD.AdvancePendingAmount END AS AdvancePendingAmount,
	CAST(TB.IsAmountPaid AS INT) AS IsAmountPaid, CAST(TRD.IsBillsOwnerControl AS INT) AS IsBillsOwnerControl,
	PO.[Description] AS PaymentType, PS.[Description] AS PaymentStatus
	FROM [ROM].TenantRoomDetails TRD
	INNER JOIN ROM.Rooms R ON R.RoomId = TRD.RoomId
	LEFT JOIN TRX.TransactionAmount TA ON TA.TenantRoomDetailsId = TRD.TenantRoomDetailsId AND TA.BillMonth = @BillMonth AND TA.BillYear = @BillYear
	LEFT JOIN TRX.TransactionBills TB ON TB.TransactionAmountId = TA.TransactionAmountId
	LEFT JOIN COM.PaymentOptions PO ON PO.Id = TB.PaidOptionsId
	LEFT JOIN COM.PaymentStatus PS ON PS.Id = TB.PaymentStatusId
	WHERE TRD.TenantUId = @TenantUID
	AND TRD.IsActive = 1
END