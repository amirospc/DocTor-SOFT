@echo off
title Ultimate Drive Letters Repair
color 0A

echo ==========================================
echo   ULTIMATE DRIVE LETTERS REPAIR TOOL
echo ==========================================
echo.

:: التحقق من الصلاحيات
net session >nul 2>&1
if %errorLevel% NEQ 0 (
    echo [ERROR] Run as Administrator required!
    pause
    exit
)

echo [1] Enabling Automount...
diskpart /s "%temp%\dm1.txt" >nul 2>&1
echo automount enable > "%temp%\dm1.txt"

echo [2] Scrubbing old mount points...
diskpart /s "%temp%\dm2.txt" >nul 2>&1
echo automount scrub > "%temp%\dm2.txt"

echo [3] Forcing Mount Manager reset...
mountvol /E

echo [4] Restarting Plug and Play service...
net stop plugplay >nul 2>&1
net start plugplay >nul 2>&1

echo [5] Restarting Virtual Disk service...
net stop vds >nul 2>&1
net start vds >nul 2>&1

echo [6] Re-enumerating disks...
wmic diskdrive list brief >nul

echo [7] Restarting Explorer...
taskkill /f /im explorer.exe >nul
start explorer.exe

echo.
echo ==========================================
echo DONE ✔
echo PLEASE RESTART YOUR PC NOW
echo ==========================================
pause