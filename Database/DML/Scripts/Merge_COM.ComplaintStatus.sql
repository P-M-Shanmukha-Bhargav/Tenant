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