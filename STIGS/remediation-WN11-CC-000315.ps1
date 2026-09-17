<#
.SYNOPSIS
Remediates STIG WN11-CC-000315 by disabling the Windows Installer
"Always install with elevated privileges" feature.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-CC-000315
Vulnerability ID: V-253411
Severity        : CAT I (High)
CCI             : CCI-003980, CCI-001812
SRG             : SRG-OS-000362-GPOS-00149

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-CC-000315
# Requirement: Always install with elevated privileges must be disabled.

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Installer'
$ValueName = 'AlwaysInstallElevated'
$RequiredValue = 0

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
    Write-Host "[PASS] WN11-CC-000315 remediated successfully."
    Write-Host "AlwaysInstallElevated = $CurrentValue"
}
else {
    Write-Host "[FAIL] WN11-CC-000315 remediation was unsuccessful."
    Write-Host "Current AlwaysInstallElevated = $CurrentValue"
}
