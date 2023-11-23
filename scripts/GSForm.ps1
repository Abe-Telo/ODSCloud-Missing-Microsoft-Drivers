# Define the log file path
$logFilePath = "$PSScriptRoot\GSFormLog.txt"

# Function to write a log both console and to a file
function Write-Log {
    param([string]$message, [ConsoleColor]$color = 'White')
    Write-Host $message -ForegroundColor $color
    $message | Out-File -FilePath $logFilePath -Append
}

# Fetch system information
Write-Log "Fetching system information..."
$serialNumber = (Get-WmiObject -Class Win32_BIOS).SerialNumber
$sku = (Get-ComputerInfo).CsSystemSkuNumber
$model = (Get-WmiObject -Class Win32_ComputerSystem).Model
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

# Define the URL of the Google Form submission endpoint
Write-Log "Retrieving the Google Form URL..."
$GSForm = Get-Content -Path "$PSScriptRoot\GSForm.txt"

# Log the URL
Write-Log "Google Form URL: $GSForm"

# Create a new web request session object
Write-Log "Creating a new web request session..."
$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession

# Form data to be submitted
Write-Log "Preparing form data for submission..."
$formData = @{
    "entry.366548140" = $serialNumber
    "entry.446059738" = $model
    "entry.155658717" = $sku
    "entry.730980097" = $windowsVersion
    "entry.732944140" = $cpu
    "entry.362455697" = $ram
    "entry.1305266274" = $hd
}

# Submit the form
Write-Log "Submitting the form data..."
$response = Invoke-WebRequest -Uri $GSForm -Method Post -Body $formData -WebSession $session -UseBasicParsing

# Log the response status
Write-Log "Form submission response status: $($response.StatusCode)"
