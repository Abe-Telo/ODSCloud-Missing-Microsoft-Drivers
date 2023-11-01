# This Script is the base line of everything. 
# Copy this script into offline.ps1, And add it to your startnet.cmd file
# .\offline.ps1

$basePath = "E:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main" 

function Is-Online {
    # Returns $true if online, $false otherwise
    return Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet
}

if (Is-Online) {
    # If online, fetch and run the script from the URL
    try {
        Write-Output "Fetching and executing extract_zip.ps1 from online source..."
        Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/extract_zip.ps1" -UseBasicParsing).Content
        
    #Just for testing.
    if (Test-Path $localScriptPath) {
        Write-Output "Executing local script: $localScriptPath"
        & $localScriptPath
    } else {
        Write-Error "The local script online.ps1 does not exist at path $localScriptPath."
    }

        ##Possiably replaced this in the future. 
        #Write-Output "Fetching and executing online.ps1 from online source..."
        #Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content
    } catch {
        Write-Error "Failed to fetch or execute the online script."
    }
} else {
    # If offline, run the local script
    $localScriptPath = Join-Path $basePath "online.ps1"

    if (Test-Path $localScriptPath) {
        Write-Output "Executing local script: $localScriptPath"
        & $localScriptPath
    } else {
        Write-Error "The local script online.ps1 does not exist at path $localScriptPath."
    }
}
