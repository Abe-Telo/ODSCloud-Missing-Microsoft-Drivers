@ECHO OFF
wpeinit
cd\ 

setlocal enabledelayedexpansion 
net start wlansvc 
powershell set-wifi -SSID MY_WIFI_SSID -PSK MY_WIFI_PASSWORD

:: I have 2 locations. So if the Surface is at location 1, It will connect to 1, If fail connect to 2.
ping 8.8.8.8 -n 3
if errorlevel 1 ( 
    powershell set-wifi -SSID MY_WIFI2_SSID -PSK MY_WIFI2_PASSWORD
) 
echo Starting KeyBoard Min Mode
start /min osk

:: The Concept. 
powershell -command "$filePathE = 'E:\OSDCloud\DriverPack\ODSCloud-Missing-Microsoft-Drivers-main\offline.ps1'; $filePathD = 'D:\OSDCloud\DriverPack\ODSCloud-Missing-Microsoft-Drivers-main\offline.ps1'; if (Test-Path $filePathE) { Start-Process -NoNewWindow -FilePath 'powershell' -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File', $filePathE } elseif (Test-Path $filePathD) { Start-Process -NoNewWindow -FilePath 'powershell' -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File', $filePathD } else { Write-Host 'Script not found in either location.'; powershell Invoke-Expression (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1' -UseBasicParsing).Content }"
Echo TEMP: For this test, I see it failing, lets try making it work directly. 
start powershell  -command Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content
Echo I am leaving a Echo, for those who want to copy past. 
echo Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content

   
:: OSDCloud related commands
powershell -NoL -C Initialize-OSDCloudStartnet
powershell -NoL -C Initialize-OSDCloudStartnetUpdate
powershell -NoL -C Install-Module -Name OSD -Force
powershell -NoL -C Import-Module OSD -Force

:: Starting the OSDCloud GUI 
@ECHO OFF
start PowerShell -NoL
start /wait PowerShell -NoL -W Mi -C Start-OSDCloudGUI
