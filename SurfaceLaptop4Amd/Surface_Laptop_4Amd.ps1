# Fetch the USB drive with IFS type
$usbDrive = Get-USBPartition | Where-Object { $_.Type -eq "IFS" } | Select-Object -ExpandProperty DriveLetter

# If no IFS type drive found, terminate the script
if (-not $usbDrive) {
    Write-Error "No USB partition with IFS type found. Exiting."
    return
}

# Load necessary assembly for zip operations and set paths
Add-Type -AssemblyName System.IO.Compression.FileSystem

$zipUrl = "https://github.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/archive/refs/heads/main.zip"
$Driver_Path = "${usbDrive}:\OSDCloud\DriverPacks\"
$zipPath = Join-Path $Driver_Path "ODSCloud-Missing-Microsoft-Drivers-main.zip"

# Ensure directory exists
if (-not (Test-Path $Driver_Path)) {
    New-Item -Path $Driver_Path -ItemType Directory
}

# Download and extract ZIP
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $Driver_Path -Force

# Construct driver paths
$driversBase = Join-Path $Driver_Path "ODSCloud-Missing-Microsoft-Drivers-main\SurfaceLaptop4Amd"
$touchScreenDriverPath = Join-Path $driversBase "SurfaceUpdate\*" 

# Display constructed paths
write-host "Paths:"
write-host "Drivers Base: $driversBase"
write-host "Touch Screen: $touchScreenDriverPath"
#write-host "SPI: $spiDriverPath"

# Install drivers
pnputil.exe /add-driver $touchScreenDriverPath /subdirs /install 

# Cleanup ZIP file
Remove-Item -Path $zipPath -Force
