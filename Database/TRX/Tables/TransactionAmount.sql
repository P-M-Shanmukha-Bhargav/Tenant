CREATE TABLE [TRX].[TransactionAmount]
(
	[TransactionAmountId] INT NOT NULL IDENTITY,
	[BillMonth] NVARCHAR(50) NOT NULL,
	[BillYear] INT NOT NULL,
	[TenantRoomDetailsId] INT NOT NULL,
	[PowerAmount] DECIMAL(10, 2) NOT NULL,
	[WaterAmount] DECIMAL(10, 2) NOT NULL,
	[OtherAmount] DECIMAL(10, 2) NOT NULL,
	[IsActive] BIT NOT NULL,
	[UpdatedDate] DATETIME NULL,
	[UpdatedBy] NVARCHAR(100) NULL,

	CONSTRAINT PK_Transaction_Amount_Id PRIMARY KEY(TransactionAmountId),
	CONSTRAINT FK_Tenant_Room_Details_Id FOREIGN KEY(TenantRoomDetailsId) REFERENCES [ROM].[TenantRoomDetails](TenantRoomDetailsId),
	
)
