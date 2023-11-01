@ECHO OFF
wpeinit
cd\ 

setlocal enabledelayedexpansion 
net start wlansvc 
powershell set-wifi -SSID MY_WIFI_SSID -PSK MY_WIFI_PASSWORD

:: I have 2 locations. So if the Surface is at location 1, It will connect to the 1st, If it fails, connect to the 2nd WIFI Location.
ping 8.8.8.8 -n 3
if errorlevel 1 ( 
    powershell set-wifi -SSID MY_WIFI2_SSID -PSK MY_WIFI2_PASSWORD
) 
echo Starting KeyBoard Min Mode
start /min osk

:: I found that if the time is not correct, then we get an SSL Error when invoking. To avoid this during Setup, I added this to update time.
:: However, we will not rely on the time but rather the date, And you might need to update the time by yourself.
::echo Updating the Date and time: America/New_York
::Powershell -Command "$response = Invoke-WebRequest -Uri 'http://worldtimeapi.org/api/timezone/America/New_York' -UseBasicParsing; $currentDateTime = ($response.Content | ConvertFrom-Json).utc_datetime; $date = Get-Date $currentDateTime -Format 'MM-dd-yyyy'; $time = Get-Date $currentDateTime -Format 'HH:mm:ss'; cmd /c date $date; cmd /c time $time"
::date /t  & time /t
 
echo Updating the Date and time: America/New_York

for %%X in (C D E) do (
    if exist %%X:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\date.ps1 (
        powershell -ExecutionPolicy Bypass -NoProfile -File "%%X:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\date.ps1"
        echo Done: Date Updated.
        goto enddate
    )
)
:enddate


:: To be tested.  
::echo Updating the Date and time: America/New_York
:: Call PowerShell script to get the IFS type USB drive
::for /f %%i in ('powershell -ExecutionPolicy Bypass -NoProfile -File "GetUSBDrive.ps1"') do set usbDrive=%%i

:: Check if the required file exists in the detected USB drive
::if exist %usbDrive%:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\date.ps1 (
::    powershell -ExecutionPolicy Bypass -NoProfile -File "%usbDrive%:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\date.ps1"
::    echo Done: Date Updated.
::) else (
::    echo Error: File not found on USB drive.
::)



:: Check for internet connection by pinging a known reliable IP
ping -n 1 8.8.8.8 > NUL 2>&1

if %errorlevel% equ 0 (
    echo Internet connection detected. Executing remote script...
    powershell -ExecutionPolicy Bypass -NoProfile -Command "Invoke-Expression (Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/start.ps1' -UseBasicParsing).Content"
    goto end
) else (
    echo No internet connection. Searching for local script...
    for %%X in (C D E) do (
        if exist %%X:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\start.ps1 (
            echo Found local script at %%X:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\start.ps1
            powershell -ExecutionPolicy Bypass -NoProfile -File "%%X:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\start.ps1"
            goto end
        )
    )
)

:end
echo Script finished. 





:: The Concept: This script looks for the file name offline.ps1 locally in drive, E,D,C. If it does not find it, It will download it for the next offline run.
:: If you ever need an update, All you need to do is be connected to the internet. 
:: Offline.ps1 should have its own command for its updates, If you are online, Otherwise it uses the local known drivers. 

::SETLOCAL

::REM Define paths
::SET scriptPathE=E:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\offline.ps1
::SET scriptPathD=D:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\offline.ps1
::SET scriptPathC=C:\OSDCloud\DriverPacks\ODSCloud-Missing-Microsoft-Drivers-main\offline.ps1
::SET onlineScriptURL=https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1

::REM Check for the existence of offline.ps1 in predefined paths and execute if found
::FOR %%P IN (%scriptPathE% %scriptPathD% %scriptPathC%) DO (
::    IF EXIST %%P (
::        ECHO Found offline.ps1 on: %%~dP
::        START powershell -NoProfile -ExecutionPolicy Bypass -File "%%P"
::        EXIT /B
::    )
::) 

::REM If offline.ps1 is not found in any location, try downloading and executing online.ps1
::ECHO Script offline.ps1 not found in any location. Downloading...
::powershell -command "Invoke-Expression (Invoke-WebRequest -Uri '%onlineScriptURL%' -UseBasicParsing).Content"
::ECHO Finished executing the online script.

::ENDLOCAL
   
:: OSDCloud related commands
powershell -NoL -C Initialize-OSDCloudStartnet
powershell -NoL -C Initialize-OSDCloudStartnetUpdate
powershell -NoL -C Install-Module -Name OSD -Force
powershell -NoL -C Import-Module OSD -Force

:: Starting the OSDCloud GUI 
@ECHO OFF
start PowerShell -NoL
start /wait PowerShell -NoL -W Mi -C Start-OSDCloudGUI
