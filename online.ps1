# Use this script with a one-liner
#Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content

# Get the system SKU and model
$sku = (Get-ComputerInfo).CssystemSkuNumber
$model = (Get-WmiObject -Class Win32_ComputerSystem).Model

# It Looks Like All Surface_3 Models Use the same touch drivers, However, I am still implementing it here If I find a discovery. 
$Surface_3_NAG = "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0/Surface_3_NAG.PS1"
$Surface_3_WIFI = "https://example.com/driver-path/"
$Surface_3_US2 = "https://example.com/driver-path/"

$SurfaceBook = "https://example.com/driver-path/"
$SurfaceBook2 = "https://example.com/driver-path/"
$SurfaceBook3 = "https://example.com/driver-path/"

$SurfaceLaptop = "https://example.com/driver-path/"
$SurfaceLaptop2 = "https://example.com/driver-path/"
$SurfaceLaptop3 = "https://example.com/driver-path/"
$SurfaceLaptop4 = "https://example.com/driver-path/"
$SurfaceLaptop5 = "https://example.com/driver-path/"

$SurfaceLaptopGo = "https://example.com/driver-path/"
$SurfaceLaptopStudio = "https://example.com/driver-path/"

$SurfacePro = "https://example.com/driver-path/"
$SurfacePro2 = "https://example.com/driver-path/"
$SurfacePro3 = "https://example.com/driver-path/"
$SurfacePro4 = "https://example.com/driver-path/"
$SurfacePro5thGen = "https://example.com/driver-path/"
$SurfacePro6 = "https://example.com/driver-path/"
$SurfacePro7 = "https://example.com/driver-path/"
$SurfacePro7Plus = "https://example.com/driver-path/"
$SurfacePro8 = "https://example.com/driver-path/"
$SurfacePro9 = "https://example.com/driver-path/"

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

} elseif ($model -eq "Surface Book") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model already has Touch, Keyboard, Wifi Drivers working in WinPE" -ForegroundColor green

    Write-Host "Attempting New download method" -ForegroundColor Red
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    Invoke-WebPSScript "https://github.com/AkosBakos/OSDCloud/blob/main/Install-EmbeddedProductKey.ps1" -Wait
    #Invoke-Expression (Invoke-WebRequest -Uri $SurfaceBook -UseBasicParsing).Content

} elseif ($model -eq "Surface Book 2") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceBook2 -UseBasicParsing).Content

} elseif ($model -eq "Surface Book 3") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceBook3 -UseBasicParsing).Content


} elseif ($model -eq "Surface Laptop") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceLaptop -UseBasicParsing).Content

} elseif ($model -eq "Surface Laptop 2") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceLaptop2 -UseBasicParsing).Content

} elseif ($model -eq "Surface Laptop 3") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceLaptop3 -UseBasicParsing).Content

} elseif ($model -eq "Surface Laptop 4") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceLaptop4 -UseBasicParsing).Content

} elseif ($model -eq "Surface Laptop 5") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceLaptop5 -UseBasicParsing).Content

} elseif ($model -eq "Surface Laptop Go") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceLaptopGo -UseBasicParsing).Content

} elseif ($model -eq "Surface Laptop Studio") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfaceLaptopStudio -UseBasicParsing).Content



} elseif ($sku -eq "Surface_Pro") { 
    Write-Host "SKU Found: $model" -ForegroundColor Yellow
    Write-Host "This SKU is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    #Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro -UseBasicParsing).Content


} elseif ($model -eq "Surface Pro 2") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro2 -UseBasicParsing).Content

} elseif ($model -eq "Surface Pro 3") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro3 -UseBasicParsing).Content

} elseif ($model -eq "Surface Pro 4") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro4 -UseBasicParsing).Content

} elseif ($sku -eq "Surface_Pro_1796") { 
    Write-Host "SKU Found: $sku We used SKU to avoid conflict with 2 models having same name." -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red

    #Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AkosBakos/OSDCloud/main/OSDCloud_Start.ps1" -OutFile "OSDCloud_Start.ps1"
    Invoke-WebRequest -Uri "https://raw.githubusercontent.com/GregoryB74/OSD-Cloud/main/OSDCloud_Start.ps1" -OutFile "OSDCloud_Start.ps1"

    #Invoke-WebRequest -Uri "https://raw.githubusercontent.com/AkosBakos/OSDCloud/main/Install-EmbeddedProductKey.ps1" -OutFile "Install-EmbeddedProductKey.ps1"
    Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
    .\Install-EmbeddedProductKey.ps1

    #Invoke-Expression (Invoke-WebRequest -Uri "https://github.com/AkosBakos/OSDCloud/blob/main/Install-EmbeddedProductKey.ps1" -UseBasicParsing).Content
    #Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro5thGen -UseBasicParsing).Content

} elseif ($sku -eq "Surface_Pro_1807") { 
    Write-Host "SKU Found: $sku We used SKU to avoid conflict with Pro 1 and Pro 5 Gen models having same name." -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    #Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro5thGen -UseBasicParsing).Content

} elseif ($model -eq "Surface Pro 6") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro6 -UseBasicParsing).Content

} elseif ($model -eq "Surface Pro 7") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro7 -UseBasicParsing).Content

} elseif ($model -eq "Surface Pro 7+") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro7Plus -UseBasicParsing).Content

} elseif ($model -eq "Surface Pro 8") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro8 -UseBasicParsing).Content

} elseif ($model -eq "Surface Pro 9") { 
    Write-Host "Model Found: $model" -ForegroundColor Yellow
    Write-Host "This model is not yet investigated. Please report any issues in WinPE" -ForegroundColor red
    Invoke-Expression (Invoke-WebRequest -Uri $SurfacePro9 -UseBasicParsing).Content

    

} else {
    # Neither SKU nor Model matches the expected values
    Write-Host "Model not recognized. No updated drivers are available for this model. Exiting script." -ForegroundColor Red
    Write-Host "To run this script again type: " -ForegroundColor Yellow
    Write-Host 'Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content"' -ForegroundColor Yellow 
}


#Extra code not needed, Using it as reffrence.  
$surfaceModels = @(
    "Surface 3",
    "Surface Book",
    "Surface Book 2",
    "Surface Book 3",
    "Surface Go",
    "Surface Go 2",
    "Surface Go 3",
    "Surface Hub 2",
    "Surface Hub 2S",
    "Surface Laptop",
    "Surface Laptop 2",
    "Surface Laptop 3",
    "Surface Laptop 4",
    "Surface Laptop 5",
    "Surface Laptop Go",
    "Surface Laptop Studio",
    "Surface Pro",
    "Surface Pro 2",
    "Surface Pro 3",
    "Surface Pro 4",
    "Surface Pro (5th Gen)",
    "Surface Pro 6",
    "Surface Pro 7",
    "Surface Pro 7+",
    "Surface Pro 8",
    "Surface Pro 9",
    "Surface Studio",
    "Surface Studio 2",
    "Surface Studio 2+"
)

# This is temprerry here so i can report issues.
$surfaceSKU = @(
    "Surface_3",
    "Surface_3_US1",
    "Surface_3_US2",
    "Surface_3_NAG",
    "Surface_3_ROW",
    "Surface_Book",
    "Surface_Book_1832",
    "Surface_Book_1793",
    "Surface_Book_3_1900",
    "Surface_Book_3_1899",
    "Surface_Go_1824_Commercial",
    "Surface_Go_1824_Consumer",
    "Surface_Go_1825_Commercial",
    "Surface_Go_2_1926",
    "Surface_Go_2_1901",
    "Surface_Go_2_1927",
    "Surface_Go_3_1926",
    "Surface_Go_3_1901",
    "Surface_Go_3_2022",
    "Surface_Hub_2",
    "Surface_Hub_2S",
    "Surface_Hub_2S_85",
    "Surface_Laptop",
    "Surface_Laptop_2_1769_Commercial",
    "Surface_Laptop_2_1769_Consumer",
    "Surface_Laptop_3_1867:1868",
    "Surface_Laptop_3_1873",
    "Surface_Laptop_3_1872",
    "Surface_Laptop_4_1958:1959",
    "Surface_Laptop_4_1950:1951",
    "Surface_Laptop_4_1952:1953",
    "Surface_Laptop_4_1978:1979",
    "Surface_Laptop_5_1950:1951",
    "Surface_Laptop_5_for_Business_1950:1951",
    "Surface_Laptop_5_1979",
    "Surface_Laptop_5_for_Business_1979",
    "Surface_Laptop_Go_1943",
    "Surface_Laptop_Studio_1964",
    "Surface_Pro",
    "Surface_Pro_2",
    "Surface_Pro_3",
    "Surface_Pro_4",
    "Surface_Pro_1796",
    "Surface_Pro_1807",
    "Surface_Pro_6_1796_Commercial",
    "Surface_Pro_6_1796_Consumer",
    "Surface_Pro_7_1866",
    "Surface_Pro_7+_1960",
    "Surface_Pro_7+_with_LTE_Advanced_1961",
    "Surface_Pro_8_for_Business_1983",
    "Surface_Pro_8_1983",
    "Surface_Pro_8_for_Business_with_LTE_Advanced_1982",
    "Surface_Pro_9_2038",
    "Surface_Pro_9_for_Business_2038",
    "Surface_Pro_9_With_5G_1997",
    "Surface_Pro_9_With_5G_1996",
    "Surface_Studio",
    "Surface_Studio_2_1707_Commercial",
    "Surface_Studio_2+_2028"
)

