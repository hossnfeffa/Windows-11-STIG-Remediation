<#
.SYNOPSIS
Remediates STIG WN11-AU-000083 by enabling Success auditing for
Object Access - Other Object Access Events.

.NOTES
Author          : Brent Petty
Date Created    : 2026-09-17
Last Modified   : 2026-09-17
Version         : 1.0

STIG-ID         : WN11-AU-000083
Vulnerability ID: V-253321
Severity        : CAT II (Medium)
CCI             : CCI-000172
SRG             : SRG-OS-000462-GPOS-00206

.TESTED ON
Date(s) Tested  :
Tested By       :
Systems Tested  : Windows 11
PowerShell Ver. :

.USAGE
Run PowerShell as Administrator.
#>

# STIG: WN11-AU-000083
# Requirement: Other Object Access Events successes must be audited.

$Subcategory = 'Other Object Access Events'

# Apply remediation
auditpol /set /subcategory:"$Subcategory" /success:enable | Out-Null

# Verify remediation
$AuditResult = auditpol /get /subcategory:"$Subcategory"

if ($AuditResult -match 'Success') {
    Write-Host "[PASS] WN11-AU-000083 remediated successfully."
    Write-Host "Other Object Access Events Success auditing is enabled."
}
else {
    Write-Host "[FAIL] WN11-AU-000083 remediation was unsuccessful."
    Write-Host "Success auditing is not enabled."
}

# Display current audit configuration
auditpol /get /subcategory:"$Subcategory"
