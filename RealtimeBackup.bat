@echo off
title Smart Light Backup
color 0A

:: =========================
:: PATHS
:: =========================

set "SOURCE=F:\Mes Documents Globales"
set "DEST=C:\Users\%USERNAME%\Dropbox\Mes Documents Globales"

if not exist "%DEST%" mkdir "%DEST%"

echo ===================================
echo SOURCE : %SOURCE%
echo DEST   : %DEST%
echo ===================================
echo.

:: =========================
:: FIRST SYNC
:: =========================

echo Initial Sync...
robocopy "%SOURCE%" "%DEST%" /E /XO /MT:4 /R:1 /W:2

echo.
echo Backup Running Every 10 Seconds...
echo.

:: =========================
:: LOOP
:: =========================

:LOOP

timeout /t 7200 >nul

robocopy "%SOURCE%" "%DEST%" ^
/E ^
/XO ^
/MT:4 ^
/R:1 ^
/W:2 ^
/FFT ^
/Z ^
/NP ^
/NFL ^
/NDL >nul

goto LOOP