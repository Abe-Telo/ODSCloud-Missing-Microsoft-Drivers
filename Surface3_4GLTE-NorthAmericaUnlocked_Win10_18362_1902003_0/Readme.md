Run this to get your touch working on your Surface_3_NAG. 


pnputil.exe /add-driver E:\Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0\SurfaceUpdate\Drivers\Display\SurfaceTouchScreenDriver\* /subdirs /install

pnputil.exe /add-driver E:\Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0\SurfaceUpdate\Drivers\System\SPI\* /subdirs /install


Or update touch drivers from a script with winpe with 1 line of code. 

Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/Surface3_4GLTE-NorthAmericaUnlocked_Win10_18362_1902003_0/Surface_3_NAG.PS1" -UseBasicParsing).Content

