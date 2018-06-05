$SqlConnection = New-Object System.Data.SqlClient.SqlConnection
$SQLConnection.ConnectionString = "server=SQL_SERVER;database=UnitTest1;user=username;Password=password"
$SqlConnection.Open()

$sqlCommand=$sqlConnection.CreateCommand()
$sqlCommand.CommandTimeout = 10000
$sqlCommand.CommandText="exec tSQLt.RunAll"
$sqlReader = $sqlCommand.ExecuteNonQuery()
$sqlReader.Close()

Out-File 'tSQLt_OIC_Result.xml'
$sqlCommand1=$sqlConnection.CreateCommand()
$sqlCommand1.CommandTimeout = 10000
$sqlCommand1.CommandText = “EXEC tSQLt.XmlResultFormatter”
$sqlReader1 = $sqlCommand1.ExecuteReader()
while ($sqlReader1.Read()) {
 $xmlResult = $sqlReader1[$sqlReader1.GetName(0)]
 $xmlResult | Out-File 'tSQLt_OIC_Result.xml' -Append
}
$SqlConnection.close()