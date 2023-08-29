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