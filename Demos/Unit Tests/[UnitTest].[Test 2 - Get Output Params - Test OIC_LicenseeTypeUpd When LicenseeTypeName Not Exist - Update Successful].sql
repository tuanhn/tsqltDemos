USE [UnitTest1]
GO
/****** Object:  StoredProcedure [UnitTest].[Test OIC_LicenseeTypeUpd: When LicenseeTypeName Not Exist - Update Successful ]    Script Date: 6/5/2018 1:04:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UnitTest].[Test 2 - Get Output Params - Test OIC_LicenseeTypeUpd When LicenseeTypeName Not Exist - Update Successful]
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
       @LicenseeTypeName = 'new name',
       @UserId = 1,
       @Language = 'E',
       @IP = '1.1.1.1',
       @ErrCode = @ErrCode output,
       @ErrMsg = @ErrMsg output
    
    SELECT @LicenseeTypeId = LicenseeTypeId,
       @LicenseeTypeName = LicenseeTypeName
    FROM dbo.LicenseeType
    WHERE LicenseeTypeId = 13

    -- Assert
    EXEC tSQLt.AssertEqualsString @LicenseeTypeName, 'new name';
END;
