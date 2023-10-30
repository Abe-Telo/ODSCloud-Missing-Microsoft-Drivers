# Load the necessary assembly for zip operations
Add-Type -AssemblyName System.IO.Compression.FileSystem

# Set the download URL and path to save the ZIP file
$zipUrl = "https://github.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/archive/refs/heads/main.zip"
$basePath = "E:\OSDCloud\DriverPack\"
$zipPath = Join-Path $basePath "ODSCloud-Missing-Microsoft-Drivers-main.zip" 
$extractPath = Join-Path $basePath "ODSCloud-Missing-Microsoft-Drivers-main"

# Create the directory if it doesn't exist
if (-not (Test-Path $basePath)) {
    New-Item -Path $basePath -ItemType Directory
}

# Download the ZIP file
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

# Extract ZIP archive using Expand-Archive
Expand-Archive -Path $zipPath -DestinationPath $extractPath -Force

# Run the pnputil.exe commands
$addDriver = "E:\OSDCloud\DriverPack\ODSCloud-Missing-Microsoft-Drivers-main\Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0\SurfaceUpdate\Drivers"

$touchScreenDriverPath = Join-Path $addDriver "Display\SurfaceTouchScreenDriver\*"
$spiDriverPath = Join-Path $addDriver "System\SPI\*"

pnputil.exe /add-driver $touchScreenDriverPath /subdirs /install
pnputil.exe /add-driver $spiDriverPath /subdirs /install
