@echo off
rem CenterSelf
mode 67, 30
CLS
 ECHO.
 ECHO =============================
 ECHO Running Admin shell
 ECHO =============================

:init
 setlocal DisableDelayedExpansion
 set cmdInvoke=1
 set winSysFolder=System32
 set "batchPath=%~dpnx0"
 rem this works also from cmd shell, other than %~0
 for %%k in (%0) do set batchName=%%~nk
 set "vbsGetPrivileges=%temp%\OEgetPriv_%batchName%.vbs"
 setlocal EnableDelayedExpansion

:checkPrivileges
  NET FILE 1>NUL 2>NUL
  if '%errorlevel%' == '0' ( goto gotPrivileges ) else ( goto getPrivileges )

:getPrivileges
  if '%1'=='ELEV' (echo ELEV & shift /1 & goto gotPrivileges)
  ECHO.
  ECHO **************************************
  ECHO Invoking UAC for Privilege Escalation
  ECHO **************************************

  ECHO Set UAC = CreateObject^("Shell.Application"^) > "%vbsGetPrivileges%"
  ECHO args = "ELEV " >> "%vbsGetPrivileges%"
  ECHO For Each strArg in WScript.Arguments >> "%vbsGetPrivileges%"
  ECHO args = args ^& strArg ^& " "  >> "%vbsGetPrivileges%"
  ECHO Next >> "%vbsGetPrivileges%"
  
  if '%cmdInvoke%'=='1' goto InvokeCmd 

  ECHO UAC.ShellExecute "!batchPath!", args, "", "runas", 1 >> "%vbsGetPrivileges%"
  goto ExecElevation

:InvokeCmd
  ECHO args = "/c """ + "!batchPath!" + """ " + args >> "%vbsGetPrivileges%"
  ECHO UAC.ShellExecute "%SystemRoot%\%winSysFolder%\cmd.exe", args, "", "runas", 1 >> "%vbsGetPrivileges%"

:ExecElevation
 "%SystemRoot%\%winSysFolder%\WScript.exe" "%vbsGetPrivileges%" %*
 exit /B

:gotPrivileges
 setlocal & cd /d %~dp0
 if '%1'=='ELEV' (del "%vbsGetPrivileges%" 1>nul 2>nul  &  shift /1)

 ::::::::::::::::::::::::::::
 ::START
 ::::::::::::::::::::::::::::
 REM Run shell as admin (example) - put here code as you like

:start
cls
echo ----------------------------------------------------------------
echo                         Download Options                          
echo ----------------------------------------------------------------
echo.
echo 1. Download / Install Standalone Winget
echo 2. Download / Install Choco
echo 0. Exit
echo.


echo Enter choice on your keyboard [1,2,0]: 
choice /C:120 /N
set _erl=%errorlevel%


if %_erl%==0 goto end
if %_erl%==2 goto choco
if %_erl%==1 goto winget

goto end

:winget
cls
TITLE DOWNLOADING & INSTALLING WINGET
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

:end
exit /b