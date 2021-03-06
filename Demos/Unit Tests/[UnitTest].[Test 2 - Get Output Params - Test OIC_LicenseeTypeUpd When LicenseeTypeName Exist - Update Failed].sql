USE [UnitTest1]
GO
/****** Object:  StoredProcedure [UnitTest].[Test 2 - Get Output Params - Test OIC_LicenseeTypeUpd When LicenseeTypeName Not Exist - Update Successful]    Script Date: 10/8/2018 3:53:26 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UnitTest].[Test 2 - Get Output Params - Test OIC_LicenseeTypeUpd When LicenseeTypeName Exist - Update Failed]
AS
BEGIN
   -- Arrange
    DECLARE @ErrCode INT
    DECLARE @ErrMsg VARCHAR(300)
    DECLARE @LicenseeTypeId INT
    DECLARE @LicenseeTypeName VARCHAR(300)

    EXEC tSQLt.FakeTable 'LicenseeType';
    INSERT INTO LicenseeType(LicenseeTypeId, LicenseeTypeName)
    VALUES(13, 'old name');

    -- Act
    EXEC OIC_LicenseeTypeUpd @LicenseeTypeId = 13,
       @LicenseeTypeName = 'old name',
       @UserId = 1,
       @Language = 'E',
       @IP = '1.1.1.1',
       @ErrCode = @ErrCode output,
       @ErrMsg = @ErrMsg output   

    -- Assert   
    EXEC tSQLt.AssertEquals @ErrCode, 100
END;
