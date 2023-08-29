CREATE TABLE [TRX].[TransactionBills]
(
	[TransactionBillId] UNIQUEIDENTIFIER NOT NULL,
	[TransactionAmountId] INT NOT NULL,
	[IsAmountPaid] BIT NOT NULL,
	[PaymentStatusId] INT NULL,
	[PaidAmount] DECIMAL(10, 2) NOT NULL,
	[PendingAmount] DECIMAL(10, 2) NOT NULL,
	[PaidOn] DATETIME NULL,
	[PaidOptionsId] INT NULL,
	[PaidDesciption] NVARCHAR(MAX) NULL,
	[IsActive] BIT NOT NULL,
	[UpdatedDate] DATETIME NULL,
	[UpdatedBy] NVARCHAR(100) NULL,

	CONSTRAINT PK_Transaction_Bill_Id PRIMARY KEY(TransactionBillId),
	CONSTRAINT FK_Transaction_Amount_Id FOREIGN KEY(TransactionAmountId) REFERENCES [TRX].[TransactionAmount](TransactionAmountId),
	CONSTRAINT FK_Payment_Status_Id FOREIGN KEY(PaymentStatusId) REFERENCES [COM].[PaymentStatus](Id),
	CONSTRAINT FK_Paid_Options FOREIGN KEY(PaidOptionsId) REFERENCES [COM].[PaymentOptions](Id) 
)
