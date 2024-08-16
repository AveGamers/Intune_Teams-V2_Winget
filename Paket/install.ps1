# Intune_Teams-V2_Winget - install.ps1
# Version 1.0
# Date: 16.08.2024
# Author: Jonas Techand
# Description: Install the latest Teams V2 Version using Winget.
# --------------------------------------------------------------------------
# ChangeLog: Script creation
# --------------------------------------------------------------------------
# Dependencies: winget (https://github.com/AveGamers/Intune_Winget-Install);
# --------------------------------------------------------------------------
$PackageName = "Intune_TeamsV2Package"
$WingetApp = "Microsoft.Teams"

# Check for running as admin
$currentPrincipal = New-Object Security.Principal.WindowsPrincipal([Security.Principal.WindowsIdentity]::GetCurrent())
$adminRole = [Security.Principal.WindowsBuiltInRole]::Administrator

if (-not $currentPrincipal.IsInRole($adminRole)) {
    Write-Host "Restarting script with administrative privileges..."
    Start-Process powershell.exe -ArgumentList "-ExecutionPolicy Bypass -WindowStyle Hidden -File `"$PSCommandPath`"" -Verb RunAs
    Start-Sleep 120
    exit
}

write-warning "The script has been started with administrative privileges."

# Start-Transcript -Path "$env:TEMP\IntunePackage\$PackageName\Install.log" -NoClobber -Append
Start-Transcript -Path "C:\source\IntunePackage\$PackageName\Install.log" -NoClobber -Append

function Get-WingetDirectory {
    $ResolveWingetPath = Resolve-Path "C:\Program Files\WindowsApps\Microsoft.DesktopAppInstaller_*_x64__8wekyb3d8bbwe\winget.exe"
    if ($ResolveWingetPath){
           $WingetPath = $ResolveWingetPath[-1].Path
    }

    $Wingetpath = Split-Path -Path $WingetPath -Parent
    cd $wingetpath
}

Get-WingetDirectory
# Install $PackageName Full Client using Winget
# Check if $PackageName is installed
$AppInstalled = .\winget.exe list --accept-source-agreements | Where-Object { $_ -match "$WingetApp" }
if (-not $AppInstalled) {
    # Install TeamViewer Using winget
    Write-Host "-> Installing $PackageName using winget..."
    Write-Host "-> @winget install $WingetApp --accept-package-agreements --accept-source-agreements --force --dependency-source --scope machine"
    .\winget.exe install $WingetApp --accept-package-agreements --accept-source-agreements --force --dependency-source --scope machine
    $AppInstalled = .\winget.exe list --accept-source-agreements | Where-Object { $_ -match "$WingetApp" }
    if (-not $AppInstalled) {
        Write-Host "-> $PackageName installation failed. Exiting script."
    } else {
        Write-Host "-> $PackageName has been installed successfully."
    }}
else {
    Write-Host "-> $PackageName is already installed. Skipping installation."
}

Write-Host "-> Installation Steps completed successfully."

Stop-Transcript