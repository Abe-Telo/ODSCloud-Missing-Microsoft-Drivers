<#
.SYNOPSIS
This PowerShell script updates the system's time zone to Eastern Time (US & Canada).

.DESCRIPTION
The script checks if it is running with administrator privileges and then attempts to set the system's time zone to "Eastern Standard Time."
If the script is not run with administrator privileges, it will still attempt to set the time zone, although this may fail depending on system permissions. 
The script provides clear feedback via terminal output, logging both successes and failures, and does not stop execution even if the necessary permissions are lacking.

This script is suitable for environments where the time zone needs to be standardized across systems or virtual machines, such as in managed IT environments, deployment scripts, or automation tasks. 
It is particularly useful for ensuring that systems are set to the correct time zone without manual intervention.

.USAGE ENVIRONMENTS
- **Standard Windows Operating Systems**: Suitable for full Windows environments where PowerShell and time zone management cmdlets are available.
- **Automated Deployment and Maintenance Scripts**: Useful in deployment pipelines or scheduled tasks where time zone standardization is necessary.
- **Server Maintenance**: Applicable in server environments where maintaining a consistent time zone is critical.
  
.NOTES
- **Not Suitable for Minimalistic Environments**: This script may not work in lightweight or customized environments like WinPE (Windows Preinstallation Environment) or certain Network Edge Appliances (NEA), as these environments might not have PowerShell or the required cmdlets (`Set-TimeZone`, `Get-TimeZone`).
- **Administrator Privileges**: Running the script with administrator privileges ensures that the time zone change is applied successfully. Without administrator privileges, the script will attempt to change the time zone but may fail due to insufficient permissions.

.WHAT IT DOES
When the script successfully updates the time zone, it sets the system time zone to "Eastern Standard Time" (US & Canada), ensuring that the system's clock is aligned with the Eastern Time Zone.
The change is reflected immediately, and the current time and new time zone are logged to the terminal for confirmation.

.PARAMETERS
None

.EXAMPLE
.\TimeZoneScript.ps1
This command runs the script to change the system time zone to Eastern Time (US & Canada).

.NOTES
- If the script is not run with administrator privileges, it will still attempt to set the time zone, but it may fail unless sufficient permissions are granted.
- Ensure that PowerShell is run with elevated permissions if you want to guarantee that the time zone is updated successfully.
#>

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
