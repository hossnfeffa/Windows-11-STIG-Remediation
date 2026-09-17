<#
.SYNOPSIS
Remediates STIG WN11-CC-000345 by disabling Basic authentication
for the Windows Remote Management service.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-CC-000345
Vulnerability ID: V-253418
Severity        : CAT I (High)
CCI             : CCI-000877
SRG             : SRG-OS-000125-GPOS-00065

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-CC-000345
# Requirement: WinRM service must not use Basic authentication.

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\WinRM\Service'
$ValueName = 'AllowBasic'
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
    Write-Host "[PASS] WN11-CC-000345 remediated successfully."
    Write-Host "AllowBasic = $CurrentValue"
}
else {
    Write-Host "[FAIL] WN11-CC-000345 remediation was unsuccessful."
    Write-Host "Current AllowBasic = $CurrentValue"
}
