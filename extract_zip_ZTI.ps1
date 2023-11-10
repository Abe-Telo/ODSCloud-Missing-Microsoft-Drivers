# Fetch the USB drive with IFS type
$usbDrive = Get-USBPartition | Where-Object { $_.Type -eq "IFS" } | Select-Object -ExpandProperty DriveLetter

# If no IFS type drive found, terminate the script
if (-not $usbDrive) {
    Write-Error "No USB partition with IFS type found. Exiting."
    return
}

# Load necessary assembly for zip operations and set paths
Add-Type -AssemblyName System.IO.Compression.FileSystem

$zipUrl = "https://github.com/AkosBakos/OSDCloud/archive/refs/heads/main.zip"
$basePath = "${usbDrive}:\OSDCloud\DriverPacks\"
$zipPath = Join-Path $basePath "ZTI.zip"

# Ensure directory exists
if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -ItemType Directory
}

# Download and extract ZIP
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $basePath -Force

# Cleanup ZIP file
Remove-Item -Path $zipPath -Force
 

# Confirmation message
write-host "ZTI Download and extraction complete."
