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
/*
The column [TRX].[TransactionBills].[PaidAmount] on table [TRX].[TransactionBills] must be added, but the column has no default value and does not allow NULL values. If the table contains data, the ALTER script will not work. To avoid this issue you must either: add a default value to the column, mark it as allowing NULL values, or enable the generation of smart-defaults as a deployment option.
*/

IF EXISTS (select top 1 1 from [TRX].[TransactionBills])
    RAISERROR (N'Rows were detected. The schema update is terminating because data loss might occur.', 16, 127) WITH NOWAIT

GO
PRINT N'Dropping Foreign Key [TRX].[FK_Transaction_Amount_Id]...';


GO
ALTER TABLE [TRX].[TransactionBills] DROP CONSTRAINT [FK_Transaction_Amount_Id];


GO
PRINT N'Dropping Foreign Key [TRX].[FK_Paid_Options]...';


GO
ALTER TABLE [TRX].[TransactionBills] DROP CONSTRAINT [FK_Paid_Options];


GO
PRINT N'Dropping Foreign Key [TRX].[FK_Payment_Status_Id]...';


GO
ALTER TABLE [TRX].[TransactionBills] DROP CONSTRAINT [FK_Payment_Status_Id];


GO
PRINT N'Starting rebuilding table [TRX].[TransactionBills]...';


GO
BEGIN TRANSACTION;

SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;

SET XACT_ABORT ON;

CREATE TABLE [TRX].[tmp_ms_xx_TransactionBills] (
    [TransactionBillId]   UNIQUEIDENTIFIER NOT NULL,
    [TransactionAmountId] INT              NOT NULL,
    [IsAmountPaid]        BIT              NOT NULL,
    [PaymentStatusId]     INT              NULL,
    [PaidAmount]          DECIMAL (10, 2)  NOT NULL,
    [PendingAmount]       DECIMAL (10, 2)  NOT NULL,
    [PaidOn]              DATETIME         NULL,
    [PaidOptionsId]       INT              NULL,
    [PaidDesciption]      NVARCHAR (MAX)   NULL,
    [IsActive]            BIT              NOT NULL,
    [UpdatedDate]         DATETIME         NULL,
    [UpdatedBy]           NVARCHAR (100)   NULL,
    CONSTRAINT [tmp_ms_xx_constraint_PK_Transaction_Bill_Id1] PRIMARY KEY CLUSTERED ([TransactionBillId] ASC)
);

IF EXISTS (SELECT TOP 1 1 
           FROM   [TRX].[TransactionBills])
    BEGIN
        INSERT INTO [TRX].[tmp_ms_xx_TransactionBills] ([TransactionBillId], [TransactionAmountId], [IsAmountPaid], [PaymentStatusId], [PendingAmount], [PaidOn], [PaidOptionsId], [PaidDesciption], [IsActive], [UpdatedDate], [UpdatedBy])
        SELECT   [TransactionBillId],
                 [TransactionAmountId],
                 [IsAmountPaid],
                 [PaymentStatusId],
                 [PendingAmount],
                 [PaidOn],
                 [PaidOptionsId],
                 [PaidDesciption],
                 [IsActive],
                 [UpdatedDate],
                 [UpdatedBy]
        FROM     [TRX].[TransactionBills]
        ORDER BY [TransactionBillId] ASC;
    END

DROP TABLE [TRX].[TransactionBills];

EXECUTE sp_rename N'[TRX].[tmp_ms_xx_TransactionBills]', N'TransactionBills';

EXECUTE sp_rename N'[TRX].[tmp_ms_xx_constraint_PK_Transaction_Bill_Id1]', N'PK_Transaction_Bill_Id', N'OBJECT';

COMMIT TRANSACTION;

SET TRANSACTION ISOLATION LEVEL READ COMMITTED;


GO
PRINT N'Creating Foreign Key [TRX].[FK_Transaction_Amount_Id]...';


GO
ALTER TABLE [TRX].[TransactionBills] WITH NOCHECK
    ADD CONSTRAINT [FK_Transaction_Amount_Id] FOREIGN KEY ([TransactionAmountId]) REFERENCES [TRX].[TransactionAmount] ([TransactionAmountId]);


GO
PRINT N'Creating Foreign Key [TRX].[FK_Paid_Options]...';


GO
ALTER TABLE [TRX].[TransactionBills] WITH NOCHECK
    ADD CONSTRAINT [FK_Paid_Options] FOREIGN KEY ([PaidOptionsId]) REFERENCES [COM].[PaymentOptions] ([Id]);


GO
PRINT N'Creating Foreign Key [TRX].[FK_Payment_Status_Id]...';


GO
ALTER TABLE [TRX].[TransactionBills] WITH NOCHECK
    ADD CONSTRAINT [FK_Payment_Status_Id] FOREIGN KEY ([PaymentStatusId]) REFERENCES [COM].[PaymentStatus] ([Id]);


GO
PRINT N'Refreshing Procedure [TRX].[GetTenantTransactionByUIdAndMonthYear_V1]...';


GO
EXECUTE sp_refreshsqlmodule N'[TRX].[GetTenantTransactionByUIdAndMonthYear_V1]';


GO
PRINT N'Checking existing data against newly created constraints';


GO
USE [$(DatabaseName)];


GO
ALTER TABLE [TRX].[TransactionBills] WITH CHECK CHECK CONSTRAINT [FK_Transaction_Amount_Id];

ALTER TABLE [TRX].[TransactionBills] WITH CHECK CHECK CONSTRAINT [FK_Paid_Options];

ALTER TABLE [TRX].[TransactionBills] WITH CHECK CHECK CONSTRAINT [FK_Payment_Status_Id];


GO
PRINT N'Update complete.';


GO