#Use this script with a one liner
#Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/start.PS1" -UseBasicParsing).Content


# Get the system SKU and model
$sku = (Get-WmiObject -Class Win32_ComputerSystem).SystemSKU
$model = (Get-WmiObject -Class Win32_ComputerSystem).Model

# Define the script URL
$Surface_3_NAG = "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0/Surface_3_NAG.PS1"

# Check SKU
if ($sku -eq "Surface_3_Nag") {
    # If SKU Matches Surface_3_Nag
    # Run the remote script to download and install the driver
    Write-Host "SKU Found: $sku" -ForegroundColor Yellow
    Invoke-Expression (Invoke-WebRequest -Uri $Surface_3_NAG -UseBasicParsing).Content
    
} elseif ($model -eq "Surface 3") {
    # If Model Matches Surface 3
    # Run the remote script to download and install the driver
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Invoke-Expression (Invoke-WebRequest -Uri $Surface_3_NAG -UseBasicParsing).Content

} else {
    # Neither SKU nor Model matches the expected values
    Write-Host "Model not recognized. No updated drivers available for this model. Exiting script." -ForegroundColor Red
}
