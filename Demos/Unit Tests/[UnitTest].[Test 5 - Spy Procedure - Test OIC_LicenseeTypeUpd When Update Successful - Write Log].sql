USE [UnitTest1]
GO
/****** Object:  StoredProcedure [UnitTest].[Test OIC_LicenseeTypeUpd: When Update Successful - Write Log]    Script Date: 6/5/2018 1:04:25 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UnitTest].[Test 5 - Spy Procedure - Test OIC_LicenseeTypeUpd When Update Successful - Write Log]
AS
BEGIN
   -- Arrange
    DECLARE @ErrCode INT
    DECLARE @ErrMsg VARCHAR(300)

    CREATE TABLE ActualLogData (
       UserId INT,
       SPName VARCHAR(MAX),
       Language VARCHAR(100),
       IP VARCHAR(100),
       Data VARCHAR(MAX)
    )

    CREATE TABLE  ExpectedLogData (
       UserId INT,
       SPName VARCHAR(MAX),
       Language VARCHAR(100),
       IP VARCHAR(100),
       Data VARCHAR(MAX)
    )

    INSERT INTO ExpectedLogData
    VALUES (1, 'OIC_LicenseeTypeUpd', 'E', '1.1.1.1', '<r lti="13" ltn="new name"/>')

    EXEC tSQLt.SpyProcedure 'OIC_LogRunSpIns';

    EXEC tSQLt.FakeTable 'LicenseeType';
    INSERT INTO LicenseeType(LicenseeTypeId, LicenseeTypeName)
    VALUES(13, 'old name');
    
    -- Act
    EXEC OIC_LicenseeTypeUpd @LicenseeTypeId = 13,
       @LicenseeTypeName = 'new name',
       @UserId = 1,
       @Language = 'E',
       @IP = '1.1.1.1',
       @ErrCode = @ErrCode output,
       @ErrMsg = @ErrMsg output    
       
     INSERT INTO ActualLogData
     SELECT UserId, SPName, Language, IP, Data
    FROM OIC_LogRunSpIns_SpyProcedureLog;  

    -- Assert
    EXEC tSQLt.AssertEqualsTable 'ExpectedLogData', 'ActualLogData';
END;
