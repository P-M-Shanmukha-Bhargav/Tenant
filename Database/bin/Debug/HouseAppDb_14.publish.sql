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
PRINT N'Altering Table [TRX].[TransactionBills]...';


GO
ALTER TABLE [TRX].[TransactionBills] ALTER COLUMN [PaidDesciption] NVARCHAR (MAX) NULL;

ALTER TABLE [TRX].[TransactionBills] ALTER COLUMN [PaidOn] DATETIME NULL;


GO
PRINT N'Refreshing Procedure [TRX].[GetTenantTransactionByUIdAndMonthYear_V1]...';


GO
EXECUTE sp_refreshsqlmodule N'[TRX].[GetTenantTransactionByUIdAndMonthYear_V1]';


GO
PRINT N'Update complete.';


GO
