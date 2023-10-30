# Load necessary assembly for zip operations and set paths
Add-Type -AssemblyName System.IO.Compression.FileSystem

$zipUrl = "https://github.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/archive/refs/heads/main.zip"
$basePath = "E:\OSDCloud\DriverPacks\"
$zipPath = Join-Path $basePath "ODSCloud-Missing-Microsoft-Drivers-main.zip"

# Ensure directory exists
if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -ItemType Directory
}

# Download and extract ZIP
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath
Expand-Archive -Path $zipPath -DestinationPath $basePath -Force

# Construct driver paths
$driversBase = Join-Path $basePath "ODSCloud-Missing-Microsoft-Drivers-main\Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0\SurfaceUpdate\Drivers"
$touchScreenDriverPath = Join-Path $driversBase "Display\SurfaceTouchScreenDriver\*"
$spiDriverPath = Join-Path $driversBase "System\SPI\*"

# Display constructed paths
write-host "Paths:"
write-host "Drivers Base: $driversBase"
write-host "Touch Screen: $touchScreenDriverPath"
write-host "SPI: $spiDriverPath"

# Install drivers
pnputil.exe /add-driver $touchScreenDriverPath /subdirs /install
pnputil.exe /add-driver $spiDriverPath /subdirs /install

# Cleanup ZIP file
Remove-Item -Path $zipPath -Force
