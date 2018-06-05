USE [UnitTest1]
GO

----

EXEC tSQLt.NewTestClass 'UnitTest'
GO

----

/****** Object:  UserDefinedFunction [UnitTest].[Fake_f_Get_MsgNamebyMsgID]    Script Date: 6/5/2018 2:35:08 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  User Defined Function dbo.f_Get_MsgNamebyMsgID    Script Date: 09/02/2015 3:30:04 PM ******/
CREATE FUNCTION [UnitTest].[Fake_f_Get_MsgNamebyMsgID]
(
    @MsgID        INT,
    @Language    NVARCHAR(5)='E' 
)
RETURNS NVARCHAR(4000) 
AS
/*
    Created by: Kathy
    Date: 2014-12-18
    Task: Get the content of message from msgID 
    DB: DBOIC/BODB_OIC 
    
    Revisions: 
    
*/
BEGIN    
    -- Return the result of the function
    RETURN    'The licensee type name is already used. Please try another name.'

END
GO

----

/****** Object:  StoredProcedure [UnitTest].[Test OIC_LanguageSel: When Successful - Return Language Without LanguageId = 4 ]    Script Date: 6/5/2018 1:03:02 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE PROCEDURE [UnitTest].[Test 1 - Fake Table - Test OIC_LanguageSel When Successful - Return Language Without LanguageId = 4 ]
AS
BEGIN
   -- Arrange      
   EXEC tSQLt.FakeTable 'dbo.Language'
   INSERT INTO dbo.Language(LanguageId, LanguageName)
   VALUES (4, 'EUR');

   CREATE TABLE #Actual (
       LanguageID       INT,
       LanguageeName       VARCHAR(30)
    )

    DECLARE @Count INT

    -- Act
    INSERT #Actual
    EXEC [dbo].[OIC_LanguageSel]

    SELECT @Count = Count(*)
    FROM #Actual
    WHERE LanguageID = 4

    -- Assert
    EXEC tSQLt.AssertEquals  0, @Count
END;

----

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


----

/****** Object:  StoredProcedure [UnitTest].[Test Constraint: LicenseeType_LicenseeTypeName_Unique ]    Script Date: 6/5/2018 12:58:39 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [UnitTest].[Test 3 - Test Constraint - Test Constraint LicenseeType_LicenseeTypeName_Unique ]
AS
BEGIN
   -- Arrange      
   EXEC tSQLt.FakeTable 'dbo.LicenseeType'   
   DECLARE @ErrorMessage NVARCHAR(MAX);

   EXEC tSQLt.ApplyConstraint 'dbo.LicenseeType', 'LicenseeType_LicenseeTypeName_Unique';

    -- Act
    BEGIN TRY
       INSERT INTO dbo.LicenseeType(LicenseeTypeName)
       VALUES ('type name 1'), ('type name 1');
    END TRY       
    BEGIN CATCH
       SET @ErrorMessage = ERROR_MESSAGE();    
    END CATCH
    
    -- Assert    
    EXEC tSQLt.AssertLike  '%Violation of UNIQUE KEY constraint ''LicenseeType_LicenseeTypeName_Unique''%', @ErrorMessage
END;

----

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

----

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

----

/****** Object:  StoredProcedure [UnitTest].[Test LA_BettingSel: When Successful - Return Betting Filtered by FromDate and ToDate ]    Script Date: 6/5/2018 1:00:13 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [UnitTest].[Test 6 - Multiple Result Sets - Test LA_BettingSel When Successful - Return Betting Filtered by FromDate and ToDate ]
AS
BEGIN
   -- Arrange      
   EXEC tSQLt.FakeTable 'dbo.rpt_Betting'
   INSERT INTO dbo.rpt_Betting(ProductID, CurrencyId, Turnover, BetCount, rptDate)
   VALUES (1, 1, 100, 10, '2018-01-01'), (1, 2, 100, 10, '2018-01-02'), (1, 2, 100, 10, '2018-01-03');

   CREATE TABLE #Actual (
	    [ProductID] [tinyint] NOT NULL,
	    [CurrencyId] [int] NOT NULL,
	    [Turnover] [money] NULL,
	    [BetCount] [int] NULL,
	    [rptDate] [datetime] NULL
    )

    CREATE TABLE #Expected (
	    [ProductID] [tinyint] NOT NULL,
	    [CurrencyId] [int] NOT NULL,
	    [Turnover] [money] NULL,
	    [BetCount] [int] NULL,
	    [rptDate] [datetime] NULL
    )

    INSERT INTO #Expected(ProductID, CurrencyId, Turnover, BetCount, rptDate)
    VALUES (1, 1, 100, 10, '2018-01-01'), (1, 2, 100, 10, '2018-01-02');
    
    -- Act
    INSERT #Actual(ProductID, CurrencyId, Turnover, BetCount, rptDate)
    EXEC tSQLt.ResultSetFilter 1, 'EXEC [dbo].[LA_BettingSel] @FromDate = ''2018-01-01'', @ToDate = ''2018-01-02''';    
    
    -- Assert
    EXEC tSQLt.AssertEqualsTable  #Expected, #Actual
END;

----

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