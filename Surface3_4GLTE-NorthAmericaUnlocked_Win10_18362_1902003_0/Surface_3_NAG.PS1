# Load the necessary assembly for zip operations
Add-Type -AssemblyName System.IO.Compression.FileSystem

# Set the download URL and path to save the ZIP file
$zipUrl = "https://github.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/archive/refs/heads/main.zip"
$basePath = "E:\OSDCloud\DriverPack\"
$zipFileName = "ODSCloud-Missing-Microsoft-Drivers-main.zip"
$zipPath = Join-Path $basePath $zipFileName

# Create the directory if it doesn't exist
if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -ItemType Directory
}

# Download the ZIP file
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

# Extract ZIP archive using Expand-Archive
Expand-Archive -Path $zipPath -DestinationPath $basePath -Force

# Define the path for Surface drivers
$Surface_3_NAG = "ODSCloud-Missing-Microsoft-Drivers-main\Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0\SurfaceUpdate\Drivers"
$addDriver = Join-Path $basePath $Surface_3_NAG
write-host "Constructed path: $addDriver"

$touchScreenDriverPath = Join-Path $addDriver "Display\SurfaceTouchScreenDriver\*"
write-host "Touch Screen Driver Path: $touchScreenDriverPath"

$spiDriverPath = Join-Path $addDriver "System\SPI\*"
write-host "SPI Driver Path: $spiDriverPath"

# Run the pnputil.exe commands
pnputil.exe /add-driver $touchScreenDriverPath /subdirs /install
pnputil.exe /add-driver $spiDriverPath /subdirs /install

# Optional: Cleanup - Delete the ZIP file after extraction and installation
Remove-Item -Path $zipPath -Force
