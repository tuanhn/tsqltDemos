function Get-CoverTSql{
    param(
            [string]$coverDllPath
            ,[string]$connectionString
            ,[string]$databaseName
            ,[string]$query
        )

    if(!(Test-Path $coverDllPath)){
        Write-Error "SQLCover.dll path was not found ($coverDllPath)"
        return
    }

    Unblock-File -Path $coverDllPath    
    Add-Type -Path $coverDllPath    
    $coverage = new-object SQLCover.CodeCoverage ($connectionString, $databaseName)
	$coverage.Cover($query)  
}

function Export-OpenXml{
    param(        
        [SQLCover.CoverageResult] $result
        ,[string]$outputPath
    )

    $xmlPath = Join-Path -Path $outputPath -ChildPath "Coverage.opencoverxml"
    $result.OpenCoverXml() | Out-File $xmlPath
    $result.SaveSourceFiles($outputPath)    
}

$sqlCoverPath = ($pwd).path 
$result = Get-CoverTSql "PATH_TO\SQLCover.0.2.2\SQLCover.dll" "server=SQL_SERVER;user=username;Password=password" "UnitTest1" "tSQLt.RunAll"
Export-OpenXml $result $sqlCoverPath
$report = $sqlCoverPath + "\Coverage.opencoverxml"
PATH_TO\ReportGenerator.2.5.0\tools\ReportGenerator.exe -reports:$report -targetdir:$sqlCoverPath