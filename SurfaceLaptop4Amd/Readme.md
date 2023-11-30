This fix Keybord Drivers, Durring test i was also able to get Touch to work, But i still need to get down to what files it was to keep it clean, Here is the drivers i used during test. 




Durring test 

I found that the Kebord needs theses 2 folders. 

Keybord 
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdspi\* /subdirs /install
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amduart\* /subdirs /install
____________________________________________________________________

As for the touch, it workd when i ran all of these, Of course the plan is to filter it, And this is why i am not implementing a fix yet. 
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdacpbus\* /subdirs /install
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amddrtm\* /subdirs /install
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdfendr\* /subdirs /install
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdgpio2\* /subdirs /install

pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdi2c\* /subdirs /install
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdlpcfilterdriver\* /subdirs /install


pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdmicropep\* /subdirs /install
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdpsp\* /subdirs /install
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdsmf\* /subdirs /install

For sure needed for touch
However i noticed if you run this first, Then the touch will not work, You need to run this after we find what drivers is needed. 
pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\surfacedigitizerhidspiextnpackage* /subdirs /install
At this point Touch worked douring test. 


