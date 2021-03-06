USE [UnitTest1]
GO
/****** Object:  StoredProcedure [UnitTest].[Test OIC_LicenseeTypeSel: When Successful - Return Right LicenseeType ]    Script Date: 6/5/2018 2:04:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UnitTest].[Test 7 - Fake Table From A Different Database - Test OIC_LicenseeTypeSel: When Successful - Return Right LicenseeType]
AS
BEGIN
   -- Arrange    
    EXEC tSQLt.FakeTable 'dbo.LicenseeType';
    INSERT INTO dbo.LicenseeType(LicenseeTypeId, LicenseeTypeName)
    VALUES(1, 'licensee type 1'), (3, 'licensee type 3'), (2, 'licensee type 2');

    EXEC UnitTest2.tSQLt.FakeTable 'dbo.UserLicenseeType';
    INSERT INTO UnitTest2.dbo.UserLicenseeType(UserId, LicenseeTypeId, Email)
    VALUES (1, 1, '1@gmail.com'), (1, 2, '1@gmail.com');

    CREATE TABLE #Expected (
       LicenseeTypeId       INT,
       LicenseeTypeName       VARCHAR(30)
    )

    CREATE TABLE #Actual (
       LicenseeTypeId       INT,
       LicenseeTypeName       VARCHAR(30)
    )

    -- Act
    INSERT #Actual
    EXEC [dbo].[OIC_LicenseeTypeSel] @UserId = 1
    
    INSERT INTO #Expected
    VALUES (1, 'licensee type 1'), (2, 'licensee type 2');

    -- Assert
    EXEC tSQLt.AssertEqualsTable #Expected, #Actual;
END;
