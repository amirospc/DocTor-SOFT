@echo off
color 0A
title Repair Windows 10 / 11 by Moussa
echo ===================================
echo      Windows Repair Script
echo ===================================
echo Fixing Windows system files...
sfc /scannow
echo Repairing Windows image...
DISM /Online /Cleanup-Image /RestoreHealth
echo Reset Network...
netsh winsock reset
netsh int ip reset
ipconfig /flushdns
ipconfig /release
ipconfig /renew
echo Restarting Audio Service...
net stop audiosrv
net start audiosrv
echo Restart Bluetooth Service...
net stop bthserv
net start bthserv
echo Scan Hardware Devices...
pnputil /scan-devices
echo Cleaning temporary files...
del /q /f /s %temp%\*
echo ===================================
echo Repair Finished
echo Please Restart Your Computer
pause