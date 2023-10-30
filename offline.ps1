#This Script is the base line of everything. 
#Copy this script into online.ps1, And add it to your startnet.cmd file
# .\online.PS1

# Test if online
$online = Test-Connection -ComputerName 8.8.8.8 -Count 1 -Quiet

if ($online) {
    # If online, fetch and run the script from the URL
    try {
        Invoke-Expression (Invoke-WebRequest -Uri "https://raw.githubusercontent.com/Abe-Telo/ODSCloud-Missing-Microsoft-Drivers/main/online.PS1" -UseBasicParsing).Content
    } catch {
        Write-Error "Failed to fetch or execute the online script."
    }
} else {
    # If offline, run the local script
    if (Test-Path .\online.PS1) {
        .\online.PS1
    } else {
        Write-Error "The local script start.PS1 does not exist in the current directory."
    }
}
