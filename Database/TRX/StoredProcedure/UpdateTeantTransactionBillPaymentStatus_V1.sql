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
	DECLARE @TenantRoomDetailsId INT, @TransactionAmountId INT

	IF NOT EXISTS(SELECT * from TRX.TransactionAmount TA
	INNER JOIN ROM.TenantRoomDetails TRD ON TRD.TenantRoomDetailsId = TA.TenantRoomDetailsId
	WHERE TA.BillMonth = @Month AND TA.BillYear = @Year AND TRD.TenantUId = @TenantId AND TRD.IsActive = 1)
		BEGIN
			SELECT @TenantRoomDetailsId = TRD.TenantRoomDetailsId from ROM.TenantRoomDetails TRD 
			WHERE TRD.TenantUId = @TenantId AND TRD.IsActive = 1
	
			INSERT INTO [TRX].[TransactionAmount]
				   ([BillMonth],[BillYear],[TenantRoomDetailsId],[PowerAmount],[WaterAmount],[OtherAmount],[IsActive],[UpdatedDate],[UpdatedBy])
			 VALUES
				   (@Month,@Year,@TenantRoomDetailsId,0,0,0,1,GETDATE(),'SYSTEM')

			SELECT @TransactionAmountId = TransactionAmountId from TRX.TransactionAmount
				WHERE BillMonth = @Month AND BillYear = @Year AND TenantRoomDetailsId = @TenantRoomDetailsId

			INSERT INTO [TRX].[TransactionBills]
				   ([TransactionBillId],[TransactionAmountId],[IsAmountPaid],[PaymentStatusId],[PaidAmount],[PendingAmount],[PaidOn],[PaidOptionsId],[PaidDesciption],[IsActive],[UpdatedDate],[UpdatedBy])
			 VALUES
				   (NEWID(),@TransactionAmountId,0,NULL,0.0,0.0,NULL,NULL,NULL,1,GETDATE(),'SYSTEM')
		END
	
	BEGIN
		UPDATE TB
		SET PaymentStatusId = @StatusId, PaidOptionsId = 1,
		UpdatedDate = GETDATE(), UpdatedBy = @TenantId
		FROM TRX.TransactionBills TB
		INNER JOIN TRX.TransactionAmount TA ON TB.TransactionAmountId = TA.TransactionAmountId
		INNER JOIN ROM.TenantRoomDetails TRD ON TRD.TenantRoomDetailsId = TA.TenantRoomDetailsId
		WHERE TRD.TenantUId = @TenantId AND TRD.IsActive = 1 AND TA.BillMonth = @Month
		AND TA.BillYear = @Year
	END
END