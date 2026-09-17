<#
.SYNOPSIS
Remediates STIG WN11-CC-000280 by requiring Remote Desktop Services
to always prompt clients for passwords upon connection.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-CC-000280
Vulnerability ID: V-253404
Severity        : CAT II (Medium)
CCI             : CCI-002038
SRG             : SRG-OS-000373-GPOS-00156

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-CC-000280
# Requirement: RDS must always prompt for passwords upon connection.

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
$ValueName = 'fPromptForPassword'
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
    Write-Host "[PASS] WN11-CC-000280 remediated successfully."
    Write-Host "fPromptForPassword = $CurrentValue"
}
else {
    Write-Host "[FAIL] WN11-CC-000280 remediation was unsuccessful."
    Write-Host "Current fPromptForPassword = $CurrentValue"
}
