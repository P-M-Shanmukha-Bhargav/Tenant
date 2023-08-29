CREATE TABLE [ROM].[Rooms]
(
	[RoomId] UNIQUEIDENTIFIER NOT NULL,
	[OwnerUId] NVARCHAR(50) NOT NULL,
	[AdvanceMoneyInMonths] INT NOT NULL,
	[IsForBachelor] BIT NOT NULL,
	[IsRentOpen] BIT NOT NULL,
	[IsOccupied] BIT NOT NULL,
	[MaintenanceAmount] DECIMAL(10, 2) NOT NULL,
	[RoomNumber] NVARCHAR(10) NOT NULL,
	[RentAmount] DECIMAL(10, 2) NOT NULL,
	[RoomSize] INT NOT NULL,
	[RoomSizeTypeId] INT NOT NULL,
	[RoomTypeId] INT NOT NULL,
	[IsActive] BIT NOT NULL,
	[UpdatedDate] DATETIME NULL,
	[UpdatedBy] NVARCHAR(100) NULL,

	CONSTRAINT PK_Room_Id PRIMARY KEY(RoomId),
	CONSTRAINT FK_Room_Size_Type FOREIGN KEY(RoomSizeTypeId) REFERENCES [COM].[RoomSizeType](Id),
	CONSTRAINT FK_Room_Type FOREIGN KEY(RoomTypeId) REFERENCES [COM].[RoomType](Id),
)
