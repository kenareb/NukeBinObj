@echo off
REM NukeBin Batch Wrapper
REM This file allows running NukeBin without specifying the full path

if "%~1"=="" (
    echo Usage: NukeBin ^<path^>
    echo Example: NukeBin C:\MyProject
    exit /b 1
)

REM Try to find NukeBin.exe in the same directory as this batch file
set "NUKEBIN_PATH=%~dp0NukeBin.exe"

if exist "%NUKEBIN_PATH%" (
    "%NUKEBIN_PATH%" %*
) else (
    echo Error: NukeBin.exe not found in the same directory as this batch file.
    echo Please ensure NukeBin.exe is in the same directory as NukeBin.bat
    exit /b 1
)
