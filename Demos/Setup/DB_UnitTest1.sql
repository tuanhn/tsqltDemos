USE [UnitTest1]
GO

/****** Object:  Table [dbo].[Language]    Script Date: 6/5/2018 2:22:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[Language](
	[LanguageId] [tinyint] IDENTITY(1,1) NOT NULL,
	[LanguageName] [varchar](50) NULL,
 CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED 
(
	[LanguageId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

----

/****** Object:  Table [dbo].[LicenseeType]    Script Date: 6/5/2018 2:23:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[LicenseeType](
	[LicenseeTypeId] [tinyint] IDENTITY(1,1) NOT NULL,
	[LicenseeTypeName] [varchar](30) NULL,
 CONSTRAINT [PK_LicenseeType] PRIMARY KEY CLUSTERED 
(
	[LicenseeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
 CONSTRAINT [LicenseeType_LicenseeTypeName_Unique] UNIQUE NONCLUSTERED 
(
	[LicenseeTypeName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

----

/****** Object:  Table [dbo].[LogAction]    Script Date: 6/5/2018 2:23:40 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[LogAction](
	[LogActionId] [int] NOT NULL,
	[LogActionTypeId] [tinyint] NOT NULL,
	[SPName] [varchar](50) NOT NULL,
	[ActionNameEn] [varchar](50) NOT NULL,
	[Item] [varchar](1000) NULL,
	[SubItem] [varchar](1000) NULL,
	[Enable] [bit] NULL,
	[Order] [int] NULL,
 CONSTRAINT [PK_LogAction] PRIMARY KEY CLUSTERED 
(
	[LogActionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO

ALTER TABLE [dbo].[LogAction] ADD  DEFAULT ((0)) FOR [Enable]
GO

----

/****** Object:  Table [dbo].[MessageError]    Script Date: 6/5/2018 2:23:57 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[MessageError](
	[MessageErrorId] [int] NOT NULL,
	[MessageErrorGroupId] [tinyint] NOT NULL,
	[ContentEn] [varchar](300) NULL,
 CONSTRAINT [PK_MessageError] PRIMARY KEY CLUSTERED 
(
	[MessageErrorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


----


/****** Object:  Table [dbo].[rpt_Betting]    Script Date: 6/5/2018 2:45:10 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[rpt_Betting](
	[ProductID] [tinyint] NOT NULL,
	[CurrencyId] [int] NOT NULL,
	[Turnover] [money] NULL,
	[BetCount] [int] NULL,
	[rptDate] [datetime] NULL
) ON [PRIMARY]

GO


----

/****** Object:  Table [dbo].[UserLicenseeType]    Script Date: 6/5/2018 2:24:17 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserLicenseeType](
	[UserId] [int] NOT NULL,
	[LicenseeTypeId] [tinyint] NOT NULL,
	[Email] [varchar](50) NULL,
 CONSTRAINT [PK_UserLicenseeType] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LicenseeTypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


----

/****** Object:  Table [dbo].[UserLog_RunSP]    Script Date: 6/5/2018 2:24:34 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

SET ANSI_PADDING ON
GO

CREATE TABLE [dbo].[UserLog_RunSP](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NULL,
	[LogActionId] [int] NULL,
	[IP] [varchar](50) NULL,
	[LogDate] [datetime] NULL,
	[Duration] [int] NULL,
 CONSTRAINT [PK_UserLog_RunSP] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

SET ANSI_PADDING OFF
GO


----

/****** Object:  Table [dbo].[UserLog_RunSP_Detail]    Script Date: 6/5/2018 2:25:06 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[UserLog_RunSP_Detail](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[LogActionId] [int] NULL,
	[Data] [nvarchar](max) NULL,
	[OldData] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserLog_RunSP_Detail] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO


----


/****** Object:  StoredProcedure [dbo].[LA_BettingSel]    Script Date: 6/5/2018 2:45:52 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[LA_BettingSel]
    @FromDate			DATETIME,
    @ToDate			DATETIME
AS

/*
    Created by: Dom
    Date: 2014-12-18
    Task: Get language list [Redmine:#27752]
    DB: DBOIC.bodb_OIC
    
    Revisions:
        - 20160826@Percy: Remove Other Language (ID = 4) [RedmineID: #62883]
        
 */

BEGIN
    CREATE TABLE #Data(	
	    [ProductID] [tinyint] NOT NULL,
	    [CurrencyId] [int] NOT NULL,
	    [Turnover] [money] NULL,
	    [BetCount] [int] NULL,
	    [rptDate] [datetime] NULL	
    ) 

    CREATE TABLE #GrandTotal(	
	    [CurrencyId] [int] NOT NULL,
	    [Turnover] [money] NULL,
	    [BetCount] [int] NULL
    ) 

    INSERT INTO #Data(ProductID, CurrencyId, Turnover, BetCount, rptDate)
    SELECT ProductID, CurrencyId, Turnover, BetCount, rptDate
    FROM dbo.rpt_Betting
    WHERE rptDate Between @FromDate AND @ToDate

    INSERT INTO #GrandTotal (CurrencyId, Turnover, BetCount)
    SELECT CurrencyId, SUM (Turnover), SUM(BetCount)
    FROM #Data
    GROUP BY CurrencyId

    SELECT * FROM #Data
    SELECT * FROM #GrandTotal

    DROP TABLE #Data
    DROP TABLE #GrandTotal
END

----

/****** Object:  StoredProcedure [dbo].[OIC_LanguageSel]    Script Date: 6/5/2018 2:26:19 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

/****** Object:  Stored Procedure dbo.OIC_LanguageSel    Script Date: 8/26/2016 3:35:35 PM ******/

create PROCEDURE [dbo].[OIC_LanguageSel]
AS

/*
    Created by: Dom
    Date: 2014-12-18
    Task: Get language list [Redmine:#27752]
    DB: DBOIC.bodb_OIC
    
    Revisions:
        - 20160826@Percy: Remove Other Language (ID = 4) [RedmineID: #62883]
        
 */

BEGIN
    SET NOCOUNT ON
    SELECT LanguageId
        ,LanguageName
    FROM dbo.[Language] WITH(NOLOCK)
    WHERE LanguageId <> 4
    ORDER BY LanguageName
END

GO


----

/****** Object:  StoredProcedure [dbo].[OIC_LicenseeTypeSel]    Script Date: 6/5/2018 2:26:30 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



CREATE PROCEDURE [dbo].[OIC_LicenseeTypeSel]
    @UserId        INT    = 0
AS

/*
    Created by: Dom
    Date: 2014-12-18
    Task: Get Licensee Type belong to User [Redmine:#27752]
    DB: DBOIC.bodb_OIC
    
    Revisions:
        - 20160823@Percy: Sort TOL by Id [RedmineID: #62883]
        
    Param's Explanation:
    *@UserId: 0 - show all LicenseeType without userid
 */

BEGIN
    SET NOCOUNT ON;

    SELECT lt.LicenseeTypeId
        ,lt.LicenseeTypeName  AS TypeName
    FROM dbo.LicenseeType lt WITH(NOLOCK)
    WHERE @UserId = 0 OR lt.LicenseeTypeId IN (SELECT ul.LicenseeTypeId
                                FROM UnitTest2.dbo.UserLicenseeType ul WITH(NOLOCK)
                                WHERE ul.UserId = @UserId)
    ORDER BY lt.LicenseeTypeId
END


GO


----

/****** Object:  StoredProcedure [dbo].[OIC_LicenseeTypeUpd]    Script Date: 6/5/2018 2:26:41 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



create PROCEDURE [dbo].[OIC_LicenseeTypeUpd]
    @LicenseeTypeId            TINYINT
    ,@LicenseeTypeName        VARCHAR(30)
    ,@UserId                INT
    ,@Language                VARCHAR(10)        = 'E'
    ,@IP                    VARCHAR(50)        = NULL
    ,@ErrCode                INT                = 0            OUTPUT
    ,@ErrMsg                VARCHAR(300)    = NULL        OUTPUT
AS
/*
    Created by: Kathy
    Date: 201501001
    Task: update TOL [Redmine:#44251]
    DB: DBOIC.bodb_OIC
    
    Revisions:
        
*/
BEGIN
    SET NOCOUNT ON
    
    -- For write log
    DECLARE
        @startRun        DATETIME
        ,@endRun        DATETIME
        ,@duration        INT
        ,@logSPData        NVARCHAR(MAX)
        ,@logSPOlddata    NVARCHAR(MAX)
        ,@xml            XML
        ,@procName        VARCHAR(200)

    SET @startRun = GETDATE()
    
    IF EXISTS (SELECT TOP 1 1 FROM dbo.LicenseeType WITH(NOLOCK) WHERE LicenseeTypeName = @LicenseeTypeName)
    BEGIN
        SELECT    @ErrCode = 100
                ,@ErrMsg = [dbo].[f_Get_MsgNamebyMsgID](30003, @Language) -- The licensee type name is already used. Please try another name.
        RETURN
    END        
    
    -- get old data
    SET @xml = (
        SELECT    LicenseeTypeId        AS '@lti'
                ,LicenseeTypeName    AS '@ltn'
        FROM    dbo.LicenseeType WITH(NOLOCK)
        WHERE    LicenseeTypeId = @LicenseeTypeId
        FOR XML PATH('r'), TYPE
        )    
        
    SELECT @logSPOlddata = CONVERT(NVARCHAR(MAX), @xml)
    
    BEGIN TRY
        UPDATE    dbo.LicenseeType WITH(ROWLOCK, UPDLOCK)
            SET    LicenseeTypeName = @LicenseeTypeName
        WHERE    LicenseeTypeId = @LicenseeTypeId    
    END TRY
    BEGIN CATCH
        SELECT    @ErrCode = 101
                ,@ErrMsg = [dbo].[f_Get_MsgNamebyMsgID](30002, @Language) -- Fail to edit type of licensee. Please try again.    
        RETURN
    END CATCH
    
    SET @xml = (
        SELECT    LicenseeTypeId        AS '@lti'
                ,LicenseeTypeName    AS '@ltn'
        FROM    dbo.LicenseeType WITH(NOLOCK)
        WHERE    LicenseeTypeId = @LicenseeTypeId
        FOR XML PATH('r'), TYPE
        )        
        
    SELECT @logSPData = CONVERT(NVARCHAR(MAX), @xml)
        ,@endRun    = GETDATE()  
        ,@duration    = DATEDIFF(MILLISECOND, @startRun, @endRun)   
        ,@procName    = OBJECT_NAME(@@PROCID)

    EXEC dbo.OIC_LogRunSpIns
        @UserId            = @UserId
        ,@SPName        = @procName
        ,@Language        = @Language
        ,@IP            = @IP
        ,@Data            = @logSPData
        ,@OldData        = @logSPOlddata
        ,@Duration        = @Duration
END


GO


----

/****** Object:  StoredProcedure [dbo].[OIC_LogRunSpIns]    Script Date: 6/5/2018 2:26:55 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


create PROC [dbo].[OIC_LogRunSpIns]
    @UserId            INT            
    ,@SPName        VARCHAR(50)    
    ,@Language        VARCHAR(20)        = 'EN'
    ,@IP            VARCHAR(50)        = NULL
    ,@Data            NVARCHAR(MAX)    = NULL    
    ,@OldData        NVARCHAR(MAX)    = NULL
    ,@Duration        INT                = NULL
AS
/*
    Created by: Kathy
    Date: 2014-12-18
    Task: Add new log user run sp [Redmine:#27752]
    DB: DBOIC.bodb_OIC
    
    Revisions:
        - 20161019@Percy: Support test version (xtest, xpre, UAT1, UAT2, UAT3, UAT4) [RedmineID: #64712]
    
    Param's Explanation:
        * @UserId: UserId perform this action  
        * @ActionId: Log action ID
        * @TrackingValue: XML string format
 */
BEGIN
    SET NOCOUNT ON
    
    DECLARE @logactionid INT

    IF @SPName LIKE '%_xtest'
        SELECT @SPName = LEFT(@SPName, LEN(@SPName) - 6)
    ELSE IF @SPName LIKE '%_xpre' OR @SPName LIKE '%_UAT1' OR @SPName LIKE '%_UAT2' OR @SPName LIKE '%_UAT3' OR @SPName LIKE '%_UAT4'
        SELECT @SPName = LEFT(@SPName, LEN(@SPName) - 5)
    
    SELECT @logactionid = LogActionId
    FROM dbo.LogAction WITH(NOLOCK)
    WHERE SPName = @SPName

    INSERT INTO dbo.UserLog_RunSP (UserId, LogActionId, IP, LogDate, Duration)
    VALUES (@UserId, @logactionid, @IP, GETDATE(), @Duration)
    
    IF @@ERROR = 0
        INSERT INTO dbo.UserLog_RunSP_Detail(LogActionId, Data, OldData)
        VALUES (@logactionid, @Data, @OldData)
END

GO


----

/****** Object:  UserDefinedFunction [dbo].[f_Get_MsgNamebyMsgID]    Script Date: 6/5/2018 2:27:33 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

/****** Object:  User Defined Function dbo.f_Get_MsgNamebyMsgID    Script Date: 09/02/2015 3:30:04 PM ******/
CREATE FUNCTION [dbo].[f_Get_MsgNamebyMsgID]
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
    -- Declare the return variable here
    DECLARE    @MsgName    NVARCHAR(4000)

    SELECT    @MsgName = ContentEn                                        
    FROM    dbo.MessageError WITH (NOLOCK)
    WHERE    MessageErrorId  = @MsgID

    -- Return the result of the function
    RETURN    @MsgName

END