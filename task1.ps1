#----------------------------------------------
#task1.ps1 was created by Michael Kotor
#It looks up for procces
#----------------------------------------------

$processList = Get-Process

#----------------------------------------------
#-------------------Execution code-------------
#----------------------------------------------

Write-Host "Perform the search among running processed. You can search by name(0), part(1) or Id(2). Choose" -foregroundcolor "Yellow"
$choise = Read-Host "Enter the number to choose"
if ($choise -eq "0") {

    Write-Host "Search by Name" -foregroundcolor "Yellow"
    $name = Read-Host "Enter Name to search for"
    $isFound = 0

    $processList | ForEach-Object {
        if($_.Name -eq $name) {
            Write-Host ($_ | Format-Table | Out-String) -foregroundcolor "Green"
            $isFound = 1
            $isToKill = Read-Host "Do you want to kill this process (This can cause issues!)? y/n"
            if($isToKill -eq "y") {
                Stop-Process -Name $name -Force
                Write-Host "Process killed" -foregroundcolor "Red"
            }
        }
    }
    if(!$isFound) {
        Write-Host "No procces with such name" -foregroundcolor "Red"
    }
}
if ($choise -eq "1") {

    Write-Host "Search by part of name" -foregroundcolor "Yellow"
    $part = Read-Host "Enter part of name to search for" -foregroundcolor "Yellow"
    $isFound = 0

    $processList | ForEach-Object {
        if($_.Name -like ("*" + $part + "*")) {
            Write-Host ($_ | Format-Table | Out-String) -foregroundcolor "Green"
            $isFound = 1
        }
    }
    if(!$isFound) {
        Write-Host "No procces with such part" -foregroundcolor "Red"
    }
}

if ($choise -eq "2") {

    Write-Host "Search by Id" -foregroundcolor "Yellow"
    $id = Read-Host "Enter Id to search for" -foregroundcolor "Yellow"
    $isFound = 0

    $processList | ForEach-Object {
        if($_.Id -eq $id) {
            Write-Host ($_ | Format-Table | Out-String) -foregroundcolor "Green"
            $isFound = 1
            $isToKill = Read-Host "Do you want to kill this process (This can cause issues!)? y/n"
            if($isToKill -eq "y") {
                Stop-Process -ID $id -Force
                Write-Host "Process killed" -foregroundcolor "Red"
            }
        }
    }
    if(!$isFound) {
        Write-Host "No procces with such id" -foregroundcolor "Red"
    }
}

   #>