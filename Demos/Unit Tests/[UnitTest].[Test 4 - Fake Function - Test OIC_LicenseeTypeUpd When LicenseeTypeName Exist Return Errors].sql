USE [UnitTest1]
GO
/****** Object:  StoredProcedure [UnitTest].[Test OIC_LicenseeTypeUpd: When LicenseeTypeName Exist Return Errors ]    Script Date: 6/5/2018 1:03:59 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UnitTest].[Test 4 - Fake Function - Test OIC_LicenseeTypeUpd When LicenseeTypeName Exist Return Errors]
AS
BEGIN
    -- Arrange
    DECLARE @ErrCode INT
    DECLARE @ErrMsg VARCHAR(300)

    EXEC tSQLt.FakeTable 'LicenseeType';
    INSERT INTO LicenseeType(LicenseeTypeId, LicenseeTypeName)
    VALUES(13, 'old name');

    EXEC tSQLt.FakeFunction '[dbo].[f_Get_MsgNamebyMsgID]', '[UnitTest].[Fake_f_Get_MsgNamebyMsgID]';

    -- Act
    EXEC OIC_LicenseeTypeUpd @LicenseeTypeId = 13,
       @LicenseeTypeName = 'old name',
       @UserId = 1,
       @Language = 'E',
       @IP = '1.1.1.1',
       @ErrCode = @ErrCode output,
       @ErrMsg = @ErrMsg output


    -- Assert
    EXEC tSQLt.AssertEqualsString @ErrMsg, 'The licensee type name is already used. Please try another name.';  
END;
