This rasptory is to add missing Microsoft surfaces Drivers. 

How i do this, Is by going into WINPE and find these errors. 

WARNING: Error Hardware that requires Drivers to function properly

Surface_3_Nag (North America)
Name                                        DeviceID
----                                        --------
Bluetooth and Wireless LAN Composite Device USB\VID_1286&PID_204C\0000000000000000

Multimedia Controller                       PCI\VEN_8086&DEV_22B8&SUBSYS_00091414&REV_20\3&11583659&0&18

PCI Encryption/Decryption Controller        PCI\VEN_8086&DEV_2298&SUBSYS_72708086&REV_20\3&11583659&0&D0

Surface Touch Servicing ML                  ACPI\VEN_MSHW&DEV_0102&SUBSYS_MSHWTSAM&REV_100CD14\4&E940C90&0

I see i am missing ** Surface Touch Servicing ML  ** 

I then use the  **PNPUTIL /add-driver <filename.inf | *.inf> [/subdirs] [/install] [/reboot]** command to norrow down where my issue is. 

https://learn.microsoft.com/en-us/windows-hardware/drivers/devtest/pnputil-command-syntax

Once i see where the issue is, I document it here hoping we can fix it in later release of OSDDeploy
