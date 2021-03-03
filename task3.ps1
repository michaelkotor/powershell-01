Write-host "Creating a folder"
$date = Get-Date -Format "yyyy-MM-dd HH:mm"
Write-host $date
New-ItemProperty -Path "HKCU:\Software\PowershellScriptRunTime" -Name "RunTime" -Value $date  -PropertyType "String"