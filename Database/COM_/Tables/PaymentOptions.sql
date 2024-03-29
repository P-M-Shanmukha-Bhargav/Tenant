﻿CREATE TABLE [COM].[PaymentOptions]
(
	[Id] INT NOT NULL,
	[Code] NVARCHAR(10) NOT NULL,
	[Description] NVARCHAR(100) NOT NULL,
	[IsActive] BIT NOT NULL,
	[UpdatedDate] DATETIME NULL,
	[UpdatedBy] NVARCHAR(100) NULL,

	CONSTRAINT PK_Payment_Options_Id PRIMARY KEY(Id)
)
