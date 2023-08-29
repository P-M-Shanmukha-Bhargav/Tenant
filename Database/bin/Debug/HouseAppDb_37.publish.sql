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
PRINT N'Altering Procedure [TRX].[GetTenantTransactionByUIdAndMonthYear_V1]...';


GO
ALTER PROCEDURE [TRX].[GetTenantTransactionByUIdAndMonthYear_V1]
	@TenantUID NVARCHAR(100),
	@BillMonth NVARCHAR(3),
	@BillYear INT
AS
BEGIN
	SELECT ISNULL(TA.WaterAmount, 0) + ISNULL(TA.PowerAmount, 0) + ISNULL(R.MaintenanceAmount, 0) + ISNULL(TA.OtherAmount, 0) + ISNULL(TB.PendingAmount,0) + R.RentAmount AS TotalAmount, 
	R.RentAmount, R.MaintenanceAmount, TA.WaterAmount, TA.PowerAmount, TA.OtherAmount, TB.PendingAmount,
	CASE WHEN TRD.IsAdvancePaid = 1 THEN 0 ELSE TRD.AdvancePendingAmount END AS AdvancePendingAmount,
	CAST(TB.IsAmountPaid AS INT) AS IsAmountPaid, CAST(TRD.IsBillsOwnerControl AS INT) AS IsBillsOwnerControl,
	PO.[Description] AS PaymentType, PS.[Description] AS PaymentStatus
	FROM [ROM].TenantRoomDetails TRD
	INNER JOIN ROM.Rooms R ON R.RoomId = TRD.RoomId
	LEFT JOIN TRX.TransactionAmount TA ON TA.TenantRoomDetailsId = TRD.TenantRoomDetailsId AND TA.BillMonth = @BillMonth AND TA.BillYear = @BillYear
	LEFT JOIN TRX.TransactionBills TB ON TB.TransactionAmountId = TA.TransactionAmountId
	LEFT JOIN COM.PaymentOptions PO ON PO.Id = TB.PaidOptionsId
	LEFT JOIN COM.PaymentStatus PS ON PS.Id = TB.PaymentStatusId
	WHERE TRD.TenantUId = @TenantUID
	AND TRD.IsActive = 1
END
GO
PRINT N'Update complete.';


GO
