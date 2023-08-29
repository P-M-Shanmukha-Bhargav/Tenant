CREATE TABLE [ROM].[Complaints]
(
	[ComplaintId] INT NOT NULL IDENTITY,
	[TenantRoomDetailsId] INT NOT NULL,
	[Title] NVARCHAR(1000) NOT NULL,
	[Description] NVARCHAR(1000) NOT NULL,
	[CreateDate] DATETIME NOT NULL,
	[UpdateDate] DATETIME NOT NULL,
	[ComplaintStatusId] INT NOT NULL,
	[IsActive] BIT NOT NULL,
	[UpdatedDate] DATETIME NULL,
	[UpdatedBy] NVARCHAR(100) NULL,

	CONSTRAINT PK_Complaint_Id PRIMARY KEY(ComplaintId),
	CONSTRAINT FK_Tenant_Room_Details_Id FOREIGN KEY(TenantRoomDetailsId) REFERENCES [ROM].[TenantRoomDetails](TenantRoomDetailsId),
	CONSTRAINT FK_Complaint_Status FOREIGN KEY(ComplaintStatusId) REFERENCES [COM].[ComplaintStatus](Id) 
)
