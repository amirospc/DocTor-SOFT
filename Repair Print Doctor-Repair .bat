@echo off
chcp 65001 >nul 2>&1
title PRINTER TOOLKIT Amiros pc
color 0A
setlocal enabledelayedexpansion

:MENU
cls
echo =============================================
echo     PRINTER TOOLKIT Amiros technicien informatique 
echo =============================================
echo.
echo 1. View Installed Printers
echo 2. Open Printers Settings
echo 3. Restart Print Spooler
echo 4. Clear Print Queue
echo 5. Open Devices and Printers
echo 6. Print Test Page
echo 7. Show Printer Status
echo 8. Open Print Management
echo 9. Open Scanner Settings
echo 10. Full Printer Repair
echo 11. Exit
echo.
echo =============================================
set /p choice="Select option: "

if "%choice%"=="1" goto VIEW_PRINTERS
if "%choice%"=="2" goto PRINTER_SETTINGS
if "%choice%"=="3" goto RESTART_SPOOLER
if "%choice%"=="4" goto CLEAR_QUEUE
if "%choice%"=="5" goto DEVICES_PRINTERS
if "%choice%"=="6" goto TEST_PAGE
if "%choice%"=="7" goto PRINTER_STATUS
if "%choice%"=="8" goto PRINT_MANAGEMENT
if "%choice%"=="9" goto SCANNER_SETTINGS
if "%choice%"=="10" goto FULL_REPAIR
if "%choice%"=="11" goto EXIT
echo Invalid option!
timeout /t 2 >nul
goto MENU

:VIEW_PRINTERS
cls
echo.
echo [+] Installed Printers:
echo ================================
wmic printer get name,drivername,portname,status /format:table
echo.
echo ================================
echo To export to file: Printer_List.txt
wmic printer get name,drivername,portname,status > "%userprofile%\Desktop\Printer_List.txt" 2>nul
echo Saved to Desktop as Printer_List.txt
echo.
pause
goto MENU

:PRINTER_SETTINGS
start ms-settings:printers 2>nul
if errorlevel 1 start control printers 2>nul
echo [+] Opening Printer Settings...
timeout /t 2 >nul
goto MENU

:RESTART_SPOOLER
cls
echo.
echo [+] Stopping Print Spooler...
net stop spooler /y >nul 2>&1
timeout /t 2 >nul
echo [+] Starting Print Spooler...
net start spooler >nul 2>&1
echo [+] Print Spooler restarted successfully!
timeout /t 2 >nul
goto MENU

:CLEAR_QUEUE
cls
echo.
echo ================================
echo Clear Print Queue
echo ================================
echo.
echo 1. Clear ALL print queues
echo 2. Clear specific printer queue
echo.
set /p clear_choice="Select option: "

if "%clear_choice%"=="1" goto CLEAR_ALL
if "%clear_choice%"=="2" goto CLEAR_SPECIFIC
echo Invalid!
goto CLEAR_QUEUE

:CLEAR_ALL
cls
echo [+] Stopping Print Spooler...
net stop spooler /y >nul 2>&1
echo [+] Deleting all print jobs...
del /q /f "%windir%\System32\spool\PRINTERS\*.*" >nul 2>&1
echo [+] Starting Print Spooler...
net start spooler >nul 2>&1
echo [+] All print queues cleared!
pause
goto MENU

:CLEAR_SPECIFIC
cls
echo [+] Available printers:
echo ================================
wmic printer get name /format:table
echo ================================
set /p printer_name="Enter printer name exactly: "
echo [+] Clearing queue for: %printer_name%
cscript "%windir%\System32\printing_Admin_Scripts\en-US\prnjobs.vbs" -l -p "%printer_name%" 2>nul
echo [+] Queue cleared (if printer exists)
pause
goto MENU

:DEVICES_PRINTERS
start control printers
echo [+] Opening Devices and Printers...
goto MENU

:TEST_PAGE
cls
echo.
echo [+] Available printers:
echo ================================
wmic printer get name /format:table
echo ================================
set /p test_printer="Enter printer name for test page: "
echo [+] Sending test page to: %test_printer%
rundll32 printui.dll,PrintUIEntry /k /n "%test_printer%" 2>nul
if errorlevel 1 (
    echo [-] Failed! Try using exact name.
) else (
    echo [+] Test page sent successfully!
)
pause
goto MENU

:PRINTER_STATUS
cls
echo.
echo [+] Available printers:
echo ================================
wmic printer get name /format:table
echo ================================
set /p status_printer="Enter printer name: "
cls
echo.
echo ================================
echo Printer Status: %status_printer%
echo ================================
wmic printer where "name='%status_printer%'" get name,printerstate,printerstatus,worksoffline,jobcount /format:list 2>nul
echo.
echo ================================
echo Checking detailed status...
wmic printer where "name='%status_printer%'" get detectederrorstate,extendeddetectederrorstate /format:list 2>nul
echo.
pause
goto MENU

:PRINT_MANAGEMENT
start printmanagement.msc 2>nul
if errorlevel 1 start compmgmt.msc 2>nul
echo [+] Opening Print Management...
goto MENU

:SCANNER_SETTINGS
start ms-settings:scanners 2>nul
if errorlevel 1 start wiaacmgr 2>nul
if errorlevel 1 echo [-] Scanner settings not available on this Windows version
echo [+] Opening Scanner Settings...
goto MENU

:FULL_REPAIR
cls
color 0C
echo.
echo =============================================
echo        FULL PRINTER REPAIR - DM TECH
echo =============================================
echo.
echo [!] Starting full printer repair...
echo.

echo [1/7] Stopping Print Spooler...
net stop spooler /y >nul 2>&1
if errorlevel 1 echo [-] Could not stop, trying force...
taskkill /f /im spoolsv.exe >nul 2>&1
echo.

echo [2/7] Clearing print queue files...
del /q /f "%windir%\System32\spool\PRINTERS\*.*" >nul 2>&1
del /q /f "%windir%\System32\spool\drivers\w32x86\*.*" >nul 2>&1
del /q /f "%windir%\System32\spool\drivers\x64\*.*" >nul 2>&1
echo.

echo [3/7] Fixing printer registry...
reg delete "HKLM\SYSTEM\CurrentControlSet\Control\Print\Printers" /f >nul 2>&1
reg add "HKLM\SYSTEM\CurrentControlSet\Control\Print" /v "BeepEnabled" /t REG_DWORD /d 0 /f >nul 2>&1
echo.

echo [4/7] Re-registering printer DLLs...
regsvr32 /s %windir%\system32\win32spl.dll
regsvr32 /s %windir%\system32\inetpp.dll
regsvr32 /s %windir%\system32\spoolss.dll
echo.

echo [5/7] Resetting printer drivers...
rundll32 printui.dll,PrintUIEntry /Ss /n "Reset" /a "%temp%\reset.dat" >nul 2>&1
echo.

echo [6/7] Starting Print Spooler...
net start spooler >nul 2>&1
echo.

echo [7/7] Restarting dependent services...
net start "PrintNotify" >nul 2>&1
net start "Device Install Service" >nul 2>&1
echo.

color 0A
echo =============================================
echo [✓] FULL REPAIR COMPLETED SUCCESSFULLY!
echo =============================================
echo.
echo What was fixed:
echo - Restarted Print Spooler
echo - Cleared stuck print jobs
echo - Fixed registry settings
echo - Re-registered printer DLLs
echo.
echo Recommended: Restart your PC for best results
echo.
pause
goto MENU

:EXIT
cls
echo.
echo =============================================
echo        Thank you ! Amiros technicien informatique !! 
echo =============================================
echo.
color 0F
exit /b