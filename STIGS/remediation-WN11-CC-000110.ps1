<#
.SYNOPSIS
Remediates STIG WN11-CC-000110 by preventing printing over HTTP.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-CC-000110
Vulnerability ID: V-253376
Severity        : CAT II (Medium)
CCI             : CCI-000381
SRG             : SRG-OS-000095-GPOS-00049

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-CC-000110
# Requirement: Printing over HTTP must be prevented.

$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Printers'
$ValueName = 'DisableHTTPPrinting'
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
    Write-Host "[PASS] WN11-CC-000110 remediated successfully."
    Write-Host "DisableHTTPPrinting = $CurrentValue"
}
else {
    Write-Host "[FAIL] WN11-CC-000110 remediation was unsuccessful."
    Write-Host "Current DisableHTTPPrinting = $CurrentValue"
}
