<#
.SYNOPSIS
Remediates STIG WN11-CC-000326 by enabling PowerShell Script Block Logging.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-CC-000326
Vulnerability ID: V-253414
Severity        : CAT II (Medium)
CCI             : CCI-000135
SRG             : SRG-OS-000042-GPOS-00020

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-CC-000326
# Requirement: PowerShell Script Block Logging must be enabled.

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\PowerShell\ScriptBlockLogging'
$ValueName = 'EnableScriptBlockLogging'
$RequiredValue = 1

# Create the registry path if it does not exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Apply remediation
New-ItemProperty -Path $RegistryPath -Name $ValueName `
    -Value $RequiredValue -PropertyType DWORD -Force | Out-Null

# Verify remediation
$CurrentValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName).$ValueName

if ($CurrentValue -eq $RequiredValue) {
    Write-Host "[PASS] WN11-CC-000326 remediated successfully."
    Write-Host "EnableScriptBlockLogging = $CurrentValue"
}
else {
    Write-Host "[FAIL] WN11-CC-000326 remediation was unsuccessful."
    Write-Host "Current EnableScriptBlockLogging = $CurrentValue"
}
