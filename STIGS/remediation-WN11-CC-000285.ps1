<#
.SYNOPSIS
Remediates STIG WN11-CC-000285 by requiring secure RPC communications
for the Remote Desktop Session Host.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-CC-000285
Vulnerability ID: V-253405
Severity        : CAT II (Medium)
CCI             : CCI-001453
SRG             : SRG-OS-000250-GPOS-00093

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-CC-000285
# Requirement: Remote Desktop Session Host must require secure RPC communications.

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services'
$ValueName = 'fEncryptRPCTraffic'
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
    Write-Host "[PASS] WN11-CC-000285 remediated successfully."
    Write-Host "fEncryptRPCTraffic = $CurrentValue"
}
else {
    Write-Host "[FAIL] WN11-CC-000285 remediation was unsuccessful."
    Write-Host "Current fEncryptRPCTraffic = $CurrentValue"
}
