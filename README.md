# Block-AdobeApps
PowerShell script to automatically create Windows Firewall rules to prevent Adobe programs from accessing the interwebs.  The advantage of doing this vs editing your hosts file or using a DNS filter is that domain names are subject to change but the location of the installed software on your PC is unlikely to.

## Usage
```powershell
./Block-AdobeApps.ps1
```
