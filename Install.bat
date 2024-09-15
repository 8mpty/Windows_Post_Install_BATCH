@echo off
setlocal enabledelayedexpansion
rem CenterSelf
mode 67, 30


IF NOT EXIST %temp%\POST_TEMP\ (cd /D ./IndividualScripts/) else ( cd /D %temp%/POST_TEMP/)
set ps=powershell.exe -NoProfile -ExecutionPolicy Unrestricted -Command "
title AFTER_WINDOWS_INSTALL
mode 67, 30

:start
cls

echo ----------------------------------------------------------------
echo                         Choose Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Windows Activator
echo  [2]. ChrisTitusTech's Programs Install Manager
echo  [3]. Enable/Disable Windows AutoLogin
echo  [4]. Download Debloater Scripts/Programs
echo  [5]. Extras
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" (
    set /P op=Enter your choice on your keyboard [1,2,3,4,5,0]: 
) else (
    shift
)


if %op%==0 goto end
if %op%==5 goto misc
if %op%==4 goto download_debloaters
if %op%==3 goto wal
if %op%==2 goto ctt
if %op%==1 goto mass

goto start
::======================================================================================

::======================================================================================
:misc
cls

cls
echo ----------------------------------------------------------------
echo                      Choose Options [Extras Page(1)]                    
echo ----------------------------------------------------------------
echo.
echo  [1]. Standalone Winget Install
echo  [2]. Extract all Drivers
echo  [3]. Remove/Restore Folders from "This PC"
echo  [4]. Enable/Disable UAC Verification
echo  [5]. Backup Firefox Settings
echo  [6]. Create Shortcut for this script (Desktop)
echo  [7]. Download This Script Locally
echo  [8]. Next Page
echo  [9]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,4,5,6,7,8,9,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==9 goto start
if %op%==8 goto misc2
if %op%==7 goto dw_script
if %op%==6 goto shortcutmaker
if %op%==5 goto ff
if %op%==4 goto uac_verification
if %op%==3 goto remove_restore_folders
if %op%==2 goto ext_driver
if %op%==1 goto wg

goto misc
::======================================================================================

::======================================================================================
:misc2
cls

cls
echo ----------------------------------------------------------------
echo                      Choose Options [Extras Page(2)]                    
echo ----------------------------------------------------------------
echo.
echo  [1]. Install APKs
echo  [8]. Next Page
echo  [9]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,8,9,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==9 goto start
if %op%==8 goto misc2
if %op%==1 goto install_apks

goto misc2
::======================================================================================


::======================================================================================
:mass
cls
set ps=powershell.exe -NoProfile -ExecutionPolicy Unrestricted -Command "
title Activate Windows 10 (FROM INDIVIDUAL FOLDER)
%ps%irm https://raw.githubusercontent.com/8mpty/MAS/master/link.ps1 | iex"
goto start
::======================================================================================

::======================================================================================
:ctt
cls
:: Check if script is running in admin mode
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please rerun the script as an administrator.
    pause
    goto start
)
set ps=powershell.exe -NoProfile -ExecutionPolicy Unrestricted -Command "
title ChrisTitusTech Programs Installer (FROM INDIVIDUAL FOLDER)
%ps%irm https://raw.githubusercontent.com/8mpty/winutil/main/windev.ps1 | iex"
goto start
::======================================================================================

::======================================================================================
:wg
cls
echo ----------------------------------------------------------------
echo                         Download Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Download / Install Standalone Winget
echo  [2]. Download / Install Choco
echo  [3]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==3 goto misc
if %op%==2 goto choco
if %op%==1 goto winget
goto wg

:winget
cls
set ps=powershell.exe -NoProfile -ExecutionPolicy Unrestricted -Command "
title Standalone Winget Install (FROM INDIVIDUAL FOLDER)
echo PLEASE STAND BY....

%ps%Set-ExecutionPolicy Unrestricted -Scope CurrentUser"
ping 127.0.0.1 -n 2 -w 1000 > NUL

%ps%Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted"
ping 127.0.0.1 -n 2 -w 1000 > NUL

::echo Press Enter

%ps%Install-Script -Name winget-install -Force"
ping 127.0.0.1 -n 2 -w 1000 > NUL

%ps%winget-install.ps1"
ping 127.0.0.1 -n 2 -w 1000 > NUL
goto start

:choco
cls
TITLE DOWNLOADING / INSTALLING CHOCO
echo INSTALLING CHOCO IF NOT INSTALLED
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command " [System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

echo DONE
ping 127.0.0.1 -n 3 -w 1000 > NUL
goto start
::======================================================================================

::======================================================================================
:wal
cls

echo ----------------------------------------------------------------
echo                         Windows AutoLogon                       
echo ----------------------------------------------------------------

:: Check if windows auto login is enabled or disabled

set "RegKey=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
set "RegVal=AutoAdminLogon"

for /f "tokens=3" %%i in ('reg query "%RegKey%" /v "%RegVal%" 2^>nul') do (
    set "ValueData=%%i"
)

if defined ValueData (
    if "%ValueData%"=="1" (
        echo Status: Enabled
    ) else (
        echo Status: Disabled
    )
) else (
    echo Status: Disabled
)

ping 127.0.0.1 -n 2 -w 1000 > NUL
echo.
echo USING IS SCRIPT IS DANGEROUS, PLEASE USE CHRIS'S TITUS TECH OPTION INSTEAD, YOU HAVE BEEN WARNED
echo.
echo  [1]. Enable Windows AutoLogon
echo  [2]. Disable Windows AutoLogon
echo  [3]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==3 goto start
if %op%==2 goto dis_wal
if %op%==1 goto en_wal
goto wal

:en_wal
cls
echo Enabling Windows AutoLogon
echo.
echo Please Input Parameters
echo [*LOGIN DETAILS WILL BE IN PLAIN TEXT IN THE REGISTRY*]
echo.
set /P wal_user=Enter Windows Username: 

:: Credits https://correct-log.com/en/bat_input_mask_with_powershell/
set "pscmd=powershell.exe -Command " ^
$inputPass = read-host 'Enter Windows Password' -AsSecureString ; ^
$BSTR=[System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($inputPass); ^
[System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)""

for /f "tokens=*" %%a in ('%pscmd%') do set wal_pass=%%a

ping 127.0.0.1 -n 2 -w 1000 > NUL
cls
echo Please Wait
echo.

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /t REG_SZ /d %wal_user% /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d %wal_pass% /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f

ping 127.0.0.1 -n 4 -w 1000 > NUL
echo DONE!
set op=%~1

if "%op%"=="" (
    pause
) else (
    echo Y | pause
)
goto wal_start



:dis_wal
cls
echo Disabling Windows AutoLogon
echo.

REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUserName /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /f

REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 0 /f
echo.
ping 127.0.0.1 -n 4 -w 1000 > NUL
echo DONE!
goto wal


:ext_driver
cls
echo REMOVE "Drivers" FOLDER IF EXISTS
rmdir /S /Q %UserProfile%\Documents\Drivers
ping 127.0.0.1 -n 5 -w 1000 > NUL

cls
echo CREATING NEW FOLDER
mkdir %UserProfile%\Documents\Drivers
ping 127.0.0.1 -n 5 -w 1000 > NUL

cls
DISM.exe /Online /Export-Driver /Destination:%HOMEDRIVE%%HOMEPATH%\Documents\Drivers
echo PLEASE WAIT...
ping 127.0.0.1 -n 5 -w 1000 > NUL
echo.
echo EXTRACTED in %UserProfile%\Documents\Drivers
set op=%~1

if "%op%"=="" (
    pause
) else (
    echo Y | pause
)
goto start
::======================================================================================

::======================================================================================
:download_debloaters
cls
echo ----------------------------------------------------------------
echo                         Download Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Using CURL (default/builtin/slow sometimes)
echo  [2]. Using WGET (newer/takes up more space/needs to download)
echo  [3]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==3 goto start
if %op%==2 goto choco
if %op%==1 goto curl_in
goto download_debloaters

:choco
cls
TITLE USING WGET
echo INSTALLING CHOCO IF NOT INSTALLED
ping 127.0.0.1 -n 1 -w 1000 > NUL
echo.

WHERE choco > nul
IF %ERRORLEVEL% NEQ 0 (
	echo Choco is NOT installed. Downloading.....
	ping 127.0.0.1 -n 2 -w 1000 > NUL
	@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command " [System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

	echo DONE
	ping 127.0.0.1 -n 2 -w 1000 > NUL
	
) ELSE IF %ERRORLEVEL% NEQ 1 (
	echo Choco is installed. Skipping Downloading.....
	ping 127.0.0.1 -n 2 -w 1000 > NUL
)
goto wget



:wget
cls
WHERE wget > nul
IF %ERRORLEVEL% NEQ 0 (
	echo Wget is NOT installed. Downloading.....
	choco install wget
	ping 127.0.0.1 -n 2 -w 1000 > NUL
	
	echo DONE
	ping 127.0.0.1 -n 2 -w 1000 > NUL

) ELSE IF %ERRORLEVEL% NEQ 1 (
	echo Wget is installed. Skipping Downloading.....
	ping 127.0.0.1 -n 2 -w 1000 > NUL
)
goto wget_in

:wget_in
cls
TITLE USING WGET
echo Downloading builtbybel/bloatbox
ping 127.0.0.1 -n 2 -w 1000 > NUL
mkdir %UserProfile%\Downloads\bloatbox
wget -O %UserProfile%\Downloads\builtbybel.zip https://github.com/builtbybel/bloatbox/releases/download/0.20.0/bloatbox.zip & TITLE USING WGET

echo Downloading Sycnex/Windows10Debloater
ping 127.0.0.1 -n 3 -w 1000 > NUL
mkdir %UserProfile%\Downloads\Windows10Debloater
wget -O %UserProfile%\Downloads\Sycnex.zip https://github.com/Sycnex/Windows10Debloater/archive/refs/heads/master.zip
TITLE USING WGET

ping 127.0.0.1 -n 3 -w 1000 > NUL
goto extract_download_files

:curl_in
cls
TITLE USING CURL
echo Downloading builtbybel/bloatbox
ping 127.0.0.1 -n 3 -w 1000 > NUL
mkdir %UserProfile%\Downloads\bloatbox
curl -L -o %UserProfile%\Downloads\builtbybel.zip https://github.com/builtbybel/bloatbox/releases/download/0.20.0/bloatbox.zip

echo Downloading Sycnex/Windows10Debloater
ping 127.0.0.1 -n 3 -w 1000 > NUL
mkdir %UserProfile%\Downloads\Windows10Debloater
curl -L -o %UserProfile%\Downloads\Sycnex.zip https://github.com/Sycnex/Windows10Debloater/archive/refs/heads/master.zip

ping 127.0.0.1 -n 3 -w 1000 > NUL
goto extract_download_files

:extract_download_files
cls
echo EXTRACTING....

WHERE tar > NUL
IF %ERRORLEVEL% NEQ 0 (
	powershell -command "Expand-Archive -Force '%UserProfile%\Downloads\builtbybel.zip' '%UserProfile%\Downloads\bloatbox'
	powershell -command "Expand-Archive -Force '%UserProfile%\Downloads\Sycnex.zip' '%UserProfile%\Downloads\Windows10Debloater'
) ELSE IF %ERRORLEVEL% NEQ 1 (
	tar -xf %UserProfile%\Downloads\builtbybel.zip -C %UserProfile%\Downloads\bloatbox
	tar -xf %UserProfile%\Downloads\Sycnex.zip -C %UserProfile%\Downloads\Windows10Debloater
)

ping 127.0.0.1 -n 3 -w 1000 > NUL
del /f %UserProfile%\Downloads\builtbybel.zip
del /f %UserProfile%\Downloads\Sycnex.zip
echo.
echo Downloaded files to %UserProfile%\Downloads
echo.
echo Please run these scripts yourselves at your own risk!!
set op=%~1

if "%op%"=="" (
    pause
) else (
    echo Y | pause
)
goto start
::======================================================================================

::======================================================================================
:remove_restore_folders
title Remove or Restore Folders
mode 67, 30
cls
echo ----------------------------------------------------------------
echo                          Choose Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Remove Folders
echo  [2]. Restore Folders
echo  [3]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==3 goto misc
if %op%==2 goto RESTORE_FOLDERS
if %op%==1 goto Architecture
goto remove_restore_folders
::======================================================================================

::======================================================================================
:Architecture
title Architecture Type
cls
echo ----------------------------------------------------------------
echo                          Choose Type                          
echo ----------------------------------------------------------------
echo.

if exist "%SYSTEMDRIVE%\Program Files (x86)\" (
   echo Your Type is 64-Bit
) else (
   echo Your Type is 32-Bit/x86
)

echo.
echo  [1]. 64-bit Architecture
echo  [2]. 32-bit/x86 Architecture
echo  [0]. Go Back
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,0]: 
) else (
    shift
)

if %op%==0 goto remove_restore_folders
if %op%==2 goto 32bit
if %op%==1 goto 64bit
goto Architecture
::======================================================================================

::======================================================================================
:32bit
title 32-Bit
cls
echo ----------------------------------------------------------------
echo                          Choose Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Remove Desktop Folder
echo  [2]. Remove Documents Folder
echo  [3]. Remove Downloads Folder
echo  [4]. Remove Music Folder
echo  [5]. Remove Pictures Folder
echo  [6]. Remove Videos Folder
echo  [7]. Remove ALL Folders
echo  [0]. Go Back
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,4,5,6,7,0]: 
) else (
    shift
)

if %op%==0 goto Architecture
if %op%==7 goto 32_ALL
if %op%==6 goto 32_Videos
if %op%==5 goto 32_Pictures
if %op%==4 goto 32_Music
if %op%==3 goto 32_Downloads
if %op%==2 goto 32_Documents
if %op%==1 goto 32_Desktop
goto 32bit


:32_ALL
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
set delay=2
cls
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo Removing All Folders
echo Please Wait....
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo.

echo Removing Desktop Folder
REG DELETE "%def%\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Removing Documents Folder
REG DELETE "%def%\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG DELETE "%def%\{d3162b92-9365-467a-956b-92703aca08af}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Removing Downloads Folder
REG DELETE "%def%\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG DELETE "%def%\{088e3905-0323-4b02-9826-5d99428e115f}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Removing Music Folder
REG DELETE "%def%\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG DELETE "%def%\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Removing Pictures Folder
REG DELETE "%def%\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG DELETE "%def%\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Removing Videos Folder
REG DELETE "%def%\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG DELETE "%def%\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo.
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Desktop
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Removing Desktop Folder
REG DELETE "%def%\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Documents
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Removing Documents Folder
REG DELETE "%def%\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG DELETE "%def%\{d3162b92-9365-467a-956b-92703aca08af}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Downloads
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Removing Downloads Folder
REG DELETE "%def%\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG DELETE "%def%\{088e3905-0323-4b02-9826-5d99428e115f}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Music
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Removing Music Folder
REG DELETE "%def%\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG DELETE "%def%\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Pictures
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Removing Pictures Folder
REG DELETE "%def%\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG DELETE "%def%"\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Videos
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Removing Videos Folder
REG DELETE "%def%\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG DELETE "%def%\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start
::======================================================================================

::======================================================================================
:64bit
title 64-Bit
cls
echo ----------------------------------------------------------------
echo                          Choose Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Remove Desktop Folder
echo  [2]. Remove Documents Folder
echo  [3]. Remove Downloads Folder
echo  [4]. Remove Music Folder
echo  [5]. Remove Pictures Folder
echo  [6]. Remove Videos Folder
echo  [7]. Remove ALL Folders
echo  [0]. Go Back
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,4,5,6,7,0]: 
) else (
    shift
)

if %op%==0 goto Architecture
if %op%==7 goto 64_ALL
if %op%==6 goto 64_Videos
if %op%==5 goto 64_Pictures
if %op%==4 goto 64_Music
if %op%==3 goto 64_Downloads
if %op%==2 goto 64_Documents
if %op%==1 goto 64_Desktop
goto 64bit


:64_ALL
cls
set delay=2
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo Removing All Folders
echo Please Wait....
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo.

echo Removing Desktop Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Removing Documents Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Removing Downloads Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Removing Music Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Removing Pictures Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Removing Videos Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo.
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Desktop
set delay=2
cls
echo Removing Desktop Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Documents
set delay=2
cls
echo Removing Documents Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Downloads
set delay=2
cls
echo Removing Downloads Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Music
set delay=2
cls
echo Removing Music Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Pictures
set delay=2
cls
echo Removing Pictures Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Videos
set delay=2
cls
echo Removing Videos Folder
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG DELETE "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start
::======================================================================================

::======================================================================================
:RESTORE_FOLDERS
title Architecture Type
cls
echo ----------------------------------------------------------------
echo                          Choose Type                          
echo ----------------------------------------------------------------
echo.

if exist "%SYSTEMDRIVE%\Program Files (x86)\" (
   echo Your Type is 64-Bit
) else (
   echo Your Type is 32-Bit/x86
)

echo.
echo  [1]. 64-bit Architecture
echo  [2]. 32-bit/x86 Architecture
echo  [0]. Go Back
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,0]: 
) else (
    shift
)

if %op%==0 goto remove_restore_folders
if %op%==2 goto 32bit_RES
if %op%==1 goto 64bit_RES
goto RESTORE_FOLDERS


:32bit_RES
title 32-Bit
cls
echo ----------------------------------------------------------------
echo                          Choose Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Restore Desktop Folder
echo  [2]. Restore Documents Folder
echo  [3]. Restore Downloads Folder
echo  [4]. Restore Music Folder
echo  [5]. Restore Pictures Folder
echo  [6]. Restore Videos Folder
echo  [7]. Restore ALL Folders
echo  [0]. Go Back
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,4,5,6,7,0]: 
) else (
    shift
)

if %op%==0 goto RESTORE_FOLDERS
if %op%==7 goto 32_ALL_RES
if %op%==6 goto 32_Videos_RES
if %op%==5 goto 32_Pictures_RES
if %op%==4 goto 32_Music_RES
if %op%==3 goto 32_Downloads_RES
if %op%==2 goto 32_Documents_RES
if %op%==1 goto 32_Desktop_RES
goto 32bit_RES

::======================================================================================

::======================================================================================
:32_ALL_RES
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
set delay=2
cls
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo Restoring All Folders
echo Please Wait....
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo.

echo Restoring Desktop Folder
REG ADD "%def%\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Restoring Documents Folder
REG ADD "%def%\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG ADD "%def%\{d3162b92-9365-467a-956b-92703aca08af}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Restoring Downloads Folder
REG ADD "%def%\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG ADD "%def%\{088e3905-0323-4b02-9826-5d99428e115f}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Restoring Music Folder
REG ADD "%def%\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG ADD "%def%\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Restoring Pictures Folder
REG ADD "%def%\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG ADD "%def%\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo Restoring Videos Folder
REG ADD "%def%\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG ADD "%def%\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo.
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Desktop_RES
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Restoring Desktop Folder
REG ADD "%def%\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Documents_RES
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Restoring Documents Folder
REG ADD "%def%\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG ADD "%def%\{d3162b92-9365-467a-956b-92703aca08af}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Downloads_RES
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Restoring Downloads Folder
REG ADD "%def%\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG ADD "%def%\{088e3905-0323-4b02-9826-5d99428e115f}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Music_RES
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Restoring Music Folder
REG ADD "%def%\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG ADD "%def%\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Pictures_RES
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Restoring Pictures Folder
REG ADD "%def%\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG ADD "%def%\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:32_Videos_RES
set delay=2
set def=HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace
echo Restoring Videos Folder
REG ADD "%def%\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG ADD "%def%\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start
::======================================================================================


::======================================================================================
:64bit_RES
title 64-Bit
cls
echo ----------------------------------------------------------------
echo                          Choose Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Restore Desktop Folder
echo  [2]. Restore Documents Folder
echo  [3]. Restore Downloads Folder
echo  [4]. Restore Music Folder
echo  [5]. Restore Pictures Folder
echo  [6]. Restore Videos Folder
echo  [7]. Restore ALL Folders
echo  [0]. Go Back
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,4,5,6,7,0]: 
) else (
    shift
)

if %op%==0 goto RESTORE_FOLDERS
if %op%==7 goto 64_ALL_RES
if %op%==6 goto 64_Videos_RES
if %op%==5 goto 64_Pictures_RES
if %op%==4 goto 64_Music_RES
if %op%==3 goto 64_Downloads_RES
if %op%==2 goto 64_Documents_RES
if %op%==1 goto 64_Desktop_RES
goto 64bit_RES

::======================================================================================

::======================================================================================
:64_ALL_RES
cls
set delay=2
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo Restoring All Folders
echo Please Wait....
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo.

echo Restoring Desktop Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Restoring Documents Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Restoring Downloads Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Restoring Music Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Restoring Pictures Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL

echo Restoring Videos Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
ping 127.0.0.1 -n %delay% -w 1000 > NUL
echo.
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start
::======================================================================================

::======================================================================================
:64_Desktop_RES
set delay=2
cls
echo Restoring Desktop Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{B4BFCC3A-DB2C-424C-B029-7FE99A87C641}" /f
echo Remove Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Documents_RES
set delay=2
cls
echo Restoring Documents Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A8CDFF1C-4878-43be-B5FD-F8091C1C60D0}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{d3162b92-9365-467a-956b-92703aca08af}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Downloads_RES
set delay=2
cls
echo Restoring Downloads Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{374DE290-123F-4565-9164-39C4925E467B}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{088e3905-0323-4b02-9826-5d99428e115f}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Music_RES
set delay=2
cls
echo Restoring Music Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{1CF1260C-4DD0-4ebb-811F-33C572699FDE}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3dfdf296-dbec-4fb4-81d1-6a3438bcf4de}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Pictures_RES
set delay=2
cls
echo Restoring Pictures Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{3ADD1653-EB32-4cb0-BBD7-DFA0ABB5ACCA}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{24ad3ad4-a569-4530-98e1-ab02f9417aa8}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start

:64_Videos_RES
set delay=2
cls
echo Restoring Videos Folder
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{A0953C92-50DC-43bf-BE83-3742FED03C9C}" /f
REG ADD "HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Explorer\MyComputer\NameSpace\{f86fa3ab-70d2-4fc7-9c99-fcbf05467f3a}" /f
echo Restoring Successfull!
ping 127.0.0.1 -n %delay% -w 1000 > NUL
goto start
::======================================================================================

::======================================================================================
:uac_verification
cls
:: Check if script is running in admin mode
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Please rerun the script as an administrator.
    pause
    goto start
)
echo ----------------------------------------------------------------
echo                         Enable Admin UAC                       
echo ----------------------------------------------------------------

echo.
echo  [1]. Enable Admin Verifications in UAC
echo  [2]. Disable + Enhanced (More Secure)
echo  [3]. Disable (Less Secure) (Windows Default)*
echo  [4]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice on your keyboard [1,2,3,4,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==4 goto misc
if %op%==3 goto dis_uac_d
if %op%==2 goto dis_uac_e
if %op%==1 goto en_uac
goto uac_verification

:en_uac
cls
echo Enabling
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 1
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo DONE!!
goto start

:dis_uac_e
cls
echo Disabling (Setting with Improvements)
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 2
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo DONE!!
goto start

:dis_uac_d
cls
echo Disabling
reg add "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System" /f /v "ConsentPromptBehaviorAdmin" /t REG_DWORD /d 5
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo DONE!!
goto start
::======================================================================================

::======================================================================================
:ff
cls
echo ----------------------------------------------------------------
echo                      Backup Firefox Settings                    
echo ---------------------------------------------------------------- 
echo.
echo  [1]. Backup settings from Firefox Folder
echo  [2]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice in your keyboard [1,2,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==2 goto misc
if %op%==1 goto backup
goto ff


:backup
cls
SET FF=%USERPROFILE%\AppData\Roaming\Mozilla\Firefox\Profiles
setlocal enabledelayedexpansion
set /a count=0
cd /D %FF%
echo ----------------------------------------------------------------
echo                     Available Firefox Folders                     
echo ---------------------------------------------------------------- 
echo.
for /d %%d in (*) do (
  set "folder=%%d"
  if "!folder:*.dev-edition-default=!" neq "!folder!" (
    set /a count+=1
    set "folder[!count!]=%%d"
    echo  [!count!] %%d ^(Firefox Developer Edition^)
  ) else if "!folder:*.default-release=!" neq "!folder!" (
    set /a count+=1
    set "folder[!count!]=%%d"
    echo  [!count!] %%d ^(Firefox Edition^)
  ) else if "!folder:*.default=!" neq "!folder!" (
    echo  [^^!] %%d ^(NOT USED^)
  )
)
echo.
echo  [0] Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter the Firefox folder number you want to backup from: 
) else (
    shift
)

if %op%==0 goto end
if defined folder[%op%] (
    cd "!folder[%op%]!"
    echo You have changed to the selected directory: "!folder[%op%]!"
) else (
    goto backup
)

cls
title %cd%
echo SAVING FILES...
mkdir saved_data
cls
echo SAVING FILES...
xcopy /y "%CD%\places.sqlite" "%CD%\saved_data"
xcopy /y "%CD%\favicons.sqlite" "%CD%\saved_data"
xcopy /y "%CD%\key4.db" "%CD%\saved_data"
xcopy /y "%CD%\logins.json" "%CD%\saved_data"
xcopy /y "%CD%\permissions.sqlite" "%CD%\saved_data"
xcopy /y "%CD%\search.json.mozlz4" "%CD%\saved_data"
xcopy /y "%CD%\persdict.dat" "%CD%\saved_data"
xcopy /y "%CD%\formhistory.sqlite" "%CD%\saved_data"
xcopy /y "%CD%\cookies.sqlite" "%CD%\saved_data"
xcopy /y "%CD%\cert9.db" "%CD%\saved_data"
xcopy /y "%CD%\handlers.json" "%CD%\saved_data"
xcopy /y "%CD%\user.js" "%CD%\saved_data"
ping 127.0.0.1 -n 2 -w 1000 > NUL
echo DONE!!
echo FILES SAVED TO %CD%\saved_data !!
%SystemRoot%\explorer.exe "%CD%\saved_data"
ping 127.0.0.1 -n 3 -w 1000 > NUL
goto start

::======================================================================================

::======================================================================================
:shortcutmaker
cls
echo Creating Shortcut....
ping 127.0.0.1 -n 3 -w 1000 > NUL
set "ShortcutName=PostScript"
set "ShortcutTarget=powershell.exe"
set "ShortcutArguments=-ExecutionPolicy RemoteSigned -Command ""Start-Process powershell.exe -WindowStyle Hidden -Verb RunAs -ArgumentList 'irm https://raw.githubusercontent.com/8mpty/Windows_Post_Install_BATCH/main/psfile/empty.ps1 | iex '"""
set "ShortcutLocation=%userprofile%\Desktop"

echo Set oWS = WScript.CreateObject("WScript.Shell") > %temp%\CreateShortcut.vbs
echo sLinkFile = "%ShortcutLocation%\%ShortcutName%.lnk" >> %temp%\CreateShortcut.vbs
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %temp%\CreateShortcut.vbs
echo oLink.TargetPath = "%ShortcutTarget%" >> %temp%\CreateShortcut.vbs
echo oLink.Arguments = "%ShortcutArguments%" >> %temp%\CreateShortcut.vbs
echo oLink.IconLocation = "%SystemRoot%\System32\imageres.dll,56" >> %temp%\CreateShortcut.vbs
echo oLink.Hotkey = "SHIFT+ALT+CTRL+F1" >> %temp%\CreateShortcut.vbs
echo oLink.Save >> %temp%\CreateShortcut.vbs

cscript /nologo %temp%\CreateShortcut.vbs
del %temp%\CreateShortcut.vbs
echo Done!!
ping 127.0.0.1 -n 3 -w 1000 > NUL
goto start
::======================================================================================

::======================================================================================
:dw_script
cls
echo ----------------------------------------------------------------
echo                         Download Options                          
echo ----------------------------------------------------------------
echo.
echo  [1]. Using CURL (default/builtin/slow sometimes)
echo  [2]. Using WGET (newer/takes up more space/needs to download)
echo  [3]. Go Back
echo  [0]. Exit
echo.

set op=%~1

if "%op%"=="" ( 
    set /P op=Enter choice in your keyboard [1,2,3,0]: 
) else (
    shift
)

if %op%==0 goto end
if %op%==3 goto misc
if %op%==2 goto choco
if %op%==1 goto curl_in
goto dw_script

:choco
cls
TITLE USING WGET
echo INSTALLING CHOCO IF NOT INSTALLED
ping 127.0.0.1 -n 1 -w 1000 > NUL
echo.

WHERE choco > nul
IF %ERRORLEVEL% NEQ 0 (
	echo Choco is NOT installed. Downloading.....
	ping 127.0.0.1 -n 2 -w 1000 > NUL
	@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command " [System.Net.ServicePointManager]::SecurityProtocol = 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

	echo DONE
	ping 127.0.0.1 -n 2 -w 1000 > NUL
	
) ELSE IF %ERRORLEVEL% NEQ 1 (
	echo Choco is installed. Skipping Downloading.....
	ping 127.0.0.1 -n 2 -w 1000 > NUL
)
goto wget



:wget
cls
WHERE wget > nul
IF %ERRORLEVEL% NEQ 0 (
	echo Wget is NOT installed. Downloading.....
	choco install wget
	ping 127.0.0.1 -n 2 -w 1000 > NUL
	
	echo DONE
	ping 127.0.0.1 -n 2 -w 1000 > NUL

) ELSE IF %ERRORLEVEL% NEQ 1 (
	echo Wget is installed. Skipping Downloading.....
	ping 127.0.0.1 -n 2 -w 1000 > NUL
)
goto wget_in

:wget_in
cls
TITLE USING WGET
echo Downloading 8mpty/Windows_Post_Install_Batch
ping 127.0.0.1 -n 2 -w 1000 > NUL
mkdir %UserProfile%\Desktop\Windows_Post_Install_Batch
wget -O %UserProfile%\Desktop\8mpty_script.zip https://github.com/8mpty/Windows_Post_Install_BATCH/archive/refs/heads/main.zip & TITLE USING WGET

ping 127.0.0.1 -n 3 -w 1000 > NUL
goto extract_download_files

:curl_in
cls
TITLE USING CURL
echo Downloading 8mpty/Windows_Post_Install_Batch
ping 127.0.0.1 -n 3 -w 1000 > NUL
mkdir %UserProfile%\Desktop\Windows_Post_Install_Batch
curl -L -o %UserProfile%\Desktop\8mpty_script.zip https://github.com/8mpty/Windows_Post_Install_BATCH/archive/refs/heads/main.zip & TITLE USING CURL

ping 127.0.0.1 -n 3 -w 1000 > NUL
goto extract_download_files

:extract_download_files
cls
echo EXTRACTING....

WHERE tar > NUL
IF %ERRORLEVEL% NEQ 0 (
	powershell -command "Expand-Archive -Force '%UserProfile%\Desktop\8mpty_script.zip' '%UserProfile%\Desktop\Windows_Post_Install_Batch'
) ELSE IF %ERRORLEVEL% NEQ 1 (
	tar -xf %UserProfile%\Desktop\8mpty_script.zip -C %UserProfile%\Desktop\Windows_Post_Install_Batch
)

ping 127.0.0.1 -n 3 -w 1000 > NUL
del /f %UserProfile%\Desktop\8mpty_script.zip
echo.
echo Downloaded files to %UserProfile%\Desktop
set op=%~1

if "%op%"=="" (
    pause
) else (
    echo Y | pause
)
goto start
::======================================================================================


::======================================================================================
:install_apks
cls
:: Check if ADB is in the system path
adb version > nul 2>&1
if %errorlevel% neq 0 (
    echo ADB not found in the system path. Make sure ADB is installed and added to the path.
    pause
    exit /b
)

:: Check if files were dragged onto the batch file
if "%~1" == "" (
    goto OPENED
) else (
    for %%A in (%*) do (
        set "apkname=%%~nxA"  :: Extract only the filename
        set "file=%%~A" :: Extract package name
        set "ext=!file:~-4!" :: Extract extension

        :: Check if the file has a .apk extension
        if /i !ext! == .apk (
            echo.
            echo Installing !apkname!
            adb install -r "!file!"
        )
    )
    goto apk_finish
)


:OPENED
cls
echo For dragging APKs to work, script must NOT be running in Admin mode
echo If in admin mode, user will have the manually copy the path of the APK/s with spacing after each apk
echo. 
set /p "files=Drag APK files here and press Enter: "
if "%files%" == "" (
    echo No files were dragged. Exiting...
    pause
    exit /b
) else (
    set "files=%files:"=%"
    set "files=%files% "  REM Append a space at the end
    goto LOOPOPENED
)

:LOOPOPENED
:: Loop through the dragged files
for %%A in (%files%) do (
    set "apkname=%%~nxA"  :: Extract only the filename
    set "file=%%~A" :: Extract package name
    set "ext=!file:~-4!" :: Extract extension

    :: Check if the file has a .apk extension
    if /i !ext! == .apk (
        echo.
        echo Installing !apkname!
        adb install -r "!file!"
    )
)


:apk_finish
echo.
echo ALL INSTALLATION FINISHED
pause
::======================================================================================


::======================================================================================
:end
cls
exit /b
::======================================================================================
