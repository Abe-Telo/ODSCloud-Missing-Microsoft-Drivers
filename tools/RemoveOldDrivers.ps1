# This script will find and ask you if you want to remove old versions based on version numbers.
# TODO: Remove HardCoded Drive Letters, Instead look for any path besides windows path C:\

# Define the path to the directory containing the files
$directoryPath = "D:\OSDCloud\DriverPacks\Microsoft"

# Function to extract base name and version from the file name
function Get-BaseNameAndVersion {
    param (
        [string]$fileName
    )
    if ($fileName -match "^(?<basename>.+?)_Win(?<winversion>\d+)_((?<version>\d+\.\d+\.\d+\.\d+)|(?<versionAlt>\d+_\d+\.\d+\.\d+)|(?<versionShort>\d+_\d+\.\d+\.\d+_(LTE|WiFi|ATT|NorthAmericaUnlocked|RestOfTheWorld)?)|(?<versionMS>\d+_\d+))?.*\.(?<extension>msi|json)$") {
        return @{
            BaseName = if ($matches['versionShort']) { "$($matches['basename'])_Win$($matches['winversion'])_$($matches['versionShort'])" } else { "$($matches['basename'])_Win$($matches['winversion'])" }
            Version = if ($matches['version']) { [version]$matches['version'] } elseif ($matches['versionAlt']) { [version]$matches['versionAlt'].Replace("_", ".") } elseif ($matches['versionMS']) { [version]$matches['versionMS'].Replace("_", ".") } else { [version]"0.0.0.0" }
            Extension = $matches['extension']
        }
    }
    return $null
}

# Get all .msi and .json files in the directory
$files = Get-ChildItem -Path $directoryPath -Include "*.msi", "*.json" -Recurse

# Create a hashtable to keep track of the latest version for each base name and file type
$latestVersions = @{}
$filesToDelete = @{}

Write-Output "Processing files..."

foreach ($file in $files) {
    $fileInfo = Get-BaseNameAndVersion -fileName $file.Name
    if ($fileInfo) {
        Write-Output "Processing file: $($file.Name)"
        Write-Output "Extracted BaseName: $($fileInfo.BaseName), Version: $($fileInfo.Version), Extension: $($fileInfo.Extension)"
        
        $key = "$($fileInfo.BaseName).$($fileInfo.Extension)"

        if (-not $latestVersions.ContainsKey($key)) {
            Write-Output "Adding new entry to keep: $($file.Name)"
            $latestVersions[$key] = @{"Version" = $fileInfo.Version; "File" = $file}
        } elseif ($fileInfo.Version -gt $latestVersions[$key].Version) {
            Write-Output "Found newer version for: $($fileInfo.BaseName). Marking older version for deletion: $($latestVersions[$key].File.Name)"
            # Move the old version to files to delete
            $filesToDelete[$latestVersions[$key].File.FullName] = $latestVersions[$key].Version
            # Update the latest version for the base name and file type
            $latestVersions[$key] = @{"Version" = $fileInfo.Version; "File" = $file}
        } elseif ($fileInfo.Version -lt $latestVersions[$key].Version) {
            Write-Output "Current file is older version. Marking for deletion: $($file.Name)"
            # If current file is older, add it to the files to delete
            $filesToDelete[$file.FullName] = $fileInfo.Version
        } else {
            Write-Output "Current file is the same version. Keeping both: $($file.Name)"
        }
    } else {
        Write-Output "Skipping file (no match for pattern): $($file.Name)"
    }
}

# Debug output to see which files are being kept
Write-Output "Files to keep:"
$latestVersions.Values | ForEach-Object { Write-Output $_.File.FullName }

# Debug output to see which files are being deleted
Write-Output "Files to delete:"
$filesToDelete.Keys | ForEach-Object { Write-Output $_ }

# Confirm deletion
$confirm = Read-Host "Do you want to delete these files? (Yes/No)"
if ($confirm -eq "Yes") {
    foreach ($file in $filesToDelete.Keys) {
        Remove-Item -Path $file -Force
    }
    Write-Output "Files deleted."
} else {
    Write-Output "Deletion canceled."
}
