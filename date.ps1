#This script is for testing only at the moment.
#https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1

function Test-InternetConnection {
    try {
        $ping = Test-Connection -ComputerName '8.8.8.8' -Count 1 -ErrorAction Stop
        $true
    } catch {
        $false
    }
}

function Get-CurrentDateTime {
    try {
        $response = Invoke-WebRequest -Uri 'http://worldtimeapi.org/api/timezone/America/New_York' -UseBasicParsing -TimeoutSec 5
        if ($response.StatusCode -eq 200) {
            return ($response.Content | ConvertFrom-Json).utc_datetime
        }
    } catch {
        return $null
    }
}

function Set-SystemDateTime ([datetime]$currentDateTime) {
    $date = Get-Date $currentDateTime -Format 'MM-dd-yyyy'
    $time = Get-Date $currentDateTime -Format 'HH:mm:ss'
    cmd /c date $date
    cmd /c time $time
}

# Main
if (Test-InternetConnection) {
    $dateTime = Get-CurrentDateTime
    if ($dateTime) {
        Set-SystemDateTime -currentDateTime $dateTime
        Write-Output "Date and time updated to: $dateTime"
    } else {
        Write-Output "Failed to retrieve current date and time."
    }
} else {
    Write-Output "No internet connection detected. Skipping date and time update."
}
