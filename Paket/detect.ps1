# Intune_Teams-V2_Winget - detect.ps1
# Version 1.0
# Date: 16.08.2024
# Author: Jonas Techand
# Description: Install the latest Teams V2 Version using Winget.
# --------------------------------------------------------------------------
# ChangeLog: Script creation
# --------------------------------------------------------------------------
# Dependencies: winget (https://github.com/AveGamers/Intune_Winget-Install);
# --------------------------------------------------------------------------

$NewTeams = $null
$windowsAppsPath = "C:\Program Files\WindowsApps"
$NewTeamsSearch = "MSTeams_*_x64__*"
$NewTeams = Get-ChildItem -Path $windowsAppsPath -Directory -Filter $NewTeamsSearch  -ErrorAction SilentlyContinue
if ($NewTeams ) {Write-Host "New Teams found";exit 0}
else {
    Write-Host "New Teams not found"
    powershell.exe -ExecutionPolicy Bypass -WindowStyle Hidden -File install.ps1
}