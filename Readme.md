This rasptory is to add missing Microsoft surfaces Drivers. 

How i do this, Is by going into WINPE and find these errors. 

WARNING: Error Hardware that requires Drivers to function properly

Surface_3_Nag (North America)
Name                                        DeviceID
----                                        --------
**Bluetooth and Wireless LAN Composite Device** USB\VID_1286&PID_204C\0000000000000000

**Multimedia Controller **                      PCI\VEN_8086&DEV_22B8&SUBSYS_00091414&REV_20\3&11583659&0&18

PCI Encryption/Decryption Controller **       PCI\VEN_8086&DEV_2298&SUBSYS_72708086&REV_20\3&11583659&0&D0

**Surface Touch Servicing ML **                 ACPI\VEN_MSHW&DEV_0102&SUBSYS_MSHWTSAM&REV_100CD14\4&E940C90&0

----                                        --------

I see i am missing ** Surface Touch Servicing ML  ** 

I then use the  **PNPUTIL /add-driver <filename.inf | *.inf> [/subdirs] [/install] [/reboot]** command to norrow down where my issue is. 

https://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/pnputil-command-syntax

Once i see where the issue is, I document it here hoping we can fix it in later release of OSDDeploy

----                                        --------
To start using this script.
in WinPE, be connected to the internet. 
Open a powershell 
Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.ps1" -UseBasicParsing).Content

It is recommended to copy past the oflline.ps1 file and run it localy in your startnet.cmd file.

What the offline.ps1 does, It checks if your online, Then updates this rasptory offline, If your ever offline it will just use the offline Drivers instead. 

----                                        --------
Currently knows issues as of 10/29/2023

I vote for this as well, My issues i would like to resolve are touch screen, Keyboard, WIFI Drivers in WinRE, WinPE.
Currently, it seems as if i have these 3 issues with different types of models in surfaces. I keep needing to plug in my USB Keyboard and mouse for most of the surfaces.

I will update this list of drivers missing in Surface WinPE/RE

Surface Pro 1, WIfi ✔️ | Touch ✔️| Keybord ❔ (bulky)
Surface Pro 2, WIfi ✔️ | Touch ✔️| Keybord ❔ (bulky)
Surface Pro 3, WIfi ✔️ | Touch ✔️| Keybord ❔
Surface pro 4, Wifi ❌ | Touch ❔ | KeyBoard ✔️
Surface pro 5, Wifi ❌ | Touch ❌| KeyBoard ✔️(5th Gen)
Surface pro 7, Wifi ✔️ | Touch ❌| KeyBoard ✔️

Surface 3 WIFI, WIfi ❌ | Touch ❌| Keybord ❔
Surface 3 NAG, WIfi ✔️ | Touch ❌| Keybord ✔️ (LTE North Ameirca)

Surface Laptop 4, Wifi ✔️ | Touch ❌ | KeyBoard ✔️
