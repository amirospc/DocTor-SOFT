@echo off
title Ultimate PC Toolkit PRO Amirospc
mode con: cols=60 lines=30
color 0A
:: ===== MENU =====
:menu
cls
echo ==================================
echo        ULTIMATE PC TOOLKIT PRO
echo ==================================
echo.
echo [1] Clean Temp Files
echo [2] Flush DNS
echo [3] Show IP Info
echo [4] System Info (Quick)
echo [5] Disk Check
echo [6] Repair Windows (SFC)
echo [7] Restart Explorer
echo [8] Network Reset
echo [9] Running Tasks
echo [10] Kill Chrome
echo [11] Battery Report
echo [12] Disk Usage
echo [13] Control Panel
echo [14] Task Manager
echo [15] Services
echo [16] Device Manager
echo [17] Show WiFi Passwords
echo [18] Restart PC
echo [19] Shutdown PC
echo [0] Exit
echo.
set /p choice=Choose option: 

if "%choice%"=="1" goto temp
if "%choice%"=="2" goto dns
if "%choice%"=="3" goto ip
if "%choice%"=="4" goto sys
if "%choice%"=="5" goto chkdsk
if "%choice%"=="6" goto sfc
if "%choice%"=="7" goto explorer
if "%choice%"=="8" goto netreset
if "%choice%"=="9" goto tasks
if "%choice%"=="10" goto chrome
if "%choice%"=="11" goto battery
if "%choice%"=="12" goto disk
if "%choice%"=="13" goto control
if "%choice%"=="14" goto taskmgr
if "%choice%"=="15" goto services
if "%choice%"=="16" goto devmgmt
if "%choice%"=="17" goto wifi
if "%choice%"=="18" goto restart
if "%choice%"=="19" goto shutdown
if "%choice%"=="0" exit

goto menu

:: ===== FUNCTIONS =====

:temp
cls
echo Cleaning Temp Files...
del /s /f /q %temp%\* >nul 2>&1
echo Done!
pause
goto menu

:dns
cls
echo Flushing DNS...
ipconfig /flushdns
pause
goto menu

:ip
cls
ipconfig
pause
goto menu

:sys
cls
echo ==== SYSTEM INFO ====
echo Computer Name: %computername%
echo User: %username%
echo OS: %os%
echo Processor: %processor_identifier%
echo.
pause
goto menu

:chkdsk
cls
echo Checking Disk...
chkdsk C:
pause
goto menu

:sfc
cls
echo Repairing System...
sfc /scannow
pause
goto menu

:explorer
cls
echo Restarting Explorer...
taskkill /f /im explorer.exe >nul
start explorer.exe
goto menu

:netreset
cls
echo Resetting Network...
netsh winsock reset
netsh int ip reset
pause
goto menu

:tasks
cls
tasklist
pause
goto menu

:chrome
cls
echo Closing Chrome...
taskkill /f /im chrome.exe
pause
goto menu

:battery
cls
powercfg /batteryreport
echo Report saved in system folder!
pause
goto menu

:disk
cls
wmic logicaldisk get caption,freespace,size
pause
goto menu

:control
control
goto menu

:taskmgr
taskmgr
goto menu

:services
services.msc
goto menu

:devmgmt
devmgmt.msc
goto menu

:wifi
cls
echo Saved WiFi Networks:
netsh wlan show profile
echo.
set /p name=Enter WiFi name: 
netsh wlan show profile name="%name%" key=clear
pause
goto menu

:restart
shutdown /r /t 0

:shutdown
shutdown /s /t 0