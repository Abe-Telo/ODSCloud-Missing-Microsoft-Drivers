# Load the necessary assembly for zip operations
Add-Type -AssemblyName System.IO.Compression.FileSystem

# Set the download URL and path to save the ZIP file
$zipUrl = "https://github.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/archive/refs/heads/main.zip"
$zipDir = "E:\OSDCloud\Drivers\"
$zipPath = Join-Path $zipDir "ODSCloud-Missing-Microsoft-Drivers-main.zip"
$extractPath = "E:\OSDCloud\Drivers\ODSCloud-Missing-Microsoft-Drivers-main"

# Create the directory if it doesn't exist
if (-not (Test-Path $zipDir)) {
    New-Item -Path $zipDir -ItemType Directory
}

# Download the ZIP file
Invoke-WebRequest -Uri $zipUrl -OutFile $zipPath

# Open ZIP archive
$archive = [System.IO.Compression.ZipFile]::OpenRead($zipPath)

foreach ($entry in $archive.Entries) {
    $destinationPath = Join-Path $extractPath $entry.FullName
    $shouldExtract = $true

    if (Test-Path $destinationPath) {
        $existingFile = Get-Item $destinationPath
        if ($existingFile.LastWriteTimeUtc -eq $entry.LastWriteTime) {
            $shouldExtract = $false
        }
    }

    if ($shouldExtract) {
        $entryDestinationDirectory = [System.IO.Path]::GetDirectoryName($destinationPath)
        if (-not (Test-Path $entryDestinationDirectory)) {
            New-Item -Path $entryDestinationDirectory -ItemType Directory
        }
        $entry.ExtractToFile($destinationPath, $true) # The $true flag means it will overwrite if the file already exists
    }
}

$archive.Dispose()

# Run the pnputil.exe commands
$basePath = "E:\OSDCloud\Drivers\ODSCloud-Missing-Microsoft-Drivers-main\Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0\SurfaceUpdate\Drivers"

$touchScreenDriverPath = Join-Path $basePath "Display\SurfaceTouchScreenDriver\*"
$spiDriverPath = Join-Path $basePath "System\SPI\*"

pnputil.exe /add-driver $touchScreenDriverPath /subdirs /install
pnputil.exe /add-driver $spiDriverPath /subdirs /install
