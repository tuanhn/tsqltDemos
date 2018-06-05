USE [UnitTest1]
GO
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