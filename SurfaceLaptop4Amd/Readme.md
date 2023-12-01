This fix Keybord Drivers. Durring test i was also able to get Touch and keyboard to work, However i was not able to yet norrow down what folders are needed for touch drivers. To help keep this raspetory clean, i am sticking to Keybord drivers and when i fix comes i will patch a fix for touch. 

Keybord Folders that will get your mouse and keybord working. 

pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amdspi\* /subdirs /install

pnputil.exe /add-driver E:\OSDCloud\DriverPacks\Microsoft\lap4amd\SurfaceUpdate\amduart\* /subdirs /install

____________________________________________________________________

During test i ran all these, But yet to find the drivers that are needed.
i have a therey, i need to run 

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

I might as well uploud all and remove drivers 1 by 1 during test. 
