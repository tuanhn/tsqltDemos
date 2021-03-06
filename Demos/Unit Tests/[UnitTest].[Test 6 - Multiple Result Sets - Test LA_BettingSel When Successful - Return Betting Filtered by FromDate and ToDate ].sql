USE [UnitTest1]
GO
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
