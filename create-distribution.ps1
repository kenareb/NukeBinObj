# Create Distribution Package Script
# This script creates a distribution package for easy team distribution

param(
    [string]$OutputDir = "./dist",
    [string]$Version = "1.0.0"
)

Write-Host "NukeBin Distribution Creator" -ForegroundColor Green
Write-Host "=============================" -ForegroundColor Green
Write-Host ""

# Clean and create output directory
if (Test-Path $OutputDir) {
    Remove-Item -Recurse -Force $OutputDir
}
New-Item -ItemType Directory -Path $OutputDir -Force | Out-Null

# Build the project
Write-Host "Building project..." -ForegroundColor Cyan
.\build.ps1

# Create distribution directory structure
$DistDir = "$OutputDir/NukeBin-v$Version"
New-Item -ItemType Directory -Path $DistDir -Force | Out-Null

# Copy files
Write-Host "Creating distribution package..." -ForegroundColor Cyan
Copy-Item "NukeBin.exe" -Destination "$DistDir/" -Force
Copy-Item "NukeBin.bat" -Destination "$DistDir/" -Force
Copy-Item "install.ps1" -Destination "$DistDir/" -Force
Copy-Item "README.md" -Destination "$DistDir/" -Force

# Create a simple setup script
$SetupContent = @"
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
"@
$SetupContent | Out-File -FilePath "$DistDir/setup.bat" -Encoding ASCII

# Create zip package
Write-Host "Creating zip package..." -ForegroundColor Cyan
$ZipPath = "$OutputDir/NukeBin-v$Version.zip"
Compress-Archive -Path "$DistDir/*" -DestinationPath $ZipPath -Force

Write-Host ""
Write-Host "Distribution package created successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Files created:" -ForegroundColor Yellow
Write-Host "  $DistDir/ - Distribution directory" -ForegroundColor White
Write-Host "  $ZipPath - Zip package for distribution" -ForegroundColor White
Write-Host ""
Write-Host "To distribute to your team:" -ForegroundColor Yellow
Write-Host "  1. Share the zip file with your team" -ForegroundColor White
Write-Host "  2. Team members extract and run setup.bat" -ForegroundColor White
Write-Host "  3. Or manually run install.ps1 -AddToPath" -ForegroundColor White
Write-Host ""
