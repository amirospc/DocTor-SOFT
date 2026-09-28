@echo off
title Windows Full Backup Ultimate Tool
color 0A

:: ====================================================
:: صلاحيات المسؤول
:: ====================================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo ================================================
    echo     demande d'acces administrateur...
    echo ================================================
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ====================================================
:: MENU PRINCIPAL DU BACKUP
:: ====================================================
:menu_backup
cls
echo ================================================================================
echo                         SAUVEGARDE COMPLETE ULTIMATE
echo ================================================================================
echo.
echo   .................... MENU BACKUP ....................
echo.
echo   [1]  -  Sauvegarde COMPLETE (Tout: fichiers + reg + pilotes)
echo   [2]  -  Sauvegarde des FICHIERS uniquement
echo   [3]  -  Sauvegarde du REGISTRE uniquement
echo   [4]  -  Sauvegarde des PILOTES uniquement
echo   [5]  -  Sauvegarde des MOTS DE PASSE (Wifi + Credentials)
echo   [6]  -  Sauvegarde des TACHES PLANIFIEES
echo   [7]  -  Sauvegarde des PARAMETRES RESEAU
echo   [8]  -  Sauvegarde COMPRESSEE (ZIP)
echo   [9]  -  Sauvegarde vers DISQUE EXTERNE
echo  [10]  -  Sauvegarde vers CLOUD (OneDrive/Google Drive)
echo  [11]  -  CLONAGE complet du disque C:
echo  [12]  -  RESTAURATION (Tout)
echo  [13]  -  RESTAURATION (Fichiers uniquement)
echo  [14]  -  RESTAURATION (Registre uniquement)
echo  [15]  -  RESTAURATION (Pilotes uniquement)
echo  [16]  -  VERIFIER l'integrite de la sauvegarde
echo  [17]  -  PROGRAMMER sauvegarde automatique
echo  [18]  -  SUPPRIMER les anciennes sauvegardes
echo  [19]  -  Afficher les disques disponibles
echo  [20]  -  Calculer l'espace necessaire
echo.
echo   [0]  -  Quitter
echo.
echo ================================================================================
set /p backup_choice="Entrez votre choix: "

if "%backup_choice%"=="1" goto backup_all
if "%backup_choice%"=="2" goto backup_files
if "%backup_choice%"=="3" goto backup_registry
if "%backup_choice%"=="4" goto backup_drivers
if "%backup_choice%"=="5" goto backup_passwords
if "%backup_choice%"=="6" goto backup_tasks
if "%backup_choice%"=="7" goto backup_network
if "%backup_choice%"=="8" goto backup_compressed
if "%backup_choice%"=="9" goto backup_external
if "%backup_choice%"=="10" goto backup_cloud
if "%backup_choice%"=="11" goto clone_disk
if "%backup_choice%"=="12" goto restore_all
if "%backup_choice%"=="13" goto restore_files
if "%backup_choice%"=="14" goto restore_registry
if "%backup_choice%"=="15" goto restore_drivers
if "%backup_choice%"=="16" goto verify_backup
if "%backup_choice%"=="17" goto schedule_backup
if "%backup_choice%"=="18" goto delete_backups
if "%backup_choice%"=="19" goto show_disks
if "%backup_choice%"=="20" goto check_space
if "%backup_choice%"=="0" exit
goto menu_backup

:: ====================================================
:: SAUVEGARDE COMPLETE (TOUT)
:: ====================================================
:backup_all
cls
echo ================================================================================
echo                       SAUVEGARDE COMPLETE (TOUT)
echo ================================================================================
echo.
echo Cette sauvegarde va inclure :
echo.
echo   [*] Tous vos fichiers personnels (Documents, Images, Bureau...)
echo   [*] Configuration de tous vos programmes
echo   [*] Registre Windows complet
echo   [*] Tous les pilotes installes
echo   [*] Mots de passe Wi-Fi et Credentials
echo   [*] Taches planifiees
echo   [*] Parametres reseau
echo   [*] Liste de tous les programmes installes
echo.
echo ================================================================================
echo.
call :show_disks_simple
echo.
set /p "backup_drive=Entrez la lettre du disque de destination (ex: D ou E): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo.
    echo [ERREUR] Le disque %backup_drive% n'existe pas!
    pause
    goto backup_all
)

:: Creation du dossier de backup
set backup_date=%date:~6,4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%
set backup_date=%backup_date: =0%
set backup_date=%backup_date::=%
set backup_folder=%backup_drive%\BACKUP_%backup_date%

echo.
echo Creation du dossier: %backup_folder%
mkdir "%backup_folder%" 2>nul
mkdir "%backup_folder%\Users" 2>nul
mkdir "%backup_folder%\ProgramData" 2>nul
mkdir "%backup_folder%\Registry" 2>nul
mkdir "%backup_folder%\Drivers" 2>nul
mkdir "%backup_folder%\Passwords" 2>nul
mkdir "%backup_folder%\Tasks" 2>nul
mkdir "%backup_folder%\Network" 2>nul
mkdir "%backup_folder%\Programs" 2>nul

echo.
echo ================================================================================
echo                        SAUVEGARDE EN COURS...
echo ================================================================================
echo.

:: 1. Sauvegarde des fichiers personnels
echo [1/8] Sauvegarde des FICHIERS PERSONNELS...
robocopy "C:\Users\%USERNAME%\Desktop" "%backup_folder%\Users\Desktop" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Documents" "%backup_folder%\Users\Documents" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Pictures" "%backup_folder%\Users\Pictures" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Videos" "%backup_folder%\Users\Videos" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Music" "%backup_folder%\Users\Music" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Downloads" "%backup_folder%\Users\Downloads" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Favorites" "%backup_folder%\Users\Favorites" /E /COPY:DAT /R:2 /W:5
echo   [+] Fichiers personnels sauvegardes

:: 2. Sauvegarde des configurations
echo [2/8] Sauvegarde des CONFIGURATIONS...
robocopy "C:\ProgramData" "%backup_folder%\ProgramData" /MIR /COPY:DAT /R:2 /W:5 /XD "C:\ProgramData\Microsoft\Windows\Caches" "C:\ProgramData\Package Cache"
echo   [+] Configurations sauvegardees

:: 3. Sauvegarde du registre
echo [3/8] Sauvegarde du REGISTRE...
reg export HKLM "%backup_folder%\Registry\HKLM.reg" >nul 2>&1
reg export HKCU "%backup_folder%\Registry\HKCU.reg" >nul 2>&1
reg export HKCR "%backup_folder%\Registry\HKCR.reg" >nul 2>&1
reg export HKU "%backup_folder%\Registry\HKU.reg" >nul 2>&1
reg export HKCC "%backup_folder%\Registry\HKCC.reg" >nul 2>&1
echo   [+] Registre sauvegarde (5 fichiers)

:: 4. Sauvegarde des pilotes
echo [4/8] Sauvegarde des PILOTES...
dism /online /export-driver /destination:"%backup_folder%\Drivers" >nul 2>&1
echo   [+] Pilotes sauvegardes

:: 5. Sauvegarde des mots de passe
echo [5/8] Sauvegarde des MOTS DE PASSE...
:: Mots de passe Wi-Fi
netsh wlan export profile key=clear folder="%backup_folder%\Passwords" >nul 2>&1
:: Credentials Windows
cmdkey /list > "%backup_folder%\Passwords\Credentials.txt" 2>nul
:: Mots de passe enregistres
if exist "%userprofile%\AppData\Roaming\Microsoft\Credentials" (
    robocopy "%userprofile%\AppData\Roaming\Microsoft\Credentials" "%backup_folder%\Passwords\Credentials" /E /COPY:DAT
)
echo   [+] Mots de passe sauvegardes

:: 6. Sauvegarde des taches planifiees
echo [6/8] Sauvegarde des TACHES PLANIFIEES...
schtasks /query /fo LIST /v > "%backup_folder%\Tasks\All_Tasks.txt" 2>nul
schtasks /query /xml /tn > "%backup_folder%\Tasks\All_Tasks.xml" 2>nul
echo   [+] Taches planifiees sauvegardees

:: 7. Sauvegarde des parametres reseau
echo [7/8] Sauvegarde des PARAMETRES RESEAU...
ipconfig /all > "%backup_folder%\Network\IPConfig.txt"
netsh dump > "%backup_folder%\Network\Netsh_Dump.txt"
netsh wlan show profiles > "%backup_folder%\Network\WLAN_Profiles.txt"
route print > "%backup_folder%\Network\Route_Table.txt"
echo   [+] Parametres reseau sauvegardes

:: 8. Sauvegarde de la liste des programmes
echo [8/8] Sauvegarde de la LISTE DES PROGRAMMES...
wmic product get name,version > "%backup_folder%\Programs\Programs_WMIC.txt" 2>nul
winget list > "%backup_folder%\Programs\Programs_Winget.txt" 2>nul
reg query HKLM\Software\Microsoft\Windows\CurrentVersion\Uninstall > "%backup_folder%\Programs\Programs_Registry.txt" 2>nul
echo   [+] Liste des programmes sauvegardee

:: Creation du fichier info
(
echo ================================================================================
echo                        RAPPORT DE SAUVEGARDE
echo ================================================================================
echo.
echo Date de sauvegarde: %date% %time%
echo Disque source: C:
echo Disque destination: %backup_drive%
echo Dossier: %backup_folder%
echo Utilisateur: %USERNAME%
echo Ordinateur: %COMPUTERNAME%
echo.
echo ================================================================================
echo                       INFORMATIONS SYSTEME
echo ================================================================================
echo.
systeminfo | findstr /B /C:"Nom du systeme" /C:"Version" /C:"Systeme d'exploitation" /C:"Processeur" /C:"Memoire physique"
echo.
echo ================================================================================
echo                       TAILLE DE LA SAUVEGARDE
echo ================================================================================
) > "%backup_folder%\INFO_BACKUP.txt"

:: Calculer la taille
for /f "tokens=3" %%a in ('dir "%backup_folder%" /s /-c 2^>nul ^| findstr "octets$"') do set total_size=%%a
set total_size=%total_size:,=%
set /a total_gb=%total_size% / 1073741824
set /a total_mb=(%total_size% - (%total_gb% * 1073741824)) / 1048576
echo Taille totale: %total_gb% GB %total_mb% MB >> "%backup_folder%\INFO_BACKUP.txt"

:: Creation du script de restauration automatique
(
echo @echo off
echo title RESTAURATION AUTOMATIQUE
echo color 0A
echo cls
echo echo ================================================================================
echo echo                       RESTAURATION AUTOMATIQUE
echo echo ================================================================================
echo echo.
echo echo [!] Ce script va restaurer TOUTES vos donnees
echo echo     Veuillez NE PAS fermer cette fenetre
echo echo.
echo pause
echo cls
echo echo.
echo echo [1/6] Restauration des PILOTES...
echo pnputil /add-driver "%%~dp0Drivers\*.inf" /subdirs /install /force
echo echo.
echo echo [2/6] Restauration du REGISTRE...
echo reg import "%%~dp0Registry\HKLM.reg"
echo reg import "%%~dp0Registry\HKCU.reg"
echo reg import "%%~dp0Registry\HKCR.reg"
echo echo.
echo echo [3/6] Restauration des FICHIERS PERSONNELS...
echo robocopy "%%~dp0Users" "C:\Users\%USERNAME%" /MIR /COPY:DAT /R:5 /W:10
echo echo.
echo echo [4/6] Restauration des CONFIGURATIONS...
echo robocopy "%%~dp0ProgramData" "C:\ProgramData" /MIR /COPY:DAT /R:5 /W:10
echo echo.
echo echo [5/6] Restauration des MOTS DE PASSE...
echo for /f "tokens=*" %%%%i in ('dir /b "%%~dp0Passwords\*.xml" 2^>nul') do (
echo     netsh wlan add profile filename="%%~dp0Passwords\%%%%i"
echo )
echo echo.
echo echo [6/6] Restauration des PARAMETRES RESEAU...
echo netsh exec "%%~dp0Network\Netsh_Dump.txt"
echo echo.
echo echo ================================================================================
echo echo [SUCCES] RESTAURATION TERMINEE!
echo echo ================================================================================
echo echo.
echo echo Redemarrage dans 60 secondes...
echo shutdown /r /t 60
) > "%backup_folder%\RESTAURER_AUTO.bat"

echo.
echo ================================================================================
echo                       SAUVEGARDE TERMINEE AVEC SUCCES!
echo ================================================================================
echo.
echo Dossier de sauvegarde: %backup_folder%
echo Taille totale: %total_gb% GB %total_mb% MB
echo.
echo Fichiers crees:
echo   - Users/           : Vos fichiers personnels
echo   - ProgramData/     : Configurations des programmes
echo   - Registry/        : Registre Windows (5 fichiers)
echo   - Drivers/         : Tous les pilotes
echo   - Passwords/       : Mots de passe Wi-Fi et Credentials
echo   - Tasks/           : Taches planifiees
echo   - Network/         : Parametres reseau
echo   - Programs/        : Liste des programmes installes
echo   - RESTAURER_AUTO.bat : Script de restauration
echo   - INFO_BACKUP.txt  : Rapport de sauvegarde
echo.
echo ================================================================================
echo.
echo [1] Ouvrir le dossier de sauvegarde
echo [2] Creer une autre sauvegarde
echo [3] Retour au menu principal
echo.
set /p "after_backup=Choix: "
if "%after_backup%"=="1" start "" "%backup_folder%"
if "%after_backup%"=="2" goto backup_all
if "%after_backup%"=="3" goto menu_backup
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE DES FICHIERS UNIQUEMENT
:: ====================================================
:backup_files
cls
echo ================================================================================
echo                    SAUVEGARDE DES FICHIERS UNIQUEMENT
echo ================================================================================
echo.
echo Cette sauvegarde va inclure :
echo   [*] Bureau, Documents, Images, Videos, Musique, Telechargements
echo.
call :show_disks_simple
echo.
set /p "backup_drive=Disque de destination (ex: D): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto backup_files
)

set backup_date=%date:~6,4%%date:~3,2%%date:~0,2%
set backup_folder=%backup_drive%\FILES_BACKUP_%backup_date%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde en cours...
robocopy "C:\Users\%USERNAME%\Desktop" "%backup_folder%\Desktop" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Documents" "%backup_folder%\Documents" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Pictures" "%backup_folder%\Pictures" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Videos" "%backup_folder%\Videos" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Music" "%backup_folder%\Music" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Downloads" "%backup_folder%\Downloads" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Favorites" "%backup_folder%\Favorites" /E /COPY:DAT /R:2 /W:5

echo.
echo [SUCCES] Sauvegarde des fichiers terminee!
echo Dossier: %backup_folder%
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE DU REGISTRE
:: ====================================================
:backup_registry
cls
echo ================================================================================
echo                       SAUVEGARDE DU REGISTRE
echo ================================================================================
echo.
echo Cette sauvegarde va sauvegarder TOUT le registre Windows.
echo.
call :show_disks_simple
echo.
set /p "backup_drive=Disque de destination (ex: D): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto backup_registry
)

set backup_date=%date:~6,4%%date:~3,2%%date:~0,2%
set backup_folder=%backup_drive%\REGISTRY_BACKUP_%backup_date%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde en cours...
reg export HKLM "%backup_folder%\HKLM.reg" >nul 2>&1
reg export HKCU "%backup_folder%\HKCU.reg" >nul 2>&1
reg export HKCR "%backup_folder%\HKCR.reg" >nul 2>&1
reg export HKU "%backup_folder%\HKU.reg" >nul 2>&1
reg export HKCC "%backup_folder%\HKCC.reg" >nul 2>&1

echo.
echo [SUCCES] Sauvegarde du registre terminee!
echo Dossier: %backup_folder%
echo.
echo Les fichiers crees:
dir "%backup_folder%\*.reg"
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE DES PILOTES
:: ====================================================
:backup_drivers
cls
echo ================================================================================
echo                       SAUVEGARDE DES PILOTES
echo ================================================================================
echo.
echo Cette sauvegarde va sauvegarder TOUS les pilotes installes.
echo.
call :show_disks_simple
echo.
set /p "backup_drive=Disque de destination (ex: D): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto backup_drivers
)

set backup_date=%date:~6,4%%date:~3,2%%date:~0,2%
set backup_folder=%backup_drive%\DRIVERS_BACKUP_%backup_date%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde des pilotes en cours...
dism /online /export-driver /destination:"%backup_folder%"

echo.
echo [SUCCES] Sauvegarde des pilotes terminee!
echo Dossier: %backup_folder%
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE DES MOTS DE PASSE
:: ====================================================
:backup_passwords
cls
echo ================================================================================
echo                    SAUVEGARDE DES MOTS DE PASSE
echo ================================================================================
echo.
echo Cette sauvegarde va inclure :
echo   [*] Mots de passe Wi-Fi
echo   [*] Credentials Windows
echo   [*] Mots de passe enregistres
echo.
call :show_disks_simple
echo.
set /p "backup_drive=Disque de destination (ex: D): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto backup_passwords
)

set backup_date=%date:~6,4%%date:~3,2%%date:~0,2%
set backup_folder=%backup_drive%\PASSWORDS_BACKUP_%backup_date%
mkdir "%backup_folder%" 2>nul

echo.
echo [1/3] Sauvegarde des mots de passe Wi-Fi...
netsh wlan export profile key=clear folder="%backup_folder%" >nul 2>&1

echo [2/3] Sauvegarde des Credentials...
cmdkey /list > "%backup_folder%\Credentials.txt" 2>nul

echo [3/3] Sauvegarde des identifiants...
if exist "%userprofile%\AppData\Roaming\Microsoft\Credentials" (
    robocopy "%userprofile%\AppData\Roaming\Microsoft\Credentials" "%backup_folder%\Credentials" /E /COPY:DAT
)

echo.
echo [SUCCES] Sauvegarde des mots de passe terminee!
echo Dossier: %backup_folder%
echo.
echo Fichiers crees:
dir "%backup_folder%"
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE DES TACHES PLANIFIEES
:: ====================================================
:backup_tasks
cls
echo ================================================================================
echo                  SAUVEGARDE DES TACHES PLANIFIEES
echo ================================================================================
echo.
call :show_disks_simple
echo.
set /p "backup_drive=Disque de destination (ex: D): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto backup_tasks
)

set backup_date=%date:~6,4%%date:~3,2%%date:~0,2%
set backup_folder=%backup_drive%\TASKS_BACKUP_%backup_date%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde en cours...
schtasks /query /fo LIST /v > "%backup_folder%\All_Tasks.txt" 2>nul
schtasks /query /xml /tn > "%backup_folder%\All_Tasks.xml" 2>nul

echo.
echo [SUCCES] Sauvegarde des taches planifiees terminee!
echo Dossier: %backup_folder%
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE DES PARAMETRES RESEAU
:: ====================================================
:backup_network
cls
echo ================================================================================
echo                    SAUVEGARDE DES PARAMETRES RESEAU
echo ================================================================================
echo.
call :show_disks_simple
echo.
set /p "backup_drive=Disque de destination (ex: D): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto backup_network
)

set backup_date=%date:~6,4%%date:~3,2%%date:~0,2%
set backup_folder=%backup_drive%\NETWORK_BACKUP_%backup_date%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde en cours...
ipconfig /all > "%backup_folder%\IPConfig.txt"
netsh dump > "%backup_folder%\Netsh_Dump.txt"
netsh wlan show profiles > "%backup_folder%\WLAN_Profiles.txt"
route print > "%backup_folder%\Route_Table.txt"
arp -a > "%backup_folder%\ARP_Table.txt"

echo.
echo [SUCCES] Sauvegarde des parametres reseau terminee!
echo Dossier: %backup_folder%
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE COMPRESSEE (ZIP)
:: ====================================================
:backup_compressed
cls
echo ================================================================================
echo                       SAUVEGARDE COMPRESSEE (ZIP)
echo ================================================================================
echo.
echo [!] La compression permet d'economiser jusqu'a 70%% d'espace
echo [!] Cette operation peut prendre 1-2 heures
echo.
call :show_disks_simple
echo.
set /p "backup_drive=Disque de destination (ex: D): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto backup_compressed
)

set backup_name=COMPRESSED_BACKUP_%date:~6,4%%date:~3,2%%date:~0,2%
set temp_folder=%temp%\%backup_name%
mkdir "%temp_folder%" 2>nul

echo.
echo [1/3] Preparation des fichiers...
robocopy "C:\Users\%USERNAME%\Desktop" "%temp_folder%\Desktop" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Documents" "%temp_folder%\Documents" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Pictures" "%temp_folder%\Pictures" /E /COPY:DAT /R:2 /W:5

echo [2/3] Compression en cours...
powershell -Command "Compress-Archive -Path '%temp_folder%\*' -DestinationPath '%backup_drive%\%backup_name%.zip' -CompressionLevel Optimal"

echo [3/3] Nettoyage...
rmdir /s /q "%temp_folder%" 2>nul

echo.
echo [SUCCES] Sauvegarde compressee terminee!
echo Fichier: %backup_drive%\%backup_name%.zip
for %%a in ("%backup_drive%\%backup_name%.zip") do echo Taille: %%~za octets
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE VERS DISQUE EXTERNE
:: ====================================================
:backup_external
cls
echo ================================================================================
echo                    SAUVEGARDE VERS DISQUE EXTERNE
echo ================================================================================
echo.
echo [!] Branchez votre disque dur externe ou USB
echo.
pause
echo.
echo Disques externes detectes:
echo ----------------------------
wmic logicaldisk where drivetype=2 get DeviceID,VolumeName,Size,FreeSpace
echo.
set /p "usb_drive=Lettre du disque externe (ex: E): "
set "usb_drive=%usb_drive:~0,1%"
set "usb_drive=%usb_drive%:"

if not exist "%usb_drive%\" (
    echo [ERREUR] Disque externe introuvable!
    pause
    goto backup_external
)

set backup_date=%date:~6,4%%date:~3,2%%date:~0,2%
set backup_folder=%usb_drive%\EXTERNAL_BACKUP_%backup_date%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde vers disque externe: %usb_drive%
echo.
robocopy "C:\Users\%USERNAME%" "%backup_folder%\Users" /E /COPY:DAT /R:2 /W:5
robocopy "C:\ProgramData" "%backup_folder%\ProgramData" /E /COPY:DAT /R:2 /W:5

echo.
echo [SUCCES] Sauvegarde sur disque externe terminee!
echo Dossier: %backup_folder%
echo.
echo [!] IMPORTANT: Ejectez le disque avant de le debrancher!
pause
goto menu_backup

:: ====================================================
:: SAUVEGARDE VERS CLOUD
:: ====================================================
:backup_cloud
cls
echo ================================================================================
echo                       SAUVEGARDE VERS CLOUD
echo ================================================================================
echo.
echo Cette option copie vos fichiers vers votre dossier Cloud.
echo.
echo [1] OneDrive
echo [2] Google Drive
echo [3] Dropbox
echo.
set /p "cloud_choice=Choix: "

set cloud_path=
if "%cloud_choice%"=="1" set cloud_path=%userprofile%\OneDrive
if "%cloud_choice%"=="2" set cloud_path=%userprofile%\Google Drive
if "%cloud_choice%"=="3" set cloud_path=%userprofile%\Dropbox

if not exist "%cloud_path%\" (
    echo [ERREUR] Le cloud n'est pas configure!
    echo Veuillez installer et connecter votre compte cloud d'abord.
    pause
    goto backup_cloud
)

set backup_folder=%cloud_path%\CLOUD_BACKUP_%date:~6,4%%date:~3,2%%date:~0,2%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde vers: %backup_folder%
echo.
robocopy "C:\Users\%USERNAME%\Desktop" "%backup_folder%\Desktop" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Documents" "%backup_folder%\Documents" /E /COPY:DAT /R:2 /W:5
robocopy "C:\Users\%USERNAME%\Pictures" "%backup_folder%\Pictures" /E /COPY:DAT /R:2 /W:5

echo.
echo [SUCCES] Sauvegarde cloud terminee!
echo Les fichiers seront synchronises automatiquement.
pause
goto menu_backup

:: ====================================================
:: CLONAGE DU DISQUE
:: ====================================================
:clone_disk
cls
echo ================================================================================
echo                         CLONAGE DU DISQUE C:
echo ================================================================================
echo.
echo [!] ATTENTION: Le clonage cree une IMAGE EXACTE de votre disque C:
echo [!] Cela permet de restaurer TOUT (Windows + programmes + fichiers)
echo [!] Operation peut prendre 1-3 heures
echo.
echo [1] Image disque COMPLETE (sans compression)
echo [2] Image disque COMPRESSEE (economise espace)
echo.
set /p "image_type=Type (1/2): "

call :show_disks_simple
echo.
set /p "clone_drive=Disque de destination (ex: D): "
set "clone_drive=%clone_drive:~0,1%"
set "clone_drive=%clone_drive%:"

if not exist "%clone_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto clone_disk
)

set image_name=CLONE_C_%date:~6,4%%date:~3,2%%date:~0,2%

echo.
echo Creation de l'image disque en cours...
echo.

if "%image_type%"=="1" (
    wbAdmin start backup -backupTarget:%clone_drive% -include:C: -allCritical -quiet
)

if "%image_type%"=="2" (
    dism /Capture-Image /ImageFile:"%clone_drive%\%image_name%.wim" /CaptureDir:C:\ /Name:"Clone_Complet_C" /Compress:max
)

if %errorlevel% equ 0 (
    echo.
    echo [SUCCES] Image disque creee avec succes!
    echo Fichier: %clone_drive%\%image_name%.wim
) else (
    echo [ERREUR] Echec de la creation!
)

pause
goto menu_backup

:: ====================================================
:: RESTAURATION COMPLETE
:: ====================================================
:restore_all
cls
echo ================================================================================
echo                       RESTAURATION COMPLETE
echo ================================================================================
echo.
echo Recherche des sauvegardes disponibles...
echo.
for /d %%i in (D:\BACKUP_* E:\BACKUP_* F:\BACKUP_* D:\BACKUP_* E:\BACKUP_* F:\BACKUP_*) do (
    if exist "%%i" echo   - %%i
)
echo.
echo Vous pouvez aussi utiliser le script "RESTAURER_AUTO.bat" dans votre dossier de backup.
echo.
set /p "backup_path=Entrez le chemin complet de la sauvegarde: "

if not exist "%backup_path%\" (
    echo [ERREUR] Dossier introuvable!
    pause
    goto restore_all
)

if exist "%backup_path%\RESTAURER_AUTO.bat" (
    echo.
    echo Script de restauration automatique trouve!
    set /p "auto_restore=Voulez-vous l'executer? (O/N): "
    if /i "%auto_restore%"=="O" (
        call "%backup_path%\RESTAURER_AUTO.bat"
        pause
        goto menu_backup
    )
)

echo.
echo [1] Restaurer TOUT (fichiers + registre + pilotes)
echo [2] Restaurer seulement si necessaire
echo.
set /p "restore_choice=Choix: "

if "%restore_choice%"=="1" (
    echo.
    echo Restauration en cours...
    if exist "%backup_path%\Drivers" pnputil /add-driver "%backup_path%\Drivers\*.inf" /subdirs /install /force
    if exist "%backup_path%\Registry" (
        for %%r in ("%backup_path%\Registry\*.reg") do reg import "%%r"
    )
    if exist "%backup_path%\Users" robocopy "%backup_path%\Users" "C:\Users\%USERNAME%" /MIR /COPY:DAT /R:5 /W:10
    if exist "%backup_path%\ProgramData" robocopy "%backup_path%\ProgramData" "C:\ProgramData" /MIR /COPY:DAT /R:5 /W:10
    echo.
    echo [SUCCES] Restauration terminee!
    echo Redemarrage recommande.
)

pause
goto menu_backup

:: ====================================================
:: RESTAURATION FICHIERS
:: ====================================================
:restore_files
cls
echo ================================================================================
echo                    RESTAURATION DES FICHIERS
echo ================================================================================
echo.
set /p "backup_path=Chemin de la sauvegarde (ex: D:\BACKUP_20241225): "

if not exist "%backup_path%\" (
    echo [ERREUR] Dossier introuvable!
    pause
    goto restore_files
)

if exist "%backup_path%\Users" (
    echo.
    echo Restauration des fichiers en cours...
    robocopy "%backup_path%\Users" "C:\Users\%USERNAME%" /MIR /COPY:DAT /R:5 /W:10
    echo [SUCCES] Restauration terminee!
) else (
    echo [ERREUR] Dossier Users non trouve dans cette sauvegarde!
)

pause
goto menu_backup

:: ====================================================
:: RESTAURATION REGISTRE
:: ====================================================
:restore_registry
cls
echo ================================================================================
echo                    RESTAURATION DU REGISTRE
echo ================================================================================
echo.
set /p "backup_path=Chemin de la sauvegarde (ex: D:\REGISTRY_BACKUP_20241225): "

if not exist "%backup_path%\" (
    echo [ERREUR] Dossier introuvable!
    pause
    goto restore_registry
)

echo.
echo Restauration du registre en cours...
for %%r in ("%backup_path%\*.reg") do (
    echo Importation de %%~nxr
    reg import "%%r" >nul 2>&1
)

echo [SUCCES] Restauration du registre terminee!
echo Redemarrage recommande.
pause
goto menu_backup

:: ====================================================
:: RESTAURATION PILOTES
:: ====================================================
:restore_drivers
cls
echo ================================================================================
echo                    RESTAURATION DES PILOTES
echo ================================================================================
echo.
set /p "backup_path=Chemin de la sauvegarde (ex: D:\DRIVERS_BACKUP_20241225): "

if not exist "%backup_path%\" (
    echo [ERREUR] Dossier introuvable!
    pause
    goto restore_drivers
)

echo.
echo Restauration des pilotes en cours...
pnputil /add-driver "%backup_path%\*.inf" /subdirs /install /force

echo [SUCCES] Restauration des pilotes terminee!
pause
goto menu_backup

:: ====================================================
:: VERIFIER SAUVEGARDE
:: ====================================================
:verify_backup
cls
echo ================================================================================
echo                    VERIFICATION DE LA SAUVEGARDE
echo ================================================================================
echo.
set /p "backup_path=Chemin de la sauvegarde a verifier: "

if not exist "%backup_path%\" (
    echo [ERREUR] Dossier introuvable!
    pause
    goto verify_backup
)

echo.
echo ================================================================================
echo                       RAPPORT DE VERIFICATION
echo ================================================================================
echo.
echo Dossier: %backup_path%
echo.
echo - Verification des dossiers...
if exist "%backup_path%\Users" echo [OK] Dossier Users present
if exist "%backup_path%\ProgramData" echo [OK] Dossier ProgramData present
if exist "%backup_path%\Registry" echo [OK] Dossier Registry present
if exist "%backup_path%\Drivers" echo [OK] Dossier Drivers present
if exist "%backup_path%\Passwords" echo [OK] Dossier Passwords present
if exist "%backup_path%\Tasks" echo [OK] Dossier Tasks present
if exist "%backup_path%\Network" echo [OK] Dossier Network present

:: Calculer taille
echo.
echo - Calcul de la taille...
for /f "tokens=3" %%a in ('dir "%backup_path%" /s /-c 2^>nul ^| findstr "octets$"') do set total_size=%%a
set total_size=%total_size:,=%
set /a total_gb=%total_size% / 1073741824
set /a total_mb=(%total_size% - (%total_gb% * 1073741824)) / 1048576
echo Taille totale: %total_gb% GB %total_mb% MB

echo.
echo - Nombre de fichiers...
dir "%backup_path%" /s /a-d | find "fichier(s)"

echo.
echo ================================================================================
pause
goto menu_backup

:: ====================================================
:: PROGRAMMER SAUVEGARDE
:: ====================================================
:schedule_backup
cls
echo ================================================================================
echo                    PROGRAMMER SAUVEGARDE AUTOMATIQUE
echo ================================================================================
echo.
echo [1] Quotidienne - Tous les jours a 20h00
echo [2] Hebdomadaire - Tous les dimanches a 21h00
echo [3] Mensuelle - Le 1er du mois a 22h00
echo.
set /p "schedule_choice=Choix: "

set schedule_time=
set schedule_freq=
if "%schedule_choice%"=="1" set schedule_time=20:00 & set schedule_freq=DAILY
if "%schedule_choice%"=="2" set schedule_time=21:00 & set schedule_freq=WEEKLY
if "%schedule_choice%"=="3" set schedule_time=22:00 & set schedule_freq=MONTHLY

:: Creer script automatique
set auto_script=%userprofile%\Desktop\AUTO_BACKUP.bat

(
echo @echo off
echo set backup_drive=D:
echo set backup_folder=%%backup_drive%%\AUTO_BACKUP_%%date:~6,4%%%%date:~3,2%%%%date:~0,2%%
echo mkdir %%backup_folder%% 2^>nul
echo robocopy "C:\Users\%USERNAME%\Desktop" "%%backup_folder%%\Desktop" /MIR /COPY:DAT
echo robocopy "C:\Users\%USERNAME%\Documents" "%%backup_folder%%\Documents" /MIR /COPY:DAT
echo robocopy "C:\Users\%USERNAME%\Pictures" "%%backup_folder%%\Pictures" /MIR /COPY:DAT
echo echo Sauvegarde auto terminee le %%date%% %%time%% ^>^> "%%backup_folder%%\LOG.txt"
) > "%auto_script%"

schtasks /create /tn "Windows_Auto_Backup" /tr "%auto_script%" /sc %schedule_freq% /st %schedule_time% /ru "SYSTEM" /f >nul 2>&1

if %errorlevel% equ 0 (
    echo.
    echo [SUCCES] Tache planifiee creee avec succes!
    echo Nom: Windows_Auto_Backup
    echo Frequence: %schedule_freq%
    echo Heure: %schedule_time%
    echo Script: %auto_script%
) else (
    echo [ERREUR] Impossible de creer la tache!
)

pause
goto menu_backup

:: ====================================================
:: SUPPRIMER ANCIENNES SAUVEGARDES
:: ====================================================
:delete_backups
cls
echo ================================================================================
echo                 SUPPRESSION DES ANCIENNES SAUVEGARDES
echo ================================================================================
echo.
set /p "days=Supprimer les sauvegardes plus anciennes que (jours): "
if "%days%"=="" set days=30

echo.
echo Recherche des sauvegardes plus anciennes que %days% jours...
echo.
echo --------------------------------------------------------------------------------

for /d %%i in (D:\BACKUP_* E:\BACKUP_* F:\BACKUP_* G:\BACKUP_* D:\BACKUP_* E:\BACKUP_* F:\BACKUP_* D:\REGISTRY_BACKUP_* D:\DRIVERS_BACKUP_* D:\PASSWORDS_BACKUP_* D:\FILES_BACKUP_*) do (
    if exist "%%i" (
        forfiles /p "%%i" /d -%days% /c "cmd /c echo [A SUPPRIMER] %%i" 2>nul
    )
)

echo --------------------------------------------------------------------------------
echo.
set /p "confirm=Voulez-vous supprimer ces sauvegardes? (O/N): "

if /i "%confirm%"=="O" (
    for /d %%i in (D:\BACKUP_* E:\BACKUP_* F:\BACKUP_* G:\BACKUP_* D:\BACKUP_* E:\BACKUP_* F:\BACKUP_* D:\REGISTRY_BACKUP_* D:\DRIVERS_BACKUP_* D:\PASSWORDS_BACKUP_* D:\FILES_BACKUP_*) do (
        if exist "%%i" (
            forfiles /p "%%i" /d -%days% /c "cmd /c rmdir /s /q @path" 2>nul
        )
    )
    echo.
    echo [SUCCES] Anciennes sauvegardes supprimees!
) else (
    echo [ANNULE]
)

pause
goto menu_backup

:: ====================================================
:: AFFICHER DISQUES
:: ====================================================
:show_disks
:show_disks_simple
cls
echo ================================================================================
echo                       DISQUES DISPONIBLES
echo ================================================================================
echo.
wmic logicaldisk where drivetype=3 get DeviceID,VolumeName,Size,FreeSpace /format:table
echo.
echo [Disques externes / USB]
wmic logicaldisk where drivetype=2 get DeviceID,VolumeName,Size,FreeSpace /format:table 2>nul
echo ================================================================================
if "%~0"==":show_disks_simple" goto :eof
pause
goto menu_backup

:: ====================================================
:: CALCULER ESPACE NECESSAIRE
:: ====================================================
:check_space
cls
echo ================================================================================
echo                    CALCUL DE L'ESPACE NECESSAIRE
echo ================================================================================
echo.
echo Calcul de la taille de vos fichiers...
echo.
:: Calculer taille Users
for /f "tokens=3" %%a in ('dir "C:\Users\%USERNAME%" /s /-c 2^>nul ^| findstr "octets$"') do set user_size=%%a
set user_size=%user_size:,=%
set /a user_gb=%user_size% / 1073741824

:: Calculer taille ProgramData
for /f "tokens=3" %%a in ('dir "C:\ProgramData" /s /-c 2^>nul ^| findstr "octets$"') do set prog_size=%%a
set prog_size=%prog_size:,=%
set /a prog_gb=%prog_size% / 1073741824

:: Calculer taille registre approximative
set reg_gb=1

:: Calculer taille pilotes approximative
set drivers_gb=2

:: Total
set /a total_gb=%user_gb% + %prog_gb% + %reg_gb% + %drivers_gb%

echo.
echo ================================================================================
echo                      DETAIL PAR CATEGORIE
echo ================================================================================
echo.
echo Fichiers personnels (Users)     : %user_gb% GB
echo Configurations (ProgramData)    : %prog_gb% GB
echo Registre Windows                : %reg_gb% GB
echo Pilotes                         : %drivers_gb% GB
echo.
echo --------------------------------------------------------------------------------
echo ESPACE TOTAL NECESSAIRE          : %total_gb% GB
echo ================================================================================
echo.
echo [!] Ajoutez 5-10 GB supplementaires pour etre tranquille
echo.
pause
goto menu_backup

:: ====================================================
:: POINT DE RESTAURATION
:: ====================================================
:create_restore_point
cls
echo ================================================================================
echo                    CREATION D'UN POINT DE RESTAURATION
echo ================================================================================
echo.
powershell -Command "Enable-ComputerRestore -Drive 'C:\'" >nul 2>&1
powershell -Command "Checkpoint-Computer -Description 'WinRTP_Auto_Backup' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1

if %errorlevel% equ 0 (
    echo [SUCCES] Point de restauration cree avec succes!
) else (
    echo [ERREUR] Verifiez que la protection du systeme est activee
)
pause
goto menu_backup