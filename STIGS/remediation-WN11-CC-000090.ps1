<#
.SYNOPSIS
Remediates STIG WN11-CC-000090 by requiring registry Group Policy
objects to be reprocessed even when they have not changed.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-CC-000090
Vulnerability ID: V-253373
Severity        : CAT II (Medium)
CCI             : CCI-000366
SRG             : SRG-OS-000480-GPOS-00227

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-CC-000090
# Requirement: Group Policy objects must be reprocessed even if unchanged.

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\Group Policy\{35378EAC-683F-11D2-A89A-00C04FBBCFA2}'
$ValueName = 'NoGPOListChanges'
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
    Write-Host "[PASS] WN11-CC-000090 remediated successfully."
    Write-Host "NoGPOListChanges = $CurrentValue"
}
else {
    Write-Host "[FAIL] WN11-CC-000090 remediation was unsuccessful."
    Write-Host "Current NoGPOListChanges = $CurrentValue"
}
