# With this script, you can log Serial numbers And other system info, Into a google sheet. This works with Google Forms.
# To set this up correctly, Create a google form from drive.google.com
# Create and name your 7 fields. EG: S/N, SKU, Model, Win Ver, CPU, Ram, HD.
# Create a file "GSFormsConfig.txt" and past the URL.
# Click on the three dots and lick, Get pre filed link. Right click and click inspect. 
# Find <input name="entry.123456789"> Change fields for each entry.
# Run the script .\GSForm.ps1 and test it. 

# Determine the USB partition of type IFS
$usbDrive = Get-USBPartition | Where-Object { $_.Type -eq "IFS" } | Select-Object -ExpandProperty DriveLetter

# If there's no IFS type drive found, terminate the script
if (-not $usbDrive) {
    Write-Error "No USB partition with IFS type found. Exiting."
    return
}

# Base path adjusted to reflect the USB drive
$basePath = "${usbDrive}:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\scripts"
 
# Define the log file path
#$logFilePath = "$PSScriptRoot\GSFormLog.txt"
$logFilePath = "$basePath\GSFormLog.txt"

# Function to write a log both console and to a file
function Write-Log {
    param([string]$message, [ConsoleColor]$color = 'White')
    Write-Host $message -ForegroundColor $color
    $message | Out-File -FilePath $logFilePath -Append
}

# Read configuration from GSFormsConfig.txt
#$configFilePath = "$PSScriptRoot\GSFormsConfig.txt"
$configFilePath = "$basePath\GSFormsConfig.txt"
$configData = @{}
Get-Content $configFilePath | ForEach-Object {
    $parts = $_ -split '='
    $key = $parts[0]
    $value = $parts[1].Trim()
    $configData[$key] = $value
}

# Fetch system information
Write-Log "Fetching system information..."
$serialNumber = (Get-WmiObject -Class Win32_BIOS).SerialNumber
$model = (Get-WmiObject -Class Win32_ComputerSystem).Model
$sku = (Get-ComputerInfo).CsSystemSkuNumber
$windowsVersion = (Get-ComputerInfo).WindowsProductName + " " + (Get-ComputerInfo).WindowsVersion
$cpu = (Get-WmiObject -Class Win32_Processor).Name
$ram = [Math]::Round((Get-ComputerInfo).CsTotalPhysicalMemory / 1GB)
$hd = [Math]::Round((Get-WmiObject -Class Win32_DiskDrive | Select-Object -First 1).Size / 1GB)

# Log the collected information
Write-Log "System Information:" -color 'Yellow'
Write-Log "Serial Number: $serialNumber" -color 'Green'
Write-Log "Model: $model" -color 'Green'
Write-Log "SKU: $sku" -color 'Green'
Write-Log "Windows Version: $windowsVersion" -color 'Green'
Write-Log "CPU: $cpu" -color 'Green'
Write-Log "RAM: ${ram}GB" -color 'Green'
Write-Log "HD: ${hd}GB" -color 'Green'

# Define the URL of the Google Form submission endpoint and form data
$GSForm = $configData["GoogleFormURL"]
$formData = @{
    $configData["serialNumber"] = $serialNumber
    $configData["model"] = $model
    $configData["sku"] = $sku
    $configData["windowsVersion"] = $windowsVersion
    $configData["cpu"] = $cpu
    $configData["ram"] = $ram
    $configData["hd"] = $hd
}

# Create a new web request session object
Write-Log "Creating a new web request session..."
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# Submit the form
Write-Log "Submitting the form data..."
$response = Invoke-WebRequest -Uri $GSForm -Method Post -Body $formData -WebSession $session -UseBasicParsing

# Log the response status
Write-Log "Form submission response status: $($response.StatusCode)"
