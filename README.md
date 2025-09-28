# NukeBin

A simple .NET console utility to recursively delete `bin` and `obj` folders from your projects.

## Features

- 🗂️ Recursively searches through directories
- 🎯 Targets only `bin` and `obj` folders (case-insensitive)
- 🛡️ Safe operation with error handling
- 📦 Self-contained executable (no .NET runtime required)
- ⚡ Fast and lightweight

## Quick Start

### Option 1: Direct Download (Recommended)

1. Download the latest release from the [Releases page](https://github.com/kenareb/NukeBinObj/releases)
2. Extract the executable
3. Run: `NukeBin.exe <path>`

### Option 2: PowerShell Installer

1. Download `NukeBin.exe` and `install.ps1`
2. Run PowerShell as Administrator
3. Execute: `.\install.ps1 -AddToPath`

This will install NukeBin to `%USERPROFILE%\Tools\NukeBin` and add it to your PATH.

### Option 3: Build from Source

1. Clone this repository
2. Run: `.\build.ps1`
3. Run: `.\install.ps1 -AddToPath`

## Usage

```bash
NukeBin <path>
```

### Examples

```bash
# Clean current directory
NukeBin .

# Clean specific project
NukeBin C:\MyProject

# Clean solution directory
NukeBin C:\MySolution
```

## Installation Options

### PowerShell Installer Parameters

```powershell
.\install.ps1 [options]

Options:
  -InstallPath <path>    Installation directory (default: %USERPROFILE%\Tools\NukeBin)
  -AddToPath            Add NukeBin to system PATH
  -Force                Overwrite existing installation
```

### Installation Examples

```powershell
# Basic installation
.\install.ps1

# Install to custom location
.\install.ps1 -InstallPath "C:\Tools\NukeBin"

# Install and add to PATH
.\install.ps1 -AddToPath

# Force reinstall
.\install.ps1 -Force -AddToPath
```

## Building from Source

### Prerequisites

- .NET 8.0 SDK
- PowerShell (for build scripts)

### Build Steps

1. **Clone the repository**

   ```bash
   git clone https://github.com/yourusername/NukeBin.git
   cd NukeBin
   ```

2. **Build the project**

   ```bash
   .\build.ps1
   ```

3. **Install locally**

   ```bash
   .\install.ps1 -AddToPath
   ```

### Manual Build

```bash
# Restore packages
dotnet restore

# Build
dotnet build --configuration Release

# Publish self-contained executable
dotnet publish --configuration Release --runtime win-x64 --self-contained true --output ./publish
```

## Distribution Methods

### 1. Self-Contained Executable

- Single `.exe` file with no dependencies
- Works on any Windows machine
- Larger file size (~50MB)

### 2. Framework-Dependent

- Requires .NET 8.0 Runtime
- Smaller file size (~150KB)
- Better for development environments

### 3. GitHub Releases

- Automated builds via GitHub Actions
- Multiple platform support
- Versioned releases

## Team Distribution

### Method 1: Shared Network Drive

1. Build the executable: `.\build.ps1`
2. Copy `NukeBin.exe` to shared network location
3. Team members can run directly or copy to local machine

### Method 2: Internal Package Manager

- Use Chocolatey, NuGet, or similar package manager
- Create internal package repository
- Team members install via package manager

### Method 3: GitHub Releases (After First Release)

1. Tag a release: `git tag v1.0.0`
2. Push tags: `git push --tags`
3. GitHub Actions will automatically build and create release
4. Team members download from [releases page](https://github.com/kenareb/NukeBinObj/releases)

## Safety Features

- ✅ Only deletes folders named exactly `bin` or `obj`
- ✅ Case-insensitive matching
- ✅ Recursive directory traversal
- ✅ Error handling for permission issues
- ✅ Progress feedback during operation
- ✅ Confirmation of deleted folders

## Troubleshooting

### Permission Denie

- Run as Administrator if accessing system directories
- Check folder permissions
- Ensure folders are not in use by other applications

### Path Not Found

- Verify the path exists
- Use absolute paths if relative paths fail
- Check for typos in the path

### PowerShell Execution Policy

If you get execution policy errors:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Changelog

### v1.0.3

- Initial release
- Recursive bin/obj folder deletion
- Self-contained executable
- PowerShell installer
- GitHub Actions CI/CD
