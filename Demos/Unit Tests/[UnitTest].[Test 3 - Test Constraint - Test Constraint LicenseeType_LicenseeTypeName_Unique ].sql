USE [UnitTest1]
GO
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
