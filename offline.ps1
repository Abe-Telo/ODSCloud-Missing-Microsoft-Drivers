#Temporerry Allow this, So all my past USB update accoringly. 

         Write-Output "Fetching and executing extract_zip.ps1 from online source..."
        Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/extract_zip.ps1" -UseBasicParsing).Content
        
        #Possiably replaced this in the future. 
        Write-Output "Fetching and executing online.ps1 from online source..."
        Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content
 
#End Temp

# Use this script locally with a one-liner
# & "E:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\online.ps1"

# Determine the USB partition of type IFS
$usbDrive = Get-USBPartition | Where-Object { $_.Type -eq "IFS" } | Select-Object -ExpandProperty DriveLetter

# If there's no IFS type drive found, terminate the script
if (-not $usbDrive) {
    Write-Error "No USB partition with IFS type found. Exiting."
    return
}

# Get the system SKU and model
$sku = (Get-ComputerInfo).CssystemSkuNumber
$model = (Get-WmiObject -Class Win32_ComputerSystem).Model

# Local paths for each script adjusted for the USB drive
$basePath = "${usbDrive}:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main"
$Surface_3_NAG = "$basePath\Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0\Surface_3_NAG.PS1"
$Surface_3_WIFI = "$basePath\Surface_3_WIFI.PS1"
$Surface_3_US2 = "$basePath\Surface_3_US2.PS1"
$Surface_Pro4 = "$basePath\Surface_Pro4.PS1"
$Surface_Laptop_4_1952_1953 = "$basePath\SurfaceLaptop4Amd\Surface_Laptop_4Amd.ps1"

# Check SKU
if ($sku -eq "Surface_3_Nag") {
    Write-Host "SKU Found: $sku" -ForegroundColor Yellow
    & $Surface_3_NAG

} elseif ($sku -eq "Surface_3_US2") {
    Write-Host "SKU Found: $sku" -ForegroundColor Yellow
    & $Surface_3_NAG

} elseif ($sku -eq "Surface_3_WIFI") {
    Write-Host "sku Found: $sku" -ForegroundColor Yellow
    & $Surface_3_NAG

} elseif ($model -eq "Surface 3") {
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    & $Surface_3_NAG

} elseif ($model -eq "Surface Pro 4") {
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    & $Surface_Pro4
    
} elseif ($sku -eq "Surface_Laptop_4_1952:1953") {
    Write-Host "Model Found: $sku" -ForegroundColor Yellow
    & $Surface_Laptop_4_1952_1953

} else {
    Write-Host "Model not recognized. No updated drivers are available for this model. Exiting script." -ForegroundColor Red
    Write-Host "To run this script again, navigate to its location and execute:" -ForegroundColor Yellow
    Write-Host '.\online.ps1' -ForegroundColor Yellow 
}
