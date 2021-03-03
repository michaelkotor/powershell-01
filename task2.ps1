Function CreateFile ($fileName)
{
    $fileExist = Test-Path $fileName
    if(!$fileExist)
    {
        Write-Host "Output file does not exist. New file will be created." -foregroundcolor "Green"
    }
    else
    {
        Write-Host "Output file does exist. Overwriting file." -foregroundcolor "Red"
    }
}

Function SaveData
{
    $input | Select-Object Name, Id, $args[1] | Export-Csv $args[0] -force
}

# I add one more element to array,, because I wanr it to have always at least two elements
# otherwise, it counts the only element as string, its length is more then 5, hence it starts
# to delete every second file.

Function CleanWorkspace
{
    $allFiles = Get-ChildItem -Path . -Name
    $csvFiles = @("0")
    $csvFiles += Get-ChildItem -Path . | Where-Object {$_ -like "*.csv"} | Sort-Object -Property Name
    if($csvFiles.Length -gt 5) {
        Remove-Item -LiteralPath $csvFiles[1]
        Write-Host "File deleted"
    }
}


$processList = Get-Process

$choise = Read-Host "Choose a parameter to sort. It can be NPM, PM, WS, CPU, SI."
$input = Read-Host "Enter baseline. It can be a number. For NPM - [0], PM - [0], WS - [0...1100], CPU - [0...200], SI - [0...10000]"


$baseline = [double]$input
while ($true)
{
    $writeToFile = New-Object System.Collections.Generic.List[System.Object]
    $processList | ForEach-Object {
        if(($_ | Select-object -ExpandProperty $choise) -gt $baseline) {
            $writeToFile.Add($_)
        }
    }

    $date = Get-Date -Format "yyyy_MM_DD_HH_mm_ss"
    $file = "FilteredProcessList_" + $date + ".csv"
    CreateFile $file

    $writeToFile.GetEnumerator() | SaveData $file $choise
    Start-Sleep -s 5

    CleanWorkspace
}





