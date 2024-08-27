# Function to print debug/info messages to the terminal
function Write-Log {
    param (
        [string]$Message,
        [string]$Level = "INFO"
    )
    $Timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    Write-Host "$Timestamp - [$Level] - $Message"
}

# Start of the script
Write-Log "Script started."

# Check if the script is run as an administrator
$IsAdmin = ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")

if ($IsAdmin) {
    Write-Log "Script is running with administrator privileges." "SUCCESS"
} else {
    Write-Log "Script is NOT running with administrator privileges." "WARNING"
}

# Attempt to set the time zone to Eastern Time (US & Canada)
$timeZoneId = "Eastern Standard Time"

try {
    Set-TimeZone -Id $timeZoneId
    
    # Verify the time zone change
    $currentTimeZone = Get-TimeZone
    Write-Host "The time zone has been updated to: $($currentTimeZone.Id)"
    Write-Host "The current time is: $(Get-Date)"
    
    # Print success debug info
    Write-Log "Time zone successfully updated to $($currentTimeZone.Id). Current time is $(Get-Date)." "SUCCESS"
} catch {
    # Catch and print any errors to the terminal
    Write-Log "Failed to update the time zone. Continuing without admin rights." "ERROR"
}

# End of the script
Write-Log "Script ended."
