# Use this script with a one-liner
# Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content

# Get the system SKU and model
$sku = (Get-ComputerInfo).CssystemSkuNumber
$model = (Get-WmiObject -Class Win32_ComputerSystem).Model

# It Looks Like All Surface_3 Models Use the same touch drivers, However, I am still implementing it here If I find a discovery. 
$Surface_3_NAG = "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0/Surface_3_NAG.PS1"
$Surface_3_WIFI = "https://NotYetImplemented.com/"
$Surface_3_US2 = "https://NotYetImplemented.com/"
$Surface_Pro4 = "https://NotYetImplemented.com/"

# Check SKU
if ($sku -eq "Surface_3_Nag") {
    # If SKU Matches Surface_3_Nag
    # Run the remote script to download and install the driver
    Write-Host "SKU Found: $sku" -ForegroundColor Yellow
    Invoke-Expression (Invoke-WebRequest -Uri $Surface_3_NAG -UseBasicParsing).Content

} elseif ($sku -eq "Surface_3_US2") {
    # If SKU Matches Surface_3_US
    # Run the remote script to download and install the driver
    Write-Host "SKU Found: $sku" -ForegroundColor Yellow
    Invoke-Expression (Invoke-WebRequest -Uri $Surface_3_NAG -UseBasicParsing).Content

} elseif ($sku -eq "Surface_3_WIFI") {
    # If sku Matches Surface_3_WIFI
    Write-Host "sku Found: $sku" -ForegroundColor Yellow
    Invoke-Expression (Invoke-WebRequest -Uri $Surface_3_NAG -UseBasicParsing).Content

} elseif ($model -eq "Surface 3") {
    # If the SKU is not recognized, check if the computer model matches "Surface 3"
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Invoke-Expression (Invoke-WebRequest -Uri $Surface_3_NAG -UseBasicParsing).Content

} elseif ($model -eq "Surface Pro 4") {
    # If Model Matches Surface 4 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Invoke-Expression (Invoke-WebRequest -Uri $Surface_Pro4 -UseBasicParsing).Content

} else {
    # Neither SKU nor Model matches the expected values
    Write-Host "Model not recognized. No updated drivers are available for this model. Exiting script." -ForegroundColor Red
    Write-Host "To run this script again type: " -ForegroundColor Yellow
    Write-Host 'Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content"' -ForegroundColor Yellow 
}
