CREATE PROCEDURE [USR].[IsEmailOrMobileExists]
	@EmailId NVARCHAR(225),
	@MobileNumber NVARCHAR(225)
AS
BEGIN
	SELECT 
		CASE WHEN COUNT(USR2.EmailId) > 0 THEN 1 ELSE 0 END AS 'IsEmailExists', 
		CASE WHEN Count(USR3.MobileNumber) > 0 THEN 1 ELSE 0 END AS 'IsMobileExists' FROM [USR].[UserData] USR1
	LEFT OUTER JOIN [USR].[UserData] USR2 ON USR1.UserId = USR2.UserId AND USR2.EmailId = @EmailId
	LEFT OUTER JOIN [USR].[UserData] USR3 ON USR1.UserId = USR3.UserId AND USR3.MobileNumber = @MobileNumber
END