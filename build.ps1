# NukeBin Build Script
# This script builds the self-contained executable for distribution

Write-Host "NukeBin Build Script" -ForegroundColor Green
Write-Host "===================" -ForegroundColor Green
Write-Host ""

# Clean previous builds
Write-Host "Cleaning previous builds..." -ForegroundColor Cyan
if (Test-Path "bin") {
    Remove-Item -Recurse -Force "bin"
}
if (Test-Path "obj") {
    Remove-Item -Recurse -Force "obj"
}

# Restore packages
Write-Host "Restoring packages..." -ForegroundColor Cyan
dotnet restore

# Build the project
Write-Host "Building project..." -ForegroundColor Cyan
dotnet build --configuration Release

# Publish self-contained executable
Write-Host "Publishing self-contained executable..." -ForegroundColor Cyan
dotnet publish --configuration Release --runtime win-x64 --self-contained true --output ./publish

# Copy the executable to root directory for easy access
Write-Host "Copying executable to root directory..." -ForegroundColor Cyan
Copy-Item "./publish/NukeBin.exe" -Destination "./NukeBin.exe" -Force

Write-Host ""
Write-Host "Build completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Files created:" -ForegroundColor Yellow
Write-Host "  ./NukeBin.exe - Self-contained executable" -ForegroundColor White
Write-Host "  ./publish/ - Full publish directory" -ForegroundColor White
Write-Host ""
Write-Host "To install NukeBin, run:" -ForegroundColor Yellow
Write-Host "  .\install.ps1" -ForegroundColor White
Write-Host "  .\install.ps1 -AddToPath" -ForegroundColor White
Write-Host ""
