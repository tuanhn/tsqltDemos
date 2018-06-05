USE [UnitTest2]
GO

/****** Object:  Table [dbo].[UserLicenseeType]    Script Date: 6/5/2018 3:06:02 PM ******/
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


