# Function to get USB partitions
function Get-USBPartition {
    Get-WmiObject Win32_DiskDrive | 
        Where-Object { $_.MediaType -eq "Removable Media" } | 
        ForEach-Object {
            $_ | Get-WmiObject -Query "ASSOCIATORS OF {Win32_DiskDrive.DeviceID='$($_.DeviceID)'} WHERE AssocClass=Win32_DiskDriveToDiskPartition" | 
                ForEach-Object {
                    $_ | Get-WmiObject -Query "ASSOCIATORS OF {Win32_DiskPartition.DeviceID='$($_.DeviceID)'} WHERE AssocClass=Win32_LogicalDiskToPartition"
                }
        }
}

# Get USB drives
$usbDrives = Get-USBPartition | Select-Object -ExpandProperty DeviceID

# Load necessary assembly for zip operations and set paths
Add-Type -AssemblyName System.IO.Compression.FileSystem

$zipUrl = "https://github.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/archive/refs/heads/main.zip"

# Assuming you want to use the first detected USB drive letter for your basePath
$basePath = "$($usbDrives[1]):\OSDCloud\DriverPacks\"
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
