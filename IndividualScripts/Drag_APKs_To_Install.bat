@echo off
setlocal enabledelayedexpansion

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
    goto END
)


:OPENED
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


:END
echo.
echo ALL INSTALLATION FINISHED
pause
