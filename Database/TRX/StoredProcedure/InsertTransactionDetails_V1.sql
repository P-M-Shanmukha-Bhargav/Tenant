CREATE PROCEDURE [TRX].[InsertTransactionDetails_V1]
	@TenantUID NVARCHAR(100),
	@BillMonth NVARCHAR(3),
	@BillYear INT,
	@PowerAmount DECIMAL(10,2),
	@OtherAmount DECIMAL(10,2),
	@WaterAmount DECIMAL(10,2),
    @IsActive BIT,
    @UpdatedBy NVARCHAR(100)
AS
BEGIN
	DECLARE @TenantRoomDetailsId INT, @TransactionAmountId INT
	IF NOT EXISTS(SELECT * from TRX.TransactionAmount TA
	INNER JOIN ROM.TenantRoomDetails TRD ON TRD.TenantRoomDetailsId = TA.TenantRoomDetailsId
	WHERE TA.BillMonth = @BillMonth AND TA.BillYear = @BillYear AND TRD.TenantUId = @TenantUID AND TRD.IsActive = 1)
		BEGIN
			SELECT @TenantRoomDetailsId = TRD.TenantRoomDetailsId from ROM.TenantRoomDetails TRD 
			WHERE TRD.TenantUId = @TenantUID AND TRD.IsActive = 1
	
			INSERT INTO [TRX].[TransactionAmount]
				   ([BillMonth],[BillYear],[TenantRoomDetailsId],[PowerAmount],[WaterAmount],[OtherAmount],[IsActive],[UpdatedDate],[UpdatedBy])
			 VALUES
				   (@BillMonth,@BillYear,@TenantRoomDetailsId,0,0,0,@IsActive,GETDATE(),@UpdatedBy)

			SELECT @TransactionAmountId = TransactionAmountId from TRX.TransactionAmount
				WHERE BillMonth = @BillMonth AND BillYear = @BillYear AND TenantRoomDetailsId = @TenantRoomDetailsId

			INSERT INTO [TRX].[TransactionBills]
				   ([TransactionBillId],[TransactionAmountId],[IsAmountPaid],[PaymentStatusId],[PaidAmount],[PendingAmount],[PaidOn],[PaidOptionsId],[PaidDesciption],[IsActive],[UpdatedDate],[UpdatedBy])
			 VALUES
				   (NEWID(),@TransactionAmountId,0,NULL,0.0,0.0,NULL,NULL,NULL,@IsActive,GETDATE(),@UpdatedBy)
		END
	--ELSE
	--	BEGIN
	--		SELECT @TenantRoomDetailsId = TRD.TenantRoomDetailsId from ROM.TenantRoomDetails TRD 
	--		WHERE TRD.TenantUId = @TenantUID AND TRD.IsActive = 1

	--		UPDATE [TRX].[TransactionAmount]
	--		SET [PowerAmount] = @PowerAmount,[WaterAmount] = @WaterAmount,[OtherAmount] = @OtherAmount
	--		WHERE BillMonth = @BillMonth AND BillYear = @BillYear AND TenantRoomDetailsId = @TenantRoomDetailsId
			
	--	END
END