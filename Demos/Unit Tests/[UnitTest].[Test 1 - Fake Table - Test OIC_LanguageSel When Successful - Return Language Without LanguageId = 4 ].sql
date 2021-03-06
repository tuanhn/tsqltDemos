USE [UnitTest1]
GO
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

