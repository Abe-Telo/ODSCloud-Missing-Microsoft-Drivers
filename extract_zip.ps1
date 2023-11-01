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

# Cleanup ZIP file
Remove-Item -Path $zipPath -Force

# Display constructed paths
write-host "Drivers Base: $zipPath"

# Confirmation message
write-host "Download and extraction complete."