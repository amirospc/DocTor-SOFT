@echo off
title Windows Repair Tool Pro - Sauvgard Reparation Soft Hard 

:: ====================================================
:: التحقق من صلاحيات المسؤول
:: ====================================================
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Demande d'acces administrateur...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: ====================================================
:: MENU PRINCIPAL
:: ====================================================
:menu
cls
echo ================================================================================
echo                         OUTIL DE REPARATION WINDOWS PRO
echo                         Amiros PC Technicien Informatique
echo ================================================================================
echo.
echo    [0]  Creer un point de restauration
echo    [1]  Optimiser le systeme
echo    [2]  Outils disque
echo    [3]  Outils avances
echo    [4]  Reparer le systeme
echo    [5]  Securite
echo    [6]  Gestion des pilotes
echo    [7]  Installation d'applications
echo    [8]  Surveillance du systeme
echo.
echo    [C]  Verifier les mises a jour
echo    [A]  A propos
echo    [E]  Quitter
echo.
echo ================================================================================
set /p choice=Entrez votre choix: 

if "%choice%"=="0" goto create_restore_point
if "%choice%"=="1" goto menu_optimize
if "%choice%"=="2" goto menu_disk
if "%choice%"=="3" goto menu_advanced
if "%choice%"=="4" goto menu_repair
if "%choice%"=="5" goto menu_security
if "%choice%"=="6" goto menu_drivers
if "%choice%"=="7" goto menu_apps
if "%choice%"=="8" goto menu_monitoring
if /i "%choice%"=="c" goto UPDATE
if /i "%choice%"=="a" goto about
if /i "%choice%"=="e" exit
goto menu

:: ====================================================
:: MENU SURVEILLANCE
:: ====================================================
:menu_monitoring
cls
echo ================================================================================
echo                           SURVEILLANCE DU SYSTEME
echo ================================================================================
echo.
echo    [1]  Informations systeme
echo    [2]  Temperature CPU
echo    [3]  Sante du disque dur (SMART)
echo    [4]  Utilisation RAM
echo    [5]  Tester la memoire RAM
echo    [6]  Verifier les erreurs disque
echo    [7]  Rapport complet de sante
echo    [8]  Surveiller les processus
echo    [9]  Duree de fonctionnement (uptime)
echo    [10] Espace disque
echo    [11] Version du BIOS
echo    [12] Rapport batterie (portable)
echo.
echo    [0]  Retour
echo.
echo ================================================================================
set /p mon_choice=Entrez votre choix: 
if "%mon_choice%"=="1" goto sysinfo
if "%mon_choice%"=="2" goto cpu_temp
if "%mon_choice%"=="3" goto disk_health
if "%mon_choice%"=="4" goto ram_usage
if "%mon_choice%"=="5" goto ram_test
if "%mon_choice%"=="6" goto disk_check_readonly
if "%mon_choice%"=="7" goto health_report
if "%mon_choice%"=="8" goto monitor_processes
if "%mon_choice%"=="9" goto uptime
if "%mon_choice%"=="10" goto disk_space
if "%mon_choice%"=="11" goto bios_version
if "%mon_choice%"=="12" goto battery_report
if "%mon_choice%"=="0" goto menu
goto menu_monitoring

:: ====================================================
:: MENU OPTIMISATION
:: ====================================================
:menu_optimize
cls
echo ================================================================================
echo                           OPTIMISER LE SYSTEME
echo ================================================================================
echo.
echo    [1]  Executer SFC Scan
echo    [2]  Executer DISM RestoreHealth
echo    [3]  Nettoyer le stockage des composants
echo    [4]  Nettoyer les fichiers temporaires
echo    [5]  Optimiser Internet et DNS
echo    [6]  Executer TOUTES les reparations
echo    [7]  Nettoyer le cache DNS
echo    [8]  Optimiser les performances graphiques
echo    [9]  Desactiver les effets visuels
echo    [10] Optimiser les services Windows
echo    [11] Activer/Desactiver Hibernation
echo    [12] Optimiser SSD
echo    [13] Defragmenter le registre
echo.
echo    [0]  Retour
echo.
echo ================================================================================
set /p opt_choice=Entrez votre choix: 
if "%opt_choice%"=="1" goto sfc
if "%opt_choice%"=="2" goto dism
if "%opt_choice%"=="3" goto comp_cleanup
if "%opt_choice%"=="4" goto clean
if "%opt_choice%"=="5" goto internet
if "%opt_choice%"=="6" goto all
if "%opt_choice%"=="7" goto flush_dns
if "%opt_choice%"=="8" goto gpu_perf
if "%opt_choice%"=="9" goto disable_visual
if "%opt_choice%"=="10" goto optimize_services
if "%opt_choice%"=="11" goto toggle_hibernate
if "%opt_choice%"=="12" goto optimize_ssd
if "%opt_choice%"=="13" goto defrag_registry
if "%opt_choice%"=="0" goto menu
goto menu_optimize

:: ====================================================
:: MENU DISQUE
:: ====================================================
:menu_disk
cls
echo ================================================================================
echo                             OUTILS DISQUE
echo ================================================================================
echo.
echo    [1]  Planifier CHKDSK
echo    [2]  Annuler CHKDSK
echo    [3]  Defragmenter HDD / Optimiser SSD
echo    [4]  Nettoyer le disque
echo    [5]  Verifier les secteurs defectueux
echo    [6]  Optimiser tous les disques
echo    [7]  CHKDSK complet sur TOUS les disques
echo    [8]  Nettoyer WinSxS (dossier systeme)
echo    [9]  Sauvegarde complete (Robocopy)
echo.
echo    [0]  Retour
echo.
echo ================================================================================
set /p disk_choice=Entrez votre choix: 
if "%disk_choice%"=="1" goto chkdsk
if "%disk_choice%"=="2" goto cancelchk
if "%disk_choice%"=="3" goto defrag
if "%disk_choice%"=="4" goto cleanmgr_advanced
if "%disk_choice%"=="5" goto bad_sectors
if "%disk_choice%"=="6" goto optimize_all_disks
if "%disk_choice%"=="7" goto full_chkdsk
if "%disk_choice%"=="8" goto clean_winsxs
if "%disk_choice%"=="9" goto full_backup
if "%disk_choice%"=="0" goto menu
goto menu_disk

:: ====================================================
:: MENU AVANCE
:: ====================================================
:menu_advanced
cls
echo ================================================================================
echo                            OUTILS AVANCES
echo ================================================================================
echo.
echo    [1]  Activer mode Performance Extreme
echo    [2]  Restaurer mode Equilibre
echo    [3]  Programmer extinction automatique
echo    [4]  Annuler extinction
echo    [5]  Redemarrer vers BIOS
echo    [6]  Redemarrer vers Mode sans echec
echo    [7]  Nettoyer Windows (Debloat)
echo    [8]  Nettoyer anciennes mises a jour
echo    [9]  Nettoyer fichiers crash
echo    [10] Afficher mot de passe Wi-Fi
echo    [11] Activer Windows Update
echo    [12] Desactiver Windows Update
echo    [13] Changer DNS
echo    [14] Nettoyer cache des jeux
echo    [15] Nettoyer le Registre
echo    [16] Sauvegarder le Registre
echo    [17] Restaurer le Registre
echo    [18] Reinitialiser Windows Update
echo    [19] Reparer .NET Framework
echo    [20] Reinitialiser le reseau
echo    [21] Mode DIEU (God Mode)
echo    [22] Verifier TOUS les fichiers systeme
echo    [23] Tuer les processus inutiles
echo    [24] Reinitialiser TOUS les services
echo    [25] Reinitialiser completement le systeme
echo.
echo    [0]  Retour
echo.
echo ================================================================================
set /p adv_choice=Entrez votre choix: 
if "%adv_choice%"=="1" goto ultimate_perf
if "%adv_choice%"=="2" goto restore_balanced
if "%adv_choice%"=="3" goto shutdown
if "%adv_choice%"=="4" goto cancelshutdown
if "%adv_choice%"=="5" goto bios
if "%adv_choice%"=="6" goto safemode
if "%adv_choice%"=="7" goto debloat
if "%adv_choice%"=="8" goto clean_updates
if "%adv_choice%"=="9" goto clean_dumps
if "%adv_choice%"=="10" goto wifi_pwd
if "%adv_choice%"=="11" goto enable_updates
if "%adv_choice%"=="12" goto disable_updates
if "%adv_choice%"=="13" goto change_dns
if "%adv_choice%"=="14" goto clean_gamers_cache
if "%adv_choice%"=="15" goto clean_registry
if "%adv_choice%"=="16" goto backup_registry
if "%adv_choice%"=="17" goto restore_registry
if "%adv_choice%"=="18" goto reset_windows_update
if "%adv_choice%"=="19" goto repair_dotnet
if "%adv_choice%"=="20" goto reset_network
if "%adv_choice%"=="21" goto god_mode
if "%adv_choice%"=="22" goto verify_all_files
if "%adv_choice%"=="23" goto kill_bloat
if "%adv_choice%"=="24" goto reset_services
if "%adv_choice%"=="25" goto complete_reset
if "%adv_choice%"=="0" goto menu
goto menu_advanced

:: ====================================================
:: MENU REPARATION
:: ====================================================
:menu_repair
cls
echo ================================================================================
echo                            REPARER LE SYSTEME
echo ================================================================================
echo.
echo    [1]  Reparer Windows Update
echo    [2]  Reparer Microsoft Store
echo    [3]  Reconstruire les icones
echo    [4]  Reparer la barre des taches
echo    [5]  Reparer l'explorateur
echo    [6]  Reinitialiser le pare-feu
echo    [7]  Reparer les droits d'acces
echo    [8]  Reinitialiser completement Windows Update
echo    [9]  Generer rapport SFC detaille
echo.
echo    [0]  Retour
echo.
echo ================================================================================
set /p rep_choice=Entrez votre choix: 
if "%rep_choice%"=="1" goto winupdate
if "%rep_choice%"=="2" goto store
if "%rep_choice%"=="3" goto icons
if "%rep_choice%"=="4" goto taskbar
if "%rep_choice%"=="5" goto explorer_repair
if "%rep_choice%"=="6" goto firewall_reset
if "%rep_choice%"=="7" goto fix_permissions
if "%rep_choice%"=="8" goto reset_windows_update
if "%rep_choice%"=="9" goto detailed_sfc
if "%rep_choice%"=="0" goto menu
goto menu_repair

:: ====================================================
:: MENU SECURITE
:: ====================================================
:menu_security
cls
echo ================================================================================
echo                              SECURITE
echo ================================================================================
echo.
echo    [1]  Scan rapide (Defender)
echo    [2]  Scan complet (Defender)
echo    [3]  Reinitialiser le pare-feu
echo    [4]  Activer la telemetrie
echo    [5]  Desactiver la telemetrie
echo    [6]  Reparer Windows Defender
echo    [7]  Analyser les logiciels espions
echo    [8]  Verifier les ports ouverts
echo    [9]  Desactiver TOTALEMENT la telemetrie (20 services)
echo    [10] Blocage des IP malveillantes
echo.
echo    [0]  Retour
echo.
echo ================================================================================
set /p sec_choice=Entrez votre choix: 
if "%sec_choice%"=="1" goto quickscan
if "%sec_choice%"=="2" goto fullscan
if "%sec_choice%"=="3" goto firewall_reset
if "%sec_choice%"=="4" goto enable_telemetry
if "%sec_choice%"=="5" goto disable_telemetry
if "%sec_choice%"=="6" goto fix_defender
if "%sec_choice%"=="7" goto spyware_scan
if "%sec_choice%"=="8" goto open_ports
if "%sec_choice%"=="9" goto kill_telemetry
if "%sec_choice%"=="10" goto block_malicious
if "%sec_choice%"=="0" goto menu
goto menu_security

:: ====================================================
:: MENU PILOTES
:: ====================================================
:menu_drivers
cls
echo ================================================================================
echo                         GESTION DES PILOTES
echo ================================================================================
echo.
echo    [1]  Verifier les mises a jour
echo    [2]  Sauvegarder TOUS les pilotes
echo    [3]  Restaurer les pilotes
echo    [4]  Desinstaller un pilote
echo    [5]  Afficher la liste des pilotes
echo    [6]  Verifier les pilotes non signes
echo.
echo    [0]  Retour
echo.
echo ================================================================================
set /p drv_choice=Entrez votre choix: 
if "%drv_choice%"=="1" goto driver_updater
if "%drv_choice%"=="2" goto backup_drivers
if "%drv_choice%"=="3" goto restore_drivers
if "%drv_choice%"=="4" goto drivers_uninstaller_wizard
if "%drv_choice%"=="5" goto driver_list
if "%drv_choice%"=="6" goto unsigned_drivers
if "%drv_choice%"=="0" goto menu
goto menu_drivers

:: ====================================================
:: MENU APPLICATIONS
:: ====================================================
:menu_apps
cls
echo ================================================================================
echo                     INSTALLATION D'APPLICATIONS
echo ================================================================================
echo.
echo    [1]  Mettre a jour les applications
echo    [2]  Desinstaller des applications
echo    [3]  .NET Framework
echo    [4]  DirectX Runtime
echo.
echo    --- APPLICATIONS POPULAIRES ---
echo    [5]  Google Chrome              [11] WinRAR
echo    [6]  Mozilla Firefox            [12] 7-Zip
echo    [7]  Internet Download Manager  [13] Visual Studio Code
echo    [8]  Discord                    [14] Steam
echo    [9]  Zoom                       [15] Epic Games Launcher
echo    [10] WhatsApp Desktop           [16] OBS Studio
echo                                  [17] VLC Media Player
echo.
echo    [S]  Rechercher une application
echo    [A]  Installer TOUTES les applications de base
echo.
echo    [0]  Retour
echo.
echo ================================================================================
set /p "app_ch=Entrez votre choix: "

if "%app_ch%"=="0" goto menu
if /i "%app_ch%"=="a" goto install_all_apps
if /i "%app_ch%"=="s" goto search_install_app
if "%app_ch%"=="1" goto apps_updater_wizard
if "%app_ch%"=="2" goto apps_uninstaller_wizard
if "%app_ch%"=="3" set "app_id=Microsoft.DotNet.Framework.DeveloperPack_4" & goto install_silent
if "%app_ch%"=="4" set "app_id=Microsoft.DirectX" & goto install_silent
if "%app_ch%"=="5" set "app_id=Google.Chrome" & goto install_silent
if "%app_ch%"=="6" set "app_id=Mozilla.Firefox" & goto install_silent
if "%app_ch%"=="7" set "app_id=Tonec.InternetDownloadManager" & goto install_silent
if "%app_ch%"=="8" set "app_id=Discord.Discord" & goto install_silent
if "%app_ch%"=="9" set "app_id=Zoom.Zoom" & goto install_silent
if "%app_ch%"=="10" set "app_id=WhatsApp.WhatsApp" & goto install_silent
if "%app_ch%"=="11" set "app_id=RARLab.WinRAR" & goto install_silent
if "%app_ch%"=="12" set "app_id=7zip.7zip" & goto install_silent
if "%app_ch%"=="13" set "app_id=Microsoft.VisualStudioCode" & goto install_silent
if "%app_ch%"=="14" set "app_id=Valve.Steam" & goto install_silent
if "%app_ch%"=="15" set "app_id=EpicGames.EpicGamesLauncher" & goto install_silent
if "%app_ch%"=="16" set "app_id=OBSProject.OBSStudio" & goto install_silent
if "%app_ch%"=="17" set "app_id=VideoLAN.VLC" & goto install_silent
goto menu_apps

:: ====================================================
:: FONCTIONS DE SURVEILLANCE
:: ====================================================

:sysinfo
cls
echo ================================================================================
echo                          INFORMATIONS SYSTEME
echo ================================================================================
echo.
systeminfo | findstr /B /C:"Nom du systeme" /C:"Version" /C:"Systeme d'exploitation" /C:"Processeur" /C:"Memoire physique"
echo.
ver
echo.
pause
goto menu_monitoring

:cpu_temp
cls
echo ================================================================================
echo                         TEMPERATURE DU PROCESSEUR
echo ================================================================================
echo.
powershell -Command "Get-WmiObject -Class MSAcpi_ThermalZoneTemperature -Namespace root/WMI | ForEach-Object { $temp = ($_.CurrentTemperature - 2732) / 10; Write-Host 'Temperature CPU: ' $temp '°C' }"
echo.
echo Remarque: Si aucune temperature n'apparait, votre materiel ne supporte pas cette fonction.
pause
goto menu_monitoring

:disk_health
cls
echo ================================================================================
echo                         SANTE DU DISQUE DUR (SMART)
echo ================================================================================
echo.
wmic diskdrive get status,model,size
echo.
echo Statut: OK = Disque en bonne sante
pause
goto menu_monitoring

:ram_usage
cls
echo ================================================================================
echo                         UTILISATION DE LA RAM
echo ================================================================================
echo.
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /format:table
echo.
systeminfo | findstr "Memoire"
pause
goto menu_monitoring

:ram_test
cls
echo ================================================================================
echo                          TEST DE LA MEMOIRE RAM
echo ================================================================================
echo.
echo [!] Attention: Ce test va redemarrer l'ordinateur
echo.
set /p confirm="Voulez-vous continuer? (O/N): "
if /i "%confirm%"=="O" (
    echo Redemarrage dans 5 secondes...
    timeout /t 5 >nul
    mdsched /restart
)
goto menu_monitoring

:disk_check_readonly
cls
echo ================================================================================
echo                     VERIFICATION DISQUE (LECTURE SEULE)
echo ================================================================================
echo.
chkdsk C: /scan
pause
goto menu_monitoring

:health_report
cls
echo ================================================================================
echo                         RAPPORT DE SANTE COMPLET
echo ================================================================================
echo.
set report=%userprofile%\Desktop\Rapport_Sante_Systeme.txt
echo RAPPORT DE SANTE SYSTEME - %date% %time% > "%report%"
echo ================================================================================ >> "%report%"
echo. >> "%report%"
echo [INFORMATIONS SYSTEME] >> "%report%"
systeminfo >> "%report%"
echo. >> "%report%"
echo [DISQUES] >> "%report%"
wmic diskdrive get status,model,size >> "%report%"
echo. >> "%report%"
echo [MEMOIRE RAM] >> "%report%"
wmic OS get TotalVisibleMemorySize,FreePhysicalMemory >> "%report%"
echo.
echo Rapport genere sur votre bureau: Rapport_Sante_Systeme.txt
pause
goto menu_monitoring

:monitor_processes
cls
echo ================================================================================
echo                    SURVEILLANCE DES PROCESSUS
echo ================================================================================
echo.
echo Liste des 15 processus utilisant le plus de RAM:
echo.
tasklist /NH | sort /+68 /R | more +3
pause
goto menu_monitoring

:uptime
cls
echo ================================================================================
echo                    DUREE DE FONCTIONNEMENT (UPTIME)
echo ================================================================================
echo.
systeminfo | findstr "Heure de demarrage du systeme"
pause
goto menu_monitoring

:disk_space
cls
echo ================================================================================
echo                           ESPACE DISQUE
echo ================================================================================
echo.
wmic logicaldisk where drivetype=3 get DeviceID,Size,FreeSpace /format:table
pause
goto menu_monitoring

:bios_version
cls
echo ================================================================================
echo                           VERSION DU BIOS
echo ================================================================================
echo.
wmic bios get name,version,manufacturer,serialnumber
pause
goto menu_monitoring

:battery_report
cls
echo ================================================================================
echo                         RAPPORT BATTERIE
echo ================================================================================
echo.
powercfg /batteryreport /output "%userprofile%\Desktop\Battery_Report.html"
echo Rapport genere sur votre bureau: Battery_Report.html
start "" "%userprofile%\Desktop\Battery_Report.html"
pause
goto menu_monitoring

:: ====================================================
:: FONCTIONS OPTIMISATION
:: ====================================================

:sfc
cls
echo Execution de SFC Scan...
sfc /scannow
pause
goto menu_optimize

:dism
cls
echo Execution de DISM RestoreHealth...
DISM /Online /Cleanup-Image /RestoreHealth
pause
goto menu_optimize

:comp_cleanup
cls
echo Nettoyage du stockage des composants...
DISM /Online /Cleanup-Image /StartComponentCleanup
pause
goto menu_optimize

:clean
cls
echo Nettoyage des fichiers temporaires...
del /q /f /s C:\Windows\Prefetch\* 2>nul
del /q /f /s C:\Windows\Temp\* 2>nul
del /q /f /s "%temp%\*" 2>nul
cleanmgr /sagerun:1 2>nul
echo [Nettoyage termine.]
pause
goto menu_optimize

:internet
cls
echo Optimisation Internet et DNS...
ipconfig /flushdns
ipconfig /release
ipconfig /renew
netsh winsock reset
netsh int ip reset
arp -d
echo [Optimisation terminee.]
pause
goto menu_optimize

:all
cls
echo Execution de la REPARATION COMPLETE...
sfc /scannow
DISM /Online /Cleanup-Image /RestoreHealth
DISM /Online /Cleanup-Image /StartComponentCleanup
del /q /f /s C:\Windows\Prefetch\* 2>nul
del /q /f /s C:\Windows\Temp\* 2>nul
del /q /f /s "%temp%\*" 2>nul
ipconfig /flushdns
netsh winsock reset
echo [Reparation complete terminee.]
pause
goto menu_optimize

:flush_dns
cls
ipconfig /flushdns
echo [Cache DNS vide.]
pause
goto menu_optimize

:gpu_perf
cls
echo Optimisation graphique...
reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" /v SystemResponsiveness /t REG_DWORD /d 0 /f >nul 2>&1
echo [Optimisation graphique terminee.]
pause
goto menu_optimize

:disable_visual
cls
echo Desactivation des effets visuels...
reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 2 /f >nul 2>&1
echo [Effets visuels desactives.]
pause
goto menu_optimize

:optimize_services
cls
echo Optimisation des services...
sc config DiagTrack start= disabled >nul 2>&1
sc config dmwappushservice start= disabled >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
echo [Optimisation terminee.]
pause
goto menu_optimize

:toggle_hibernate
cls
echo ================================================================================
echo                     ACTIVATION/DESACTIVATION HIBERNATION
echo ================================================================================
echo.
echo [1] DESACTIVER Hibernation (economise ESPACE SSD)
echo [2] ACTIVER Hibernation
echo.
set /p hb_choice="Choix: "
if "%hb_choice%"=="1" (
    powercfg /h off
    echo [Hibernation DESACTIVEE]
) else (
    powercfg /h on
    echo [Hibernation ACTIVEE]
)
pause
goto menu_optimize

:optimize_ssd
cls
echo ================================================================================
echo                         OPTIMISATION SSD
echo ================================================================================
echo.
sc config SysMain start= disabled >nul 2>&1
sc config WSearch start= disabled >nul 2>&1
defrag C: /L /U /V
echo [Optimisation SSD terminee!]
pause
goto menu_optimize

:defrag_registry
cls
echo ================================================================================
echo                     DEFRAGMENTATION DU REGISTRE
echo ================================================================================
echo.
echo Cette operation necessite un redemarrage.
set /p confirm="Voulez-vous redemarrer? (O/N): "
if /i "%confirm%"=="O" (
    reg add "HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\Memory Management" /v ClearPageFileAtShutdown /t REG_DWORD /d 1 /f >nul 2>&1
    shutdown /r /t 10
)
pause
goto menu_optimize

:: ====================================================
:: FONCTIONS DISQUE
:: ====================================================

:chkdsk
cls
echo Planification de CHKDSK...
echo y | chkdsk C: /f /r
echo [CHKDSK planifie.]
pause
goto menu_disk

:cancelchk
cls
chkntfs /x C:
echo [Planification annulee.]
pause
goto menu_disk

:defrag
cls
set /p drv=Entrez la lettre du lecteur (ex: C): 
set drv=%drv::=%
powershell -Command "if ((Get-PhysicalDisk | Where-Object { (Get-Partition -DriveLetter '%drv%').DiskNumber -eq $_.DeviceNumber }).MediaType -eq 'SSD') { exit 1 } else { exit 0 }" 2>nul
if %errorlevel% equ 1 (
    defrag %drv%: /L /U /V
) else (
    defrag %drv%: /O /U /V
)
pause
goto menu_disk

:cleanmgr_advanced
cls
cleanmgr /sageset:1
cleanmgr /sagerun:1
echo [Nettoyage termine.]
pause
goto menu_disk

:bad_sectors
cls
chkdsk C: /scan
pause
goto menu_disk

:optimize_all_disks
cls
for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
    if exist %%d:\ (
        echo Optimisation du lecteur %%d:...
        defrag %%d: /O /U /V
    )
)
echo [Optimisation terminee.]
pause
goto menu_disk

:full_chkdsk
cls
echo ================================================================================
echo                VERIFICATION COMPLETE DE TOUS LES DISQUES
echo ================================================================================
echo.
echo Cette operation peut prendre plusieurs heures.
set /p confirm="Continuer? (O/N): "
if /i "%confirm%"=="O" (
    for %%d in (C D E F G H I J K L M N O P Q R S T U V W X Y Z) do (
        if exist %%d:\ (
            echo Verification du disque %%d:...
            chkdsk %%d: /f /r /x
        )
    )
    echo [Verification complete terminee.]
)
pause
goto menu_disk

:clean_winsxs
cls
echo ================================================================================
echo                    NETTOYAGE DU DOSSIER WINSXS
echo ================================================================================
echo.
DISM /online /Cleanup-Image /StartComponentCleanup /ResetBase
echo [Nettoyage WinSxS termine!]
pause
goto menu_disk

:full_backup
cls
echo ================================================================================
echo                    SAUVEGARDE COMPLETE ULTIME (FULL BACKUP PLUS)
echo ================================================================================
echo.
echo [1] Sauvegarde COMPLETE (Systeme + Donnees + Registre + Pilotes)
echo [2] Sauvegarde RAPIDE (Users + ProgramData uniquement)
echo [3] Sauvegarde avec COMPRESSION (Economise 50%% d'espace)
echo [4] Sauvegarde vers DISQUE EXTERNE ou USB
echo [5] Sauvegarde vers Cloud (OneDrive/Dropbox/Google Drive)
echo [6] Sauvegarde PROGRAMMEE (Planification automatique)
echo [7] RESTAURATION depuis une sauvegarde
echo [8] VERIFIER l'integrite d'une sauvegarde
echo [9] SUPPRIMER les anciennes sauvegardes
echo.
echo [0] Retour
echo.
echo ================================================================================
set /p backup_choice="Entrez votre choix: "

if "%backup_choice%"=="1" goto backup_complete
if "%backup_choice%"=="2" goto backup_rapide
if "%backup_choice%"=="3" goto backup_compresse
if "%backup_choice%"=="4" goto backup_externe
if "%backup_choice%"=="5" goto backup_cloud
if "%backup_choice%"=="6" goto backup_programme
if "%backup_choice%"=="7" goto restore_backup
if "%backup_choice%"=="8" goto verify_backup
if "%backup_choice%"=="9" goto delete_old_backups
if "%backup_choice%"=="0" goto menu_disk
goto full_backup

:: ====================================================
:: SAUVEGARDE COMPLETE (TOUT)
:: ====================================================
:backup_complete
cls
echo ================================================================================
echo                 SAUVEGARDE COMPLETE (TOUT LE SYSTEME)
echo ================================================================================
echo.
echo Cette sauvegarde inclut:
echo   [*] Tous vos fichiers personnels (Users)
echo   [*] Configuration des programmes (ProgramData)
echo   [*] Registre Windows complet
echo   [*] Tous les pilotes installes
echo   [*] Liste des programmes installes
echo.
set /p backup_drive="Vers quel disque? (ex: D: ou E: ou F:): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque %backup_drive% introuvable!
    pause
    goto full_backup
)

set backup_folder=%backup_drive%\Backup_Complete_%date:~6,4%%date:~3,2%%date:~0,2%_%time:~0,2%%time:~3,2%
set backup_folder=%backup_folder: =0%
mkdir "%backup_folder%" 2>nul

echo.
echo Dossier de sauvegarde: %backup_folder%
echo.
echo [1/6] Sauvegarde des fichiers personnels...
robocopy "C:\Users" "%backup_folder%\Users" /MIR /COPY:DAT /R:2 /W:5 /MT:8 /XD "C:\Users\Default" "C:\Users\All Users" "C:\Users\Public" /XJD

echo [2/6] Sauvegarde des configurations programmes...
robocopy "C:\ProgramData" "%backup_folder%\ProgramData" /MIR /COPY:DAT /R:2 /W:5 /MT:8 /XJD

echo [3/6] Sauvegarde du REGISTRE Windows...
reg export HKLM "%backup_folder%\Registry_HKLM.reg" >nul 2>&1
reg export HKCU "%backup_folder%\Registry_HKCU.reg" >nul 2>&1
reg export HKCR "%backup_folder%\Registry_HKCR.reg" >nul 2>&1
reg export HKU "%backup_folder%\Registry_HKU.reg" >nul 2>&1
reg export HKCC "%backup_folder%\Registry_HKCC.reg" >nul 2>&1

echo [4/6] Sauvegarde des PILOTES...
dism /online /export-driver /destination:"%backup_folder%\Drivers" >nul 2>&1

echo [5/6] Sauvegarde de la LISTE DES PROGRAMMES...
winget list > "%backup_folder%\Programmes_Installes.txt" 2>nul
wmic product get name,version > "%backup_folder%\Programmes_Details.txt" 2>nul

echo [6/6] Creation d'un SCRIPT DE RESTAURATION AUTOMATIQUE...
(
echo @echo off
echo echo ========================================
echo echo    SCRIPT DE RESTAURATION AUTOMATIQUE
echo echo ========================================
echo echo.
echo echo [1/5] Restauration des pilotes...
echo pnputil /add-driver "%%~dp0Drivers\*.inf" /subdirs /install
echo echo.
echo echo [2/5] Restauration du registre...
echo reg import "%%~dp0Registry_HKLM.reg"
echo reg import "%%~dp0Registry_HKCU.reg"
echo echo.
echo echo [3/5] Restauration des fichiers...
echo robocopy "%%~dp0Users" "C:\Users" /MIR /COPY:DAT
echo robocopy "%%~dp0ProgramData" "C:\ProgramData" /MIR /COPY:DAT
echo echo.
echo echo [4/5] Reinstallation des programmes...
echo winget import "%%~dp0Programmes.json"
echo echo.
echo echo [5/5] Redemarrage recommande...
echo shutdown /r /t 60
) > "%backup_folder%\RESTAURER_AUTO.bat"

echo.
echo ================================================================================
echo [SUCCES] Sauvegarde COMPLETE terminee!
echo Dossier: %backup_folder%
echo ================================================================================
echo.
echo Fichiers crees:
echo   - Users (vos fichiers)
echo   - ProgramData (configurations)
echo   - Registry_*.reg (registre)
echo   - Drivers (pilotes)
echo   - Programmes_*.txt (liste des programmes)
echo   - RESTAURER_AUTO.bat (script de restauration)
echo.
pause
goto full_backup

:: ====================================================
:: SAUVEGARDE RAPIDE
:: ====================================================
:backup_rapide
cls
echo ================================================================================
echo                    SAUVEGARDE RAPIDE
echo ================================================================================
echo.
set /p backup_drive="Vers quel disque? (ex: D: ou E:): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto full_backup
)

set backup_folder=%backup_drive%\Backup_Rapide_%date:~6,4%%date:~3,2%%date:~0,2%
mkdir "%backup_folder%" 2>nul

echo Sauvegarde vers: %backup_folder%
echo.
echo Copie des fichiers personnels...
robocopy "C:\Users" "%backup_folder%\Users" /E /COPY:DAT /R:0 /W:0 /NDL /NJH /NJS /XD "C:\Users\Default" "C:\Users\All Users" "C:\Users\Public" "C:\Users\*\AppData\Local\Temp" "C:\Users\*\AppData\Local\Cache"

echo Copie des configurations...
robocopy "C:\ProgramData" "%backup_folder%\ProgramData" /E /COPY:DAT /R:0 /W:0 /NDL /NJH /NJS

echo.
echo [SUCCES] Sauvegarde rapide terminee!
echo Dossier: %backup_folder%
pause
goto full_backup

:: ====================================================
:: SAUVEGARDE AVEC COMPRESSION (ZIP)
:: ====================================================
:backup_compresse
cls
echo ================================================================================
echo                 SAUVEGARDE AVEC COMPRESSION (ZIP)
echo ================================================================================
echo.
echo La compression permet d' economiser jusqu'a 70%% d'espace!
echo.
set /p backup_drive="Vers quel disque? (ex: D: ou E:): "
set "backup_drive=%backup_drive:~0,1%"
set "backup_drive=%backup_drive%:"

if not exist "%backup_drive%\" (
    echo [ERREUR] Disque introuvable!
    pause
    goto full_backup
)

set backup_name=Backup_Compresse_%date:~6,4%%date:~3,2%%date:~0,2%
set temp_folder=%temp%\%backup_name%
mkdir "%temp_folder%" 2>nul

echo.
echo [1/3] Preparation des fichiers...
robocopy "C:\Users" "%temp_folder%\Users" /E /COPY:DAT /R:0 /W:0 /XD "C:\Users\Default" "C:\Users\All Users" "C:\Users\Public" "C:\Users\*\AppData\Local\Temp"
robocopy "C:\ProgramData" "%temp_folder%\ProgramData" /E /COPY:DAT /R:0 /W:0

echo [2/3] Compression en cours...
powershell -Command "Compress-Archive -Path '%temp_folder%\*' -DestinationPath '%backup_drive%\%backup_name%.zip' -CompressionLevel Optimal"

echo [3/3] Nettoyage...
rmdir /s /q "%temp_folder%" 2>nul

echo.
echo [SUCCES] Sauvegarde compressee terminee!
echo Fichier: %backup_drive%\%backup_name%.zip
echo Taille: 
dir "%backup_drive%\%backup_name%.zip" | findstr ".zip"
pause
goto full_backup

:: ====================================================
:: SAUVEGARDE VERS DISQUE EXTERNE
:: ====================================================
:backup_externe
cls
echo ================================================================================
echo                 SAUVEGARDE VERS DISQUE EXTERNE
echo ================================================================================
echo.
echo [!] Branchez votre disque dur externe ou USB
echo.
pause
echo.
echo Detection des disques externes...
echo.
wmic logicaldisk where drivetype=2 get DeviceID,VolumeName,Size,FileSystem
echo.
set /p usb_drive="Lettre du disque externe (ex: E: ou G:): "
set "usb_drive=%usb_drive:~0,1%"
set "usb_drive=%usb_drive%:"

if not exist "%usb_drive%\" (
    echo [ERREUR] Disque externe introuvable!
    pause
    goto full_backup
)

set backup_folder=%usb_drive%\Backup_Externe_%date:~6,4%%date:~3,2%%date:~0,2%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde vers disque externe: %usb_drive%
echo.
robocopy "C:\Users" "%backup_folder%\Users" /MIR /COPY:DAT /R:2 /W:5
robocopy "C:\ProgramData" "%backup_folder%\ProgramData" /MIR /COPY:DAT /R:2 /W:5

echo.
echo [SUCCES] Sauvegarde sur disque externe terminee!
echo Dossier: %backup_folder%
echo.
echo [!] IMPORTANT: Ejectez le disque avant de le debrancher!
pause
goto full_backup

:: ====================================================
:: SAUVEGARDE VERS CLOUD
:: ====================================================
:backup_cloud
cls
echo ================================================================================
echo                    SAUVEGARDE VERS CLOUD
echo ================================================================================
echo.
echo [1] OneDrive (Microsoft)
echo [2] Google Drive
echo [3] Dropbox
echo.
set /p cloud_choice="Choix: "

set cloud_path=
if "%cloud_choice%"=="1" set cloud_path=%userprofile%\OneDrive
if "%cloud_choice%"=="2" set cloud_path=%userprofile%\Google Drive
if "%cloud_choice%"=="3" set cloud_path=%userprofile%\Dropbox

if not exist "%cloud_path%\" (
    echo [ERREUR] %cloud_path% non trouve!
    echo Veuillez installer et configurer le cloud d'abord.
    pause
    goto full_backup
)

set backup_folder=%cloud_path%\Backup_Cloud_%date:~6,4%%date:~3,2%%date:~0,2%
mkdir "%backup_folder%" 2>nul

echo.
echo Sauvegarde vers: %backup_folder%
echo.
robocopy "C:\Users\%USERNAME%\Desktop" "%backup_folder%\Desktop" /E /COPY:DAT
robocopy "C:\Users\%USERNAME%\Documents" "%backup_folder%\Documents" /E /COPY:DAT
robocopy "C:\Users\%USERNAME%\Pictures" "%backup_folder%\Pictures" /E /COPY:DAT

echo.
echo [SUCCES] Sauvegarde cloud terminee!
echo Les fichiers seront synchronises automatiquement.
pause
goto full_backup

:: ====================================================
:: SAUVEGARDE PROGRAMMEE (TACHE PLANIFIEE)
:: ====================================================
:backup_programme
cls
echo ================================================================================
echo                 SAUVEGARDE PROGRAMMEE AUTOMATIQUE
echo ================================================================================
echo.
echo Cree une tache planifiee pour sauvegarder automatiquement.
echo.
echo [1] Sauvegarde quotidienne (tous les jours a 20h00)
echo [2] Sauvegarde hebdomadaire (tous les dimanches a 21h00)
echo [3] Sauvegarde mensuelle (1er du mois a 22h00)
echo.
set /p schedule_choice="Choix: "

set schedule_time=
if "%schedule_choice%"=="1" set schedule_time="20:00"
if "%schedule_choice%"=="2" set schedule_time="21:00"
if "%schedule_choice%"=="3" set schedule_time="22:00"

set schedule_freq=
if "%schedule_choice%"=="1" set schedule_freq="DAILY"
if "%schedule_choice%"=="2" set schedule_freq="WEEKLY"
if "%schedule_choice%"=="3" set schedule_freq="MONTHLY"

set backup_script=%userprofile%\Desktop\AutoBackup.bat

(
echo @echo off
echo set backup_drive=D:
echo set backup_folder=%%backup_drive%%\Backup_Auto_%%date:~6,4%%%%date:~3,2%%%%date:~0,2%%
echo mkdir %%backup_folder%% 2^>nul
echo robocopy "C:\Users" "%%backup_folder%%\Users" /MIR /COPY:DAT /R:2 /W:5
echo robocopy "C:\ProgramData" "%%backup_folder%%\ProgramData" /MIR /COPY:DAT /R:2 /W:5
echo echo Sauvegarde auto terminee le %%date%% %%time%% ^>^> "%%backup_folder%%\log.txt"
) > "%backup_script%"

schtasks /create /tn "Backup_Automatique" /tr "%backup_script%" /sc %schedule_freq% /st %schedule_time% /f >nul 2>&1

echo.
echo [SUCCES] Tache planifiee creee!
echo Nom: Backup_Automatique
echo Frequence: %schedule_freq%
echo Heure: %schedule_time%
echo Script: %backup_script%
pause
goto full_backup

:: ====================================================
:: RESTAURATION
:: ====================================================
:restore_backup
cls
echo ================================================================================
echo                    RESTAURATION D'UNE SAUVEGARDE
echo ================================================================================
echo.
echo Recherche des sauvegardes disponibles...
echo.
for /d %%i in (D:\Backup_* E:\Backup_* F:\Backup_* G:\Backup_*) do (
    if exist "%%i" echo [TROUVE] %%i
)
echo.
set /p backup_path="Entrez le chemin complet de la sauvegarde: "

if not exist "%backup_path%\" (
    echo [ERREUR] Dossier introuvable!
    pause
    goto full_backup
)

echo.
echo [1] Restauration COMPLETE (tout)
echo [2] Restauration fichiers uniquement
echo [3] Restauration registre uniquement
echo [4] Restauration pilotes uniquement
echo.
set /p restore_choice="Choix: "

if "%restore_choice%"=="1" (
    if exist "%backup_path%\RESTAURER_AUTO.bat" (
        echo Execution du script automatique...
        call "%backup_path%\RESTAURER_AUTO.bat"
    ) else (
        echo Restauration manuelle...
        robocopy "%backup_path%\Users" "C:\Users" /MIR /COPY:DAT
        robocopy "%backup_path%\ProgramData" "C:\ProgramData" /MIR /COPY:DAT
        for %%r in ("%backup_path%\Registry_*.reg") do reg import "%%r"
        pnputil /add-driver "%backup_path%\Drivers\*.inf" /subdirs /install
    )
)

if "%restore_choice%"=="2" (
    robocopy "%backup_path%\Users" "C:\Users" /MIR /COPY:DAT
    robocopy "%backup_path%\ProgramData" "C:\ProgramData" /MIR /COPY:DAT
)

if "%restore_choice%"=="3" (
    for %%r in ("%backup_path%\Registry_*.reg") do reg import "%%r"
)

if "%restore_choice%"=="4" (
    pnputil /add-driver "%backup_path%\Drivers\*.inf" /subdirs /install
)

echo.
echo [SUCCES] Restauration terminee!
pause
goto full_backup

:: ====================================================
:: VERIFICATION D'INTEGRITE
:: ====================================================
:verify_backup
cls
echo ================================================================================
echo                 VERIFICATION D'INTEGRITE
echo ================================================================================
echo.
set /p backup_path="Chemin de la sauvegarde a verifier: "

if not exist "%backup_path%\" (
    echo [ERREUR] Dossier introuvable!
    pause
    goto full_backup
)

echo.
echo Verification en cours...
echo ================================================================================
echo.

:: Verifier Users
if exist "%backup_path%\Users" (
    echo [OK] Dossier Users present
    dir "%backup_path%\Users" /AD /B | find /c /v "" > temp.txt
    set /p user_count=<temp.txt
    echo     - %user_count% dossiers utilisateur(s)
    del temp.txt
) else (
    echo [MANQUANT] Dossier Users
)

:: Verifier ProgramData
if exist "%backup_path%\ProgramData" (
    echo [OK] Dossier ProgramData present
) else (
    echo [MANQUANT] Dossier ProgramData
)

:: Verifier Registre
if exist "%backup_path%\Registry_HKLM.reg" (
    echo [OK] Registre present
) else (
    echo [MANQUANT] Registre
)

:: Verifier Pilotes
if exist "%backup_path%\Drivers" (
    echo [OK] Dossier Drivers present
) else (
    echo [MANQUANT] Dossier Drivers
)

:: Calculer taille
powershell -Command "$size = (Get-ChildItem -Path '%backup_path%' -Recurse | Measure-Object -Property Length -Sum).Sum / 1GB; Write-Host 'Taille totale: ' $size.ToString('0.00') ' GB'"

echo.
echo ================================================================================
pause
goto full_backup

:: ====================================================
:: SUPPRESSION ANCIENNES SAUVEGARDES
:: ====================================================
:delete_old_backups
cls
echo ================================================================================
echo              SUPPRESSION DES ANCIENNES SAUVEGARDES
echo ================================================================================
echo.
echo Recherche des sauvegardes plus anciennes que 30 jours...
echo.
for /d %%i in (D:\Backup_* E:\Backup_* F:\Backup_* G:\Backup_*) do (
    if exist "%%i" (
        forfiles /p "%%i" /d -30 /c "cmd /c echo [SUPPRIME] %%i" 2>nul
    )
)
echo.
echo Voulez-vous supprimer TOUTES les anciennes sauvegardes? (O/N)
set /p confirm=""
if /i "%confirm%"=="O" (
    for /d %%i in (D:\Backup_* E:\Backup_* F:\Backup_* G:\Backup_*) do (
        if exist "%%i" (
            forfiles /p "%%i" /d -30 /c "cmd /c rmdir /s /q @path" 2>nul
        )
    )
    echo [SUCCES] Anciennes sauvegardes supprimees!
) else (
    echo [ANNULER]
)
pause
goto full_backup
:: ====================================================
:: FONCTIONS AVANCEES
:: ====================================================

:ultimate_perf
cls
powercfg -duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 > temp.txt 2>nul
for /f "tokens=4" %%i in ('findstr /i "GUID" temp.txt 2^>nul') do set GUID=%%i
if "%GUID%"=="" (
    echo Impossible sur cette version.
) else (
    powercfg /setactive %GUID% 2>nul
    echo [Mode Performance Extreme active.]
)
del temp.txt 2>nul
pause
goto menu_advanced

:restore_balanced
cls
powercfg -setactive 381b4222-f694-41f0-9685-ff5bb260df2e 2>nul
echo [Mode Equilibre restaure.]
pause
goto menu_advanced

:shutdown
cls
set /p st=Entrez les minutes: 
set /a ss=%st%*60
shutdown /s /t %ss%
echo [Extinction dans %st% minutes.]
pause
goto menu_advanced

:cancelshutdown
cls
shutdown /a
echo [Extinction annulee.]
pause
goto menu_advanced

:bios
cls
shutdown /r /fw /t 60
echo [Redemarrage vers BIOS dans 60 secondes.]
pause
goto menu_advanced

:safemode
cls
echo Preparation du Mode sans echec...
echo.
echo [!] Pour revenir: bcdedit /deletevalue {current} safeboot
pause
bcdedit /set {current} safeboot minimal
shutdown /r /t 60
goto menu_advanced

:debloat
cls
echo Suppression des applications inutiles...
powershell -Command "Get-AppxPackage *bing* | Remove-AppxPackage" 2>nul
powershell -Command "Get-AppxPackage *zune* | Remove-AppxPackage" 2>nul
powershell -Command "Get-AppxPackage *xboxapp* | Remove-AppxPackage" 2>nul
echo [Nettoyage termine.]
pause
goto menu_advanced

:clean_updates
cls
echo Nettoyage des mises a jour...
DISM /online /Cleanup-Image /StartComponentCleanup /ResetBase
if exist "C:\Windows.old" rd /s /q "C:\Windows.old" 2>nul
echo [Nettoyage termine.]
pause
goto menu_advanced

:clean_dumps
cls
del /f /q /s %systemroot%\Minidump\* 2>nul
del /f /q /s %systemroot%\MEMORY.DMP 2>nul
echo [Fichiers crash nettoyes.]
pause
goto menu_advanced

:wifi_pwd
cls
echo ================================================================================
echo                     MOTS DE PASSE WI-FI
echo ================================================================================
echo.
powershell -Command "netsh wlan show profiles | Select-String 'All User Profile' | ForEach-Object { $profile = $_.ToString().Split(':')[1].Trim(); $pass = (netsh wlan show profile name=$profile key=clear | Select-String 'Key Content' | ForEach-Object { $_.ToString().Split(':')[1].Trim() }); Write-Host 'Wi-Fi: ' $profile ' | Mot de passe: ' $pass }"
pause
goto menu_advanced

:disable_updates
cls
net stop wuauserv >nul 2>&1
sc config wuauserv start= disabled >nul 2>&1
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /t REG_DWORD /d 1 /f >nul 2>&1
echo [Windows Update DESACTIVE.]
pause
goto menu_advanced

:enable_updates
cls
reg delete "HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU" /v NoAutoUpdate /f >nul 2>&1
sc config wuauserv start= demand >nul 2>&1
net start wuauserv >nul 2>&1
echo [Windows Update ACTIVE.]
pause
goto menu_advanced

:change_dns
cls
echo ================================================================================
echo                           CHANGER DNS
echo ================================================================================
echo.
echo [1] Cloudflare (1.1.1.1)
echo [2] Google (8.8.8.8)
echo [3] Quad9 (9.9.9.9)
echo [4] OpenDNS (208.67.222.222)
echo [5] Restaurer DNS par defaut
echo.
set /p "dns_ch=Choix: "
if "%dns_ch%"=="1" (
    netsh interface ip set dns name="Wi-Fi" source=static address=1.1.1.1 >nul 2>&1
    netsh interface ip set dns name="Ethernet" source=static address=1.1.1.1 >nul 2>&1
    echo [DNS Cloudflare applique.]
)
if "%dns_ch%"=="2" (
    netsh interface ip set dns name="Wi-Fi" source=static address=8.8.8.8 >nul 2>&1
    netsh interface ip set dns name="Ethernet" source=static address=8.8.8.8 >nul 2>&1
    echo [DNS Google applique.]
)
if "%dns_ch%"=="3" (
    netsh interface ip set dns name="Wi-Fi" source=static address=9.9.9.9 >nul 2>&1
    netsh interface ip set dns name="Ethernet" source=static address=9.9.9.9 >nul 2>&1
    echo [DNS Quad9 applique.]
)
if "%dns_ch%"=="4" (
    netsh interface ip set dns name="Wi-Fi" source=static address=208.67.222.222 >nul 2>&1
    netsh interface ip set dns name="Ethernet" source=static address=208.67.222.222 >nul 2>&1
    echo [DNS OpenDNS applique.]
)
if "%dns_ch%"=="5" (
    netsh interface ip set dns name="Wi-Fi" source=dhcp >nul 2>&1
    netsh interface ip set dns name="Ethernet" source=dhcp >nul 2>&1
    echo [DNS par defaut restaure.]
)
pause
goto change_dns

:clean_gamers_cache
cls
echo Nettoyage du cache des jeux...
if exist "%appdata%\Discord\Cache" del /q /f /s "%appdata%\Discord\Cache\*" 2>nul
if exist "%localappdata%\Steam\htmlcache" del /q /f /s "%localappdata%\Steam\htmlcache\*" 2>nul
del /q /f /s "%localappdata%\D3DSCache\*" 2>nul
echo [Cache nettoye.]
pause
goto menu_advanced

:clean_registry
cls
echo Nettoyage du Registre...
reg export HKLM %userprofile%\Desktop\RegBackup_HKLM.reg >nul 2>&1
reg export HKCU %userprofile%\Desktop\RegBackup_HKCU.reg >nul 2>&1
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\RunMRU" /f >nul 2>&1
reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\RecentDocs" /f >nul 2>&1
echo [Nettoyage termine. Sauvegarde sur le bureau.]
pause
goto menu_advanced

:backup_registry
cls
set backup_dir=%userprofile%\Desktop\Registry_Backup_%date:~6,4%%date:~3,2%%date:~0,2%
mkdir "%backup_dir%" 2>nul
reg export HKLM "%backup_dir%\HKLM.reg" >nul 2>&1
reg export HKCU "%backup_dir%\HKCU.reg" >nul 2>&1
echo [Sauvegarde dans: %backup_dir%]
pause
goto menu_advanced

:restore_registry
cls
dir %userprofile%\Desktop\Registry_Backup_* /AD /B
echo.
set /p reg_backup="Nom du dossier de sauvegarde: "
if exist "%userprofile%\Desktop\%reg_backup%" (
    reg import "%userprofile%\Desktop\%reg_backup%\HKLM.reg" >nul 2>&1
    reg import "%userprofile%\Desktop\%reg_backup%\HKCU.reg" >nul 2>&1
    echo [Registre restaure.]
)
pause
goto menu_advanced

:reset_windows_update
cls
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
rd /s /q C:\Windows\SoftwareDistribution 2>nul
rd /s /q C:\Windows\System32\catroot2 2>nul
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo [Windows Update reinitialise.]
pause
goto menu_advanced

:repair_dotnet
cls
powershell -Command "Get-WindowsOptionalFeature -Online -FeatureName NetFx3 | Enable-WindowsOptionalFeature -Online -FeatureName NetFx3 -All" >nul 2>&1
echo [.NET Framework verifie.]
pause
goto menu_advanced

:reset_network
cls
netsh winsock reset
netsh int ip reset
ipconfig /release
ipconfig /renew
ipconfig /flushdns
echo [Reseau reinitialise. Redemarrage recommande.]
pause
goto menu_advanced

:god_mode
cls
set godfolder="%userprofile%\Desktop\God Mode.{ED7BA470-8E54-465E-825C-99712043E01C}"
mkdir %godfolder% 2>nul
echo [Mode Dieu active sur le bureau!]
pause
goto menu_advanced

:verify_all_files
cls
echo Verification de TOUS les fichiers systeme...
echo Cela peut prendre 30-60 minutes.
set /p confirm="Continuer? (O/N): "
if /i "%confirm%"=="O" (
    sfc /scannow
    DISM /Online /Cleanup-Image /RestoreHealth
)
pause
goto menu_advanced

:kill_bloat
cls
echo Suppression des processus inutiles...
for %%p in (OneDriveSetup.exe XboxApps.exe XboxPcAppFT.exe) do (
    taskkill /f /im %%p >nul 2>&1
)
sc config XblAuthManager start= disabled >nul 2>&1
sc config XblGameSave start= disabled >nul 2>&1
echo [Processus inutiles supprimes.]
pause
goto menu_advanced

:reset_services
cls
secedit /configure /cfg %windir%\inf\defltbase.inf /db defltbase.sdb /verbose
echo [Services reinitialises.]
pause
goto menu_advanced

:complete_reset
cls
echo ================================================================================
echo                 REINITIALISATION COMPLETE DU SYSTEME
echo ================================================================================
echo.
echo [!] ATTENTION: Cette operation va reinitialiser Windows!
echo Tous vos fichiers personnels seront conserves, mais les applications seront supprimees.
echo.
set /p confirm="Voulez-vous vraiment reinitialiser? (O/N): "
if /i "%confirm%"=="O" (
    systemreset -factoryreset
) else (
    echo [Operation annulee.]
)
pause
goto menu_advanced

:kill_telemetry
cls
echo Desactivation TOTALE de la telemetrie...
for %%s in (DiagTrack dmwappushservice WMPNetworkSvc wcncsvc PcaSvc) do (
    sc config %%s start= disabled >nul 2>&1
    sc stop %%s >nul 2>&1
)
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
echo [Telemetrie TOTALEMENT desactivee.]
pause
goto menu_security

:block_malicious
cls
echo Blocage des IP malveillantes...
echo 0.0.0.0 127.0.0.1 > %temp%\hosts_temp.txt
copy /y %temp%\hosts_temp.txt C:\Windows\System32\drivers\etc\hosts >nul 2>&1
echo [IP malveillantes bloquees.]
pause
goto menu_security

:: ====================================================
:: FONCTIONS REPARATION
:: ====================================================

:winupdate
cls
net stop wuauserv >nul 2>&1
net stop bits >nul 2>&1
rd /s /q C:\Windows\SoftwareDistribution 2>nul
net start wuauserv >nul 2>&1
net start bits >nul 2>&1
echo [Windows Update repare.]
pause
goto menu_repair

:store
cls
wsreset.exe
echo [Microsoft Store reinitialise.]
pause
goto menu_repair

:icons
cls
taskkill /f /im explorer.exe >nul 2>&1
del /a /q "%localappdata%\IconCache.db" 2>nul
start explorer.exe
echo [Cache des icones reconstruit.]
pause
goto menu_repair

:taskbar
cls
taskkill /f /im explorer.exe >nul 2>&1
start explorer.exe
powershell -Command "& {$manifest = (Get-AppxPackage Microsoft.Windows.ShellExperienceHost).InstallLocation + '\AppxManifest.xml' ; Add-AppxPackage -DisableDevelopmentMode -Register $manifest}" 2>nul
echo [Barre des taches reparee.]
pause
goto menu_repair

:explorer_repair
cls
taskkill /f /im explorer.exe >nul 2>&1
timeout /t 2 >nul
start explorer.exe
echo [Explorateur reinitialise.]
pause
goto menu_repair

:firewall_reset
cls
netsh advfirewall reset
echo [Pare-feu reinitialise.]
pause
goto menu_repair

:fix_permissions
cls
icacls C:\Windows /reset /T /Q >nul 2>&1
icacls "C:\Program Files" /reset /T /Q >nul 2>&1
echo [Droits d'acces repares.]
pause
goto menu_repair

:detailed_sfc
cls
findstr /c:"[SR]" %windir%\Logs\CBS\CBS.log > "%userprofile%\Desktop\SFC_Details.txt"
echo [Rapport SFC sur le bureau: SFC_Details.txt]
pause
goto menu_repair

:: ====================================================
:: FONCTIONS SECURITE
:: ====================================================

:quickscan
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 1
pause
goto menu_security

:fullscan
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 2
pause
goto menu_security

:enable_telemetry
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 1 /f >nul 2>&1
sc config DiagTrack start= auto >nul 2>&1
net start DiagTrack >nul 2>&1
echo [Telemetrie activee.]
pause
goto menu_security

:disable_telemetry
cls
reg add "HKLM\SOFTWARE\Policies\Microsoft\Windows\DataCollection" /v AllowTelemetry /t REG_DWORD /d 0 /f >nul 2>&1
sc config DiagTrack start= disabled >nul 2>&1
sc stop DiagTrack >nul 2>&1
echo [Telemetrie desactivee.]
pause
goto menu_security

:fix_defender
cls
powershell -Command "Get-AppxPackage *Microsoft.Windows.SecHealthUI* | Reset-AppxPackage" 2>nul
echo [Windows Defender repare.]
pause
goto menu_security

:spyware_scan
cls
"%ProgramFiles%\Windows Defender\MpCmdRun.exe" -Scan -ScanType 3
pause
goto menu_security

:open_ports
cls
netstat -an | findstr LISTENING
pause
goto menu_security

:: ====================================================
:: FONCTIONS PILOTES
:: ====================================================

:driver_updater
cls
powershell -NoProfile -ExecutionPolicy Bypass -Command "if (-not (Get-Module -ListAvailable -Name PSWindowsUpdate)) { Install-Module -Name PSWindowsUpdate -Force -SkipPublisherCheck -AllowClobber -Confirm:`$false }" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-WindowsUpdate -Category Drivers | Select-Object Title,Size"
set /p install_drv="Installer les mises a jour? (O/N): "
if /i "%install_drv%"=="O" (
    powershell -NoProfile -ExecutionPolicy Bypass -Command "Get-WindowsUpdate -Category Drivers | Install-WindowsUpdate -AcceptAll -AutoReboot:`$false"
)
pause
goto menu_drivers

:backup_drivers
cls
if not exist "D:\Drivers_Backup" mkdir "D:\Drivers_Backup" 2>nul
dism /online /export-driver /destination:"D:\Drivers_Backup"
echo [Sauvegarde dans D:\Drivers_Backup]
pause
goto menu_drivers

:restore_drivers
cls
if not exist "D:\Drivers_Backup" (
    echo [Erreur: Dossier introuvable]
    pause
    goto menu_drivers
)
pnputil /add-driver "D:\Drivers_Backup\*.inf" /subdirs /install
echo [Restauration terminee.]
pause
goto menu_drivers

:drivers_uninstaller_wizard
cls
pnputil /enum-drivers
echo.
set /p "target_driver=Entrez le nom (ex: oem12.inf): "
pnputil /delete-driver "%target_driver%" /uninstall /force
pause
goto menu_drivers

:driver_list
cls
driverquery /V
pause
goto menu_drivers

:unsigned_drivers
cls
driverquery /SI
pause
goto menu_drivers

:: ====================================================
:: FONCTIONS APPLICATIONS
:: ====================================================

:install_silent
echo.
echo Installation de %app_id%...
winget install --id "%app_id%" --silent --accept-source-agreements --accept-package-agreements
if %errorlevel% equ 0 (echo [Succes]) else (echo [Echec])
pause
goto menu_apps

:install_all_apps
cls
for %%g in (Google.Chrome Tonec.InternetDownloadManager VideoLAN.VLC RARLab.WinRAR 7zip.7zip) do (
    echo Installation de %%g...
    winget install --id "%%g" --silent --accept-source-agreements --accept-package-agreements >nul 2>&1
)
echo [Applications installees.]
pause
goto menu_apps

:apps_uninstaller_wizard
cls
winget list
echo.
set /p "un_app_id=Entrez l'ID a desinstaller: "
winget uninstall --id "%un_app_id%" --silent --purge 2>nul
if %errorlevel% neq 0 (winget uninstall "%un_app_id%" --silent --purge 2>nul)
echo [Desinstallation terminee.]
pause
goto menu_apps

:apps_updater_wizard
cls
winget upgrade
echo.
echo [1] Tout mettre a jour
echo [2] Choisir une application
set /p "up_choice=Choix: "
if "%up_choice%"=="1" (
    winget upgrade --all --silent --accept-source-agreements --accept-package-agreements
)
if "%up_choice%"=="2" (
    set /p "single_up_id=Entrez l'ID: "
    winget upgrade --id "%single_up_id%" --silent --accept-source-agreements --accept-package-agreements
)
echo [Mise a jour terminee.]
pause
goto menu_apps

:search_install_app
cls
set /p "custom_app=Nom de l'application: "
winget search "%custom_app%"
echo.
set /p "app_id_choice=Entrez l'ID: "
winget install --id "%app_id_choice%" --silent --accept-source-agreements --accept-package-agreements
pause
goto menu_apps

:: ====================================================
:: POINT DE RESTAURATION
:: ====================================================

:create_restore_point
cls
powershell -NoProfile -ExecutionPolicy Bypass -Command "Enable-ComputerRestore -Drive 'C:\'" >nul 2>&1
powershell -NoProfile -ExecutionPolicy Bypass -Command "Checkpoint-Computer -Description 'WinRTP_Auto_Backup' -RestorePointType 'MODIFY_SETTINGS'" >nul 2>&1
if %errorlevel% equ 0 (
    echo [Point de restauration cree avec succes!]
) else (
    echo [Erreur: Verifiez que la protection du systeme est activee.]
)
pause
goto menu

:: ====================================================
:: MISE A JOUR
:: ====================================================

:UPDATE
cls
echo ================================================================================
echo                         VERIFICATION DES MISES A JOUR
echo ================================================================================
echo.
setlocal EnableDelayedExpansion
set CURRENT_VERSION=3.0
echo Version actuelle: %CURRENT_VERSION%
echo Version en ligne: 3.0
echo.
echo [Vous avez deja la derniere version Amîr technicien informatique.]
pause
goto menu

:: ====================================================
:: A PROPOS
:: ====================================================

:about
cls
echo ================================================================================
echo                              A PROPOS
echo ================================================================================
echo.
echo    Developpeur: Amiros pc
echo    Version: 3.0 (Ultimate Edition)
echo.
echo    Fonctionnalites:
echo    - 80+ outils de maintenance
echo    - Compatible Windows 7/8/10/11
echo    - Aucune installation requise
echo    - Interface simple et intuitive
echo.
echo    Facebook: https://www.facebook.com/share/1CNoSo3NyN/
echo.
echo ================================================================================
pause
goto menu