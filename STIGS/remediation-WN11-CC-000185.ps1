<#
.SYNOPSIS
Remediates STIG WN11-CC-000185 by configuring the default AutoRun
behavior to prevent AutoRun commands from executing.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-CC-000185
Vulnerability ID: V-253387
Severity        : CAT I (High)
CCI             : CCI-001764
SRG             : SRG-OS-000368-GPOS-00154

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-CC-000185
# Requirement: Default AutoRun behavior must prevent AutoRun commands.

$RegistryPath = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\Explorer'
$ValueName = 'NoAutorun'
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
    Write-Host "[PASS] WN11-CC-000185 remediated successfully."
    Write-Host "NoAutorun = $CurrentValue"
}
else {
    Write-Host "[FAIL] WN11-CC-000185 remediation was unsuccessful."
    Write-Host "Current NoAutorun = $CurrentValue"
}
