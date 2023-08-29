CREATE TABLE [ROM].[TenantRoomDetails]
(
	[TenantRoomDetailsId] INT NOT NULL IDENTITY,
	[TenantUId] NVARCHAR(50) NOT NULL,
	[RoomId] UNIQUEIDENTIFIER NOT NULL,
	[IsAdvancePaid] BIT NOT NULL,
	[AdvancePaidDate] DATETIME NOT NULL,
	[AdvancePendingAmount] DECIMAL(10, 2) NOT NULL,
	[RentPaidDate] INT NOT NULL,
	[RentedOn] DATETIME NOT NULL,
	[ExitRequestedOn] DATETIME NULL,
	[ExitApproved] BIT NOT NULL,
	[IsBillsOwnerControl] BIT NOT NULL,
	[IsActive] BIT NOT NULL,
	[UpdatedDate] DATETIME NULL,
	[UpdatedBy] NVARCHAR(100) NULL,

	
	CONSTRAINT PK_Tenant_Room_Details_Id PRIMARY KEY(TenantRoomDetailsId),
	CONSTRAINT FK_Room_Id FOREIGN KEY(RoomId) REFERENCES [ROM].[Rooms](RoomId),
)
