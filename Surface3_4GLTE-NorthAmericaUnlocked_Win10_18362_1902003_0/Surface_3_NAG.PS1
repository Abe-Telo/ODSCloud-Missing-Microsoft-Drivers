# Set download URL and path to save the ZIP file
$zipUrl = "https://github.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/archive/refs/heads/main.zip"
$zipDir = "E:\OSDCloud\Drivers\"
$zipPath = Join-Path $zipDir "ODSCloud-Missing-Microsoft-Drivers-main.zip"
$extractPath = "E:\OSDCloud\Drivers\"

# Create the directory if it doesn't exist
if (-not (Test-Path $zipDir)) {
    New-Item -Path $zipDir -ItemType Directory
}

# Download the ZIP file
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

# Extract the ZIP file
Add-Type -AssemblyName System.IO.Compression.FileSystem
[System.IO.Compression.ZipFile]::ExtractToDirectory($zipPath, $extractPath)

# Run the pnputil.exe commands
$basePath = "E:\OSDCloud\Drivers\ODSCloud-Missing-Microsoft-Drivers-main\Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0\SurfaceUpdate\Drivers"

$touchScreenDriverPath = Join-Path $basePath "Display\SurfaceTouchScreenDriver\*"
$spiDriverPath = Join-Path $basePath "System\SPI\*"

pnputil.exe /add-driver $touchScreenDriverPath /subdirs /install
pnputil.exe /add-driver $spiDriverPath /subdirs /install
