CREATE PROCEDURE [TRX].[UpdateTeantTransactionBillPaymentStatus_V1]
	@TenantId NVARCHAR(100),
	@PaymentStatus NVARCHAR(100),
	@Month NVARCHAR(3),
	@Year INT
AS
BEGIN
	DECLARE @StatusId INT

	SELECT @StatusId = PS.Id 
	FROM COM.PaymentStatus PS
	WHERE PS.Code = @PaymentStatus

	UPDATE TB
	SET PaymentStatusId = @StatusId, PaidOptionsId = 1,
	UpdatedDate = GETDATE(), UpdatedBy = @TenantId
	FROM TRX.TransactionBills TB
	INNER JOIN TRX.TransactionAmount TA ON TB.TransactionAmountId = TA.TransactionAmountId
	INNER JOIN ROM.TenantRoomDetails TRD ON TRD.TenantRoomDetailsId = TA.TenantRoomDetailsId
	WHERE TRD.TenantUId = @TenantId AND TRD.IsActive = 1 AND TA.BillMonth = @Month
	AND TA.BillYear = @Year
END