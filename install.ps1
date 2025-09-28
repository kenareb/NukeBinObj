# NukeBin Installer Script
# This script installs NukeBin to a local directory and optionally adds it to PATH

param(
    [string]$InstallPath = "$env:USERPROFILE\Tools\NukeBin",
    [switch]$AddToPath = $false,
    [switch]$Force = $false
)

Write-Host "NukeBin Installer" -ForegroundColor Green
Write-Host "================" -ForegroundColor Green
Write-Host ""

# Check if running as administrator (needed for PATH modification)
if ($AddToPath -and -NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Warning "To add NukeBin to PATH, please run this script as Administrator"
    Write-Host "Alternatively, you can manually add '$InstallPath' to your PATH environment variable"
    Write-Host ""
}

# Create installation directory
if (Test-Path $InstallPath) {
    if ($Force) {
        Write-Host "Removing existing installation..." -ForegroundColor Yellow
        Remove-Item -Recurse -Force $InstallPath
    } else {
        Write-Warning "Installation directory already exists: $InstallPath"
        Write-Host "Use -Force to overwrite existing installation"
        exit 1
    }
}

Write-Host "Creating installation directory: $InstallPath" -ForegroundColor Cyan
New-Item -ItemType Directory -Path $InstallPath -Force | Out-Null

# Check if NukeBin.exe exists in current directory
$SourceExe = "NukeBin.exe"
if (-not (Test-Path $SourceExe)) {
    Write-Error "NukeBin.exe not found in current directory. Please run this script from the directory containing NukeBin.exe"
    exit 1
}

# Copy executable
Write-Host "Installing NukeBin..." -ForegroundColor Cyan
Copy-Item $SourceExe -Destination $InstallPath -Force

# Create a batch file wrapper for easier usage
$BatchContent = @"
@echo off
"$InstallPath\NukeBin.exe" %*
"@
$BatchContent | Out-File -FilePath "$InstallPath\NukeBin.bat" -Encoding ASCII

# Add to PATH if requested
if ($AddToPath) {
    Write-Host "Adding NukeBin to PATH..." -ForegroundColor Cyan
    
    $CurrentPath = [Environment]::GetEnvironmentVariable("PATH", "User")
    if ($CurrentPath -notlike "*$InstallPath*") {
        $NewPath = $CurrentPath + ";" + $InstallPath
        [Environment]::SetEnvironmentVariable("PATH", $NewPath, "User")
        Write-Host "NukeBin added to PATH. You may need to restart your terminal for changes to take effect." -ForegroundColor Green
    } else {
        Write-Host "NukeBin is already in PATH." -ForegroundColor Yellow
    }
}

Write-Host ""
Write-Host "Installation completed successfully!" -ForegroundColor Green
Write-Host ""
Write-Host "Usage:" -ForegroundColor Yellow
Write-Host "  $InstallPath\NukeBin.exe <path>" -ForegroundColor White
Write-Host "  $InstallPath\NukeBin.bat <path>" -ForegroundColor White
if ($AddToPath) {
    Write-Host "  NukeBin <path>" -ForegroundColor White
}
Write-Host ""
Write-Host "Examples:" -ForegroundColor Yellow
Write-Host "  NukeBin C:\MyProject" -ForegroundColor White
Write-Host "  NukeBin ." -ForegroundColor White
Write-Host ""
