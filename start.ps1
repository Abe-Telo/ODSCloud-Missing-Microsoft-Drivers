# This Script is the base line of everything. 
# Copy this script into offline.ps1, And add it to your startnet.cmd file
# .\offline.ps1

# Determine the USB partition of type IFS
$usbDrive = Get-USBPartition | Where-Object { $_.Type -eq "IFS" } | Select-Object -ExpandProperty DriveLetter

# If there's no IFS type drive found, terminate the script
if (-not $usbDrive) {
    Write-Error "No USB partition with IFS type found. Exiting."
    return
}

# Base path adjusted to reflect the USB drive
$basePath = "${usbDrive}:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main" 

function Is-Online {
    # Returns $true if online, $false otherwise
    return Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet
}

if (Is-Online) {
    # If online, fetch and run the script from the URL
    try {
        Write-Output "Fetching and executing extract_zip.ps1 from online source..."
        Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/extract_zip.ps1" -UseBasicParsing).Content
        
        # Possibly replace this in the future
        Write-Output "Fetching and executing online.ps1 from online source..."
        Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content

        $localGSFormScript = Join-Path $basePath "scripts\GSForm.ps1"
        & $localGSFormScript

    } catch {
        Write-Error "Failed to fetch or execute the online script."
    }
} else {
    # If offline, run the local script
    $localScriptPath = Join-Path $basePath "offline.ps1"
    $localGSFormScript = Join-Path $basePath "scripts\GSForm.ps1"

    if (Test-Path $localScriptPath) {
        Write-Output "Executing local script: $localScriptPath"
        & $localScriptPath
        & $localGSFormScript
    } else {
        Write-Error "The local script offline.ps1 does not exist at path $localScriptPath."
    }
}
