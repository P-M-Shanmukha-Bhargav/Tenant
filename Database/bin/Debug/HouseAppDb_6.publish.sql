﻿/*
Deployment script for HouseApp

This code was generated by a tool.
Changes to this file may cause incorrect behavior and will be lost if
the code is regenerated.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "HouseApp"
:setvar DefaultFilePrefix "HouseApp"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER19\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER19\MSSQL\DATA\"

GO
:on error exit
GO
/*
Detect SQLCMD mode and disable script execution if SQLCMD mode is not supported.
To re-enable the script after enabling SQLCMD mode, execute the following:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'SQLCMD mode must be enabled to successfully execute this script.';
        SET NOEXEC ON;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET PAGE_VERIFY NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
PRINT N'Creating Schema [COM]...';


GO
CREATE SCHEMA [COM]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating Schema [DML]...';


GO
CREATE SCHEMA [DML]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating Schema [ROM]...';


GO
CREATE SCHEMA [ROM]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating Schema [TRX]...';


GO
CREATE SCHEMA [TRX]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating Schema [USR]...';


GO
CREATE SCHEMA [USR]
    AUTHORIZATION [dbo];


GO
PRINT N'Creating Table [COM].[ComplaintStatus]...';


GO
CREATE TABLE [COM].[ComplaintStatus] (
    [Id]          INT            NOT NULL,
    [Code]        NVARCHAR (10)  NOT NULL,
    [Description] NVARCHAR (100) NOT NULL,
    [IsActive]    BIT            NOT NULL,
    [UpdatedDate] DATETIME       NULL,
    [UpdatedBy]   NVARCHAR (100) NULL,
    CONSTRAINT [PK_Complaint_Status_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [COM].[PaymentOptions]...';


GO
CREATE TABLE [COM].[PaymentOptions] (
    [Id]          INT            NOT NULL,
    [Code]        NVARCHAR (10)  NOT NULL,
    [Description] NVARCHAR (100) NOT NULL,
    [IsActive]    BIT            NOT NULL,
    [UpdatedDate] DATETIME       NULL,
    [UpdatedBy]   NVARCHAR (100) NULL,
    CONSTRAINT [PK_Payment_Options_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [COM].[PaymentStatus]...';


GO
CREATE TABLE [COM].[PaymentStatus] (
    [Id]          INT            NOT NULL,
    [Code]        NVARCHAR (10)  NOT NULL,
    [Description] NVARCHAR (100) NOT NULL,
    [IsActive]    BIT            NOT NULL,
    [UpdatedDate] DATETIME       NULL,
    [UpdatedBy]   NVARCHAR (100) NULL,
    CONSTRAINT [PK_Payment_Status_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [COM].[RoomSizeType]...';


GO
CREATE TABLE [COM].[RoomSizeType] (
    [Id]          INT            NOT NULL,
    [Code]        NVARCHAR (10)  NOT NULL,
    [Description] NVARCHAR (100) NOT NULL,
    [IsActive]    BIT            NOT NULL,
    [UpdatedDate] DATETIME       NULL,
    [UpdatedBy]   NVARCHAR (100) NULL,
    CONSTRAINT [PK_Room_Size_Type_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [COM].[RoomType]...';


GO
CREATE TABLE [COM].[RoomType] (
    [Id]          INT            NOT NULL,
    [Code]        NVARCHAR (10)  NOT NULL,
    [Description] NVARCHAR (100) NOT NULL,
    [IsActive]    BIT            NOT NULL,
    [UpdatedDate] DATETIME       NULL,
    [UpdatedBy]   NVARCHAR (100) NULL,
    CONSTRAINT [PK_Room_Type_Id] PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Creating Table [ROM].[Complaints]...';


GO
CREATE TABLE [ROM].[Complaints] (
    [ComplaintId]         INT             IDENTITY (1, 1) NOT NULL,
    [TenantRoomDetailsId] INT             NOT NULL,
    [Title]               NVARCHAR (1000) NOT NULL,
    [Description]         NVARCHAR (1000) NOT NULL,
    [CreateDate]          DATETIME        NOT NULL,
    [UpdateDate]          DATETIME        NOT NULL,
    [ComplaintStatusId]   INT             NOT NULL,
    [IsActive]            BIT             NOT NULL,
    [UpdatedDate]         DATETIME        NULL,
    [UpdatedBy]           NVARCHAR (100)  NULL,
    CONSTRAINT [PK_Complaint_Id] PRIMARY KEY CLUSTERED ([ComplaintId] ASC)
);


GO
PRINT N'Creating Table [ROM].[TenantRoomDetails]...';


GO
CREATE TABLE [ROM].[TenantRoomDetails] (
    [TenantRoomDetailsId] INT              IDENTITY (1, 1) NOT NULL,
    [TenantUId]           INT              NOT NULL,
    [RoomId]              UNIQUEIDENTIFIER NOT NULL,
    [IsAdvancePaid]       BIT              NOT NULL,
    [RentPaidDate]        INT              NOT NULL,
    [RentedOn]            DATETIME         NOT NULL,
    [IsActive]            BIT              NOT NULL,
    [UpdatedDate]         DATETIME         NULL,
    [UpdatedBy]           NVARCHAR (100)   NULL,
    CONSTRAINT [PK_Tenant_Room_Details_Id] PRIMARY KEY CLUSTERED ([TenantRoomDetailsId] ASC)
);


GO
PRINT N'Creating Table [ROM].[Rooms]...';


GO
CREATE TABLE [ROM].[Rooms] (
    [RoomId]               UNIQUEIDENTIFIER NOT NULL,
    [OwnerUId]             INT              NOT NULL,
    [AdvanceMoneyInMonths] INT              NOT NULL,
    [IsForBachelor]        BIT              NOT NULL,
    [IsRentOpen]           BIT              NOT NULL,
    [IsOccupied]           BIT              NOT NULL,
    [MaintenanceAmount]    INT              NOT NULL,
    [RoomNumber]           NVARCHAR (10)    NOT NULL,
    [RentAmount]           INT              NOT NULL,
    [RoomSize]             INT              NOT NULL,
    [RoomSizeTypeId]       INT              NOT NULL,
    [RoomTypeId]           INT              NOT NULL,
    [IsActive]             BIT              NOT NULL,
    [UpdatedDate]          DATETIME         NULL,
    [UpdatedBy]            NVARCHAR (100)   NULL,
    CONSTRAINT [PK_Room_Id] PRIMARY KEY CLUSTERED ([RoomId] ASC)
);


GO
PRINT N'Creating Table [TRX].[TransactionBills]...';


GO
CREATE TABLE [TRX].[TransactionBills] (
    [TransactionBillId]   UNIQUEIDENTIFIER NOT NULL,
    [TransactionAmountId] INT              NOT NULL,
    [IsAmountPaid]        BIT              NOT NULL,
    [PaymentStatusId]     INT              NOT NULL,
    [PendingAmount]       INT              NOT NULL,
    [PaidOn]              DATETIME         NOT NULL,
    [PaidOptionsId]       INT              NOT NULL,
    [PaidDesciption]      NVARCHAR (MAX)   NOT NULL,
    [IsActive]            BIT              NOT NULL,
    [UpdatedDate]         DATETIME         NULL,
    [UpdatedBy]           NVARCHAR (100)   NULL,
    CONSTRAINT [PK_Transaction_Bill_Id] PRIMARY KEY CLUSTERED ([TransactionBillId] ASC)
);


GO
PRINT N'Creating Table [TRX].[TransactionAmount]...';


GO
CREATE TABLE [TRX].[TransactionAmount] (
    [TransactionAmountId] INT            IDENTITY (1, 1) NOT NULL,
    [BillMonth]           INT            NOT NULL,
    [BillYear]            INT            NOT NULL,
    [TenantRoomDetailsId] INT            NOT NULL,
    [PowerAmount]         INT            NOT NULL,
    [WaterAmount]         INT            NOT NULL,
    [PreviousAmount]      INT            NOT NULL,
    [IsActive]            BIT            NOT NULL,
    [UpdatedDate]         DATETIME       NULL,
    [UpdatedBy]           NVARCHAR (100) NULL,
    CONSTRAINT [PK_Transaction_Amount_Id] PRIMARY KEY CLUSTERED ([TransactionAmountId] ASC)
);


GO
PRINT N'Creating Foreign Key [ROM].[FK_Tenant_Room_Details_Id]...';


GO
ALTER TABLE [ROM].[Complaints] WITH NOCHECK
    ADD CONSTRAINT [FK_Tenant_Room_Details_Id] FOREIGN KEY ([TenantRoomDetailsId]) REFERENCES [ROM].[TenantRoomDetails] ([TenantRoomDetailsId]);


GO
PRINT N'Creating Foreign Key [ROM].[FK_Complaint_Status]...';


GO
ALTER TABLE [ROM].[Complaints] WITH NOCHECK
    ADD CONSTRAINT [FK_Complaint_Status] FOREIGN KEY ([ComplaintStatusId]) REFERENCES [COM].[ComplaintStatus] ([Id]);


GO
PRINT N'Creating Foreign Key [ROM].[FK_Room_Id]...';


GO
ALTER TABLE [ROM].[TenantRoomDetails] WITH NOCHECK
    ADD CONSTRAINT [FK_Room_Id] FOREIGN KEY ([RoomId]) REFERENCES [ROM].[Rooms] ([RoomId]);


GO
PRINT N'Creating Foreign Key [ROM].[FK_Room_Size_Type]...';


GO
ALTER TABLE [ROM].[Rooms] WITH NOCHECK
    ADD CONSTRAINT [FK_Room_Size_Type] FOREIGN KEY ([RoomSizeTypeId]) REFERENCES [COM].[RoomSizeType] ([Id]);


GO
PRINT N'Creating Foreign Key [ROM].[FK_Room_Type]...';


GO
ALTER TABLE [ROM].[Rooms] WITH NOCHECK
    ADD CONSTRAINT [FK_Room_Type] FOREIGN KEY ([RoomTypeId]) REFERENCES [COM].[RoomType] ([Id]);


GO
PRINT N'Creating Foreign Key [TRX].[FK_Transaction_Amount_Id]...';


GO
ALTER TABLE [TRX].[TransactionBills] WITH NOCHECK
    ADD CONSTRAINT [FK_Transaction_Amount_Id] FOREIGN KEY ([TransactionAmountId]) REFERENCES [TRX].[TransactionAmount] ([TransactionAmountId]);


GO
PRINT N'Creating Foreign Key [TRX].[FK_Payment_Status_Id]...';


GO
ALTER TABLE [TRX].[TransactionBills] WITH NOCHECK
    ADD CONSTRAINT [FK_Payment_Status_Id] FOREIGN KEY ([PaymentStatusId]) REFERENCES [COM].[PaymentStatus] ([Id]);


GO
PRINT N'Creating Foreign Key [TRX].[FK_Paid_Options]...';


GO
ALTER TABLE [TRX].[TransactionBills] WITH NOCHECK
    ADD CONSTRAINT [FK_Paid_Options] FOREIGN KEY ([PaidOptionsId]) REFERENCES [COM].[PaymentOptions] ([Id]);


GO
PRINT N'Creating Foreign Key [TRX].[FK_Tenant_Room_Details_Id]...';


GO
ALTER TABLE [TRX].[TransactionAmount] WITH NOCHECK
    ADD CONSTRAINT [FK_Tenant_Room_Details_Id] FOREIGN KEY ([TenantRoomDetailsId]) REFERENCES [ROM].[TenantRoomDetails] ([TenantRoomDetailsId]);


GO
PRINT N'Creating Procedure [DML].[Merge_COM.ComplaintStatus]...';


GO
CREATE PROCEDURE [DML].[Merge_COM.ComplaintStatus]
 AS
 BEGIN
SET NOCOUNT ON

/*Initalized
Modified By - Shanmukh
Modified Date - 2023-07-18*/ 

MERGE INTO [COM].[ComplaintStatus] AS Target
USING (VALUES

(1,'PEND', 'Pending', 1, GETDATE(), NULL)


) AS Source ([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (Target.[Code] <> Source.[Code] OR Target.[Description] <> Source.[Description] OR Target.[IsActive] <> Source.[IsActive] OR Target.[UpdatedDate] <> Source.[UpdatedDate] OR Target.[UpdatedBy] <> Source.[UpdatedBy]) THEN
 UPDATE SET
 [Code] = Source.[Code], 
 [Description] = Source.[Description],
 [IsActive] = Source.[IsActive],
 [UpdatedDate] = Source.[UpdatedDate], 
 [UpdatedBy] = Source.[UpdatedBy]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
 VALUES(Source.[Id],Source.[Code],Source.[Description],Source.[IsActive],Source.[UpdatedDate],Source.[UpdatedBy])
--WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE
;
 
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [COM].[ComplaintStatus]. Rows affected: ' + CAST(@mergeCount AS nvarchar(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[COM].[ComplaintStatus] rows affected by MERGE: ' + CAST(@mergeCount AS nvarchar(100));
 END
 
SET NOCOUNT OFF
END
GO
PRINT N'Creating Procedure [DML].[Merge_COM.PaymentStatus]...';


GO
CREATE PROCEDURE [DML].[Merge_COM.PaymentStatus]
AS
 BEGIN
SET NOCOUNT ON

/*Initalized
Modified By - Shanmukh
Modified Date - 2023-07-18*/ 

MERGE INTO [COM].[PaymentStatus] AS Target
USING (VALUES

(1,'PEND', 'Pending', 1, GETDATE(), NULL)


) AS Source ([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (Target.[Code] <> Source.[Code] OR Target.[Description] <> Source.[Description] OR Target.[IsActive] <> Source.[IsActive] OR Target.[UpdatedDate] <> Source.[UpdatedDate] OR Target.[UpdatedBy] <> Source.[UpdatedBy]) THEN
 UPDATE SET
 [Code] = Source.[Code], 
 [Description] = Source.[Description],
 [IsActive] = Source.[IsActive],
 [UpdatedDate] = Source.[UpdatedDate], 
 [UpdatedBy] = Source.[UpdatedBy]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
 VALUES(Source.[Id],Source.[Code],Source.[Description],Source.[IsActive],Source.[UpdatedDate],Source.[UpdatedBy])
--WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE
;
 
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [COM].[PaymentStatus]. Rows affected: ' + CAST(@mergeCount AS nvarchar(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[COM].[PaymentStatus] rows affected by MERGE: ' + CAST(@mergeCount AS nvarchar(100));
 END
 
SET NOCOUNT OFF
END
GO
PRINT N'Creating Procedure [DML].[Merge_COM.RoomSizeType]...';


GO
CREATE PROCEDURE [DML].[Merge_COM.RoomSizeType]
AS
 BEGIN
SET NOCOUNT ON

/*Initalized
Modified By - Shanmukh
Modified Date - 2023-07-18*/ 

MERGE INTO [COM].[RoomSizeType] AS Target
USING (VALUES

(1,'SFT', 'Sq. Feet', 1, GETDATE(), NULL)


) AS Source ([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (Target.[Code] <> Source.[Code] OR Target.[Description] <> Source.[Description] OR Target.[IsActive] <> Source.[IsActive] OR Target.[UpdatedDate] <> Source.[UpdatedDate] OR Target.[UpdatedBy] <> Source.[UpdatedBy]) THEN
 UPDATE SET
 [Code] = Source.[Code], 
 [Description] = Source.[Description],
 [IsActive] = Source.[IsActive],
 [UpdatedDate] = Source.[UpdatedDate], 
 [UpdatedBy] = Source.[UpdatedBy]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
 VALUES(Source.[Id],Source.[Code],Source.[Description],Source.[IsActive],Source.[UpdatedDate],Source.[UpdatedBy])
--WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE
;
 
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [COM].[RoomSizeType]. Rows affected: ' + CAST(@mergeCount AS nvarchar(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[COM].[RoomSizeType] rows affected by MERGE: ' + CAST(@mergeCount AS nvarchar(100));
 END
 
SET NOCOUNT OFF
END
GO
PRINT N'Creating Procedure [DML].[Merge_COM.PaymentOptions]...';


GO
CREATE PROCEDURE [DML].[Merge_COM.PaymentOptions]
 AS
 BEGIN
SET NOCOUNT ON

/*Initalized
Modified By - Shanmukh
Modified Date - 2023-07-18*/ 

MERGE INTO [COM].[PaymentOptions] AS Target
USING (VALUES

(1,'CASH', 'Cash Payment', 1, GETDATE(), NULL)


) AS Source ([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (Target.[Code] <> Source.[Code] OR Target.[Description] <> Source.[Description] OR Target.[IsActive] <> Source.[IsActive] OR Target.[UpdatedDate] <> Source.[UpdatedDate] OR Target.[UpdatedBy] <> Source.[UpdatedBy]) THEN
 UPDATE SET
 [Code] = Source.[Code], 
 [Description] = Source.[Description],
 [IsActive] = Source.[IsActive],
 [UpdatedDate] = Source.[UpdatedDate], 
 [UpdatedBy] = Source.[UpdatedBy]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
 VALUES(Source.[Id],Source.[Code],Source.[Description],Source.[IsActive],Source.[UpdatedDate],Source.[UpdatedBy])
--WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE
;
 
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [COM].[PaymentOptions]. Rows affected: ' + CAST(@mergeCount AS nvarchar(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[COM].[PaymentOptions] rows affected by MERGE: ' + CAST(@mergeCount AS nvarchar(100));
 END
 
SET NOCOUNT OFF
END
GO
PRINT N'Creating Procedure [DML].[Merge_COM.RoomType]...';


GO
CREATE PROCEDURE [DML].[Merge_COM.RoomType]
AS
 BEGIN
SET NOCOUNT ON

/*Initalized
Modified By - Shanmukh
Modified Date - 2023-07-18*/ 

MERGE INTO [COM].[RoomType] AS Target
USING (VALUES

(1,'1BHK', '1 BHK', 1, GETDATE(), NULL)


) AS Source ([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
ON (Target.[Id] = Source.[Id])
WHEN MATCHED AND (Target.[Code] <> Source.[Code] OR Target.[Description] <> Source.[Description] OR Target.[IsActive] <> Source.[IsActive] OR Target.[UpdatedDate] <> Source.[UpdatedDate] OR Target.[UpdatedBy] <> Source.[UpdatedBy]) THEN
 UPDATE SET
 [Code] = Source.[Code], 
 [Description] = Source.[Description],
 [IsActive] = Source.[IsActive],
 [UpdatedDate] = Source.[UpdatedDate], 
 [UpdatedBy] = Source.[UpdatedBy]
WHEN NOT MATCHED BY TARGET THEN
 INSERT([Id],[Code],[Description],[IsActive],[UpdatedDate],[UpdatedBy])
 VALUES(Source.[Id],Source.[Code],Source.[Description],Source.[IsActive],Source.[UpdatedDate],Source.[UpdatedBy])
--WHEN NOT MATCHED BY SOURCE THEN 
-- DELETE
;
 
DECLARE @mergeError int
 , @mergeCount int
SELECT @mergeError = @@ERROR, @mergeCount = @@ROWCOUNT
IF @mergeError != 0
 BEGIN
 PRINT 'ERROR OCCURRED IN MERGE FOR [COM].[RoomType]. Rows affected: ' + CAST(@mergeCount AS nvarchar(100)); -- SQL should always return zero rows affected
 END
ELSE
 BEGIN
 PRINT '[COM].[RoomType] rows affected by MERGE: ' + CAST(@mergeCount AS nvarchar(100));
 END
 
SET NOCOUNT OFF
END
GO
PRINT N'Creating Procedure [DML].[Merge_RunAllScripts]...';


GO
CREATE PROCEDURE [DML].[Merge_RunAllScripts]
AS

     EXEC [DML].[Merge_COM.ComplaintStatus]
	 PRINT 'Executed [DML].[Merge_COM.ComplaintStatus] successfully'
	 
     EXEC [DML].[Merge_COM.PaymentOptions]
	 PRINT 'Executed [DML].[Merge_COM.PaymentOptions] successfully'
	 
     EXEC [DML].[Merge_COM.PaymentStatus]
	 PRINT 'Executed [DML].[Merge_COM.PaymentStatus] successfully'
	 
     EXEC [DML].[Merge_COM.RoomSizeType]
	 PRINT 'Executed [DML].[Merge_COM.RoomSizeType] successfully'
	 
     EXEC [DML].[Merge_COM.RoomType]
	 PRINT 'Executed [DML].[Merge_COM.RoomType] successfully'

RETURN 0
GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [ROM].[Complaints] WITH CHECK CHECK CONSTRAINT [FK_Tenant_Room_Details_Id];

ALTER TABLE [ROM].[Complaints] WITH CHECK CHECK CONSTRAINT [FK_Complaint_Status];

ALTER TABLE [ROM].[TenantRoomDetails] WITH CHECK CHECK CONSTRAINT [FK_Room_Id];

ALTER TABLE [ROM].[Rooms] WITH CHECK CHECK CONSTRAINT [FK_Room_Size_Type];

ALTER TABLE [ROM].[Rooms] WITH CHECK CHECK CONSTRAINT [FK_Room_Type];

ALTER TABLE [TRX].[TransactionBills] WITH CHECK CHECK CONSTRAINT [FK_Transaction_Amount_Id];

ALTER TABLE [TRX].[TransactionBills] WITH CHECK CHECK CONSTRAINT [FK_Payment_Status_Id];

ALTER TABLE [TRX].[TransactionBills] WITH CHECK CHECK CONSTRAINT [FK_Paid_Options];

ALTER TABLE [TRX].[TransactionAmount] WITH CHECK CHECK CONSTRAINT [FK_Tenant_Room_Details_Id];


GO
PRINT N'Update complete.';


GO