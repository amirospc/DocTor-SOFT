@echo off
color 0A
echo ===== Windows Repair and Optimization Script =====
echo.
echo 1- Cleaning Temp files...
del /s /f /q %temp%\*
del /s /f /q C:\Windows\Temp\*
echo.
echo 2- Flushing DNS...
ipconfig /flushdns
echo.
echo 3- Renew IP...
ipconfig /release
ipconfig /renew
echo.
echo 4- Reset Winsock...
netsh winsock reset
echo.
echo 5- Reset IP stack...
netsh int ip reset
echo.
echo 6- Checking system files...
sfc /scannow
echo.
echo 7- Repair Windows image...
DISM /Online /Cleanup-Image /CheckHealth
DISM /Online /Cleanup-Image /ScanHealth
DISM /Online /Cleanup-Image /RestoreHealth
echo.
echo 8- Check disk errors...
chkdsk C: /f
echo.
echo 9- Open disk cleanup...
cleanmgr
echo.
echo 10- System information...
systeminfo
echo.
echo 11- Network configuration...
ipconfig /all
echo.
echo 12- Show running tasks...
tasklist
echo.
echo 13- Check driver issues...
driverquery
echo.
echo 14- Check memory...
mdsched
echo.
echo 15- Open services manager...
services.msc
echo.
echo 16- Open device manager...
devmgmt.msc
echo.
echo 17- Open system configuration...
msconfig
echo.
echo 18- Open disk management...
diskmgmt.msc
echo.
echo 19- Open event viewer...
eventvwr
echo.
echo 20- Done. Restart recommended.
pause