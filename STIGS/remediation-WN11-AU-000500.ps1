<#
.SYNOPSIS
Remediates STIG WN11-AU-000500 by configuring the Windows Application
event log maximum size to 32768 KB or greater.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-AU-000500
Vulnerability ID: V-253337
Severity        : CAT II (Medium)
CCI             : CCI-001849
SRG             : SRG-OS-000341-GPOS-00132

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-AU-000500
# Requirement: The Application event log size must be 32768 KB or greater.

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$ValueName = 'MaxSize'
$RequiredSize = 32768

# Create the registry path if it does not exist
if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

# Apply remediation
New-ItemProperty `
    -Path $RegistryPath `
    -Name $ValueName `
    -Value $RequiredSize `
    -PropertyType DWORD `
    -Force | Out-Null

# Verify remediation
$CurrentValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName).$ValueName

if ($CurrentValue -ge $RequiredSize) {
    Write-Host "[PASS] WN11-AU-000500 remediated successfully."
    Write-Host "Application event log MaxSize = $CurrentValue KB"
}
else {
    Write-Host "[FAIL] WN11-AU-000500 remediation was unsuccessful."
    Write-Host "Current MaxSize = $CurrentValue KB"
}
