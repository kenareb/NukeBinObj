@echo off
echo NukeBin Setup
echo =============
echo.
echo This will install NukeBin to your user directory.
echo.
pause

powershell -ExecutionPolicy Bypass -File "%~dp0install.ps1" -AddToPath

echo.
echo Setup completed!
echo You can now use 'NukeBin' from anywhere in the command line.
echo.
pause
