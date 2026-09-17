# Windows 11 STIG Remediation

A hands-on Windows 11 security-hardening project focused on identifying, remediating, and verifying DISA Security Technical Implementation Guide (STIG) controls using PowerShell.

## Overview

This repository documents Windows 11 STIG remediations performed in a lab environment using the **DISA Microsoft Windows 11 STIG V2R8** baseline.

Each PowerShell remediation is built around an individual STIG control and includes:

* STIG and vulnerability identification
* Severity, CCI, and SRG mappings
* Description of the security requirement
* PowerShell-based remediation
* Post-remediation verification
* Clear `[PASS]` / `[FAIL]` validation output

The goal is to demonstrate the full remediation process rather than simply applying registry changes: **understand the security requirement, implement the appropriate control, and verify that the system reached the intended state.**

## Lab Environment

| Item                  | Details                                                      |
| --------------------- | ------------------------------------------------------------ |
| Target OS             | Windows 11                                                   |
| STIG Baseline         | DISA Microsoft Windows 11 STIG V2R8                          |
| Remediation           | PowerShell                                                   |
| Configuration Methods | Registry, Windows Audit Policy, Group Policy-backed settings |
| Validation            | PowerShell, Registry verification, `auditpol`                |
| Environment           | Windows 11 lab/test system                                   |

## Methodology

Each STIG remediation follows the same basic workflow:

1. **Identify** — Review the STIG requirement, Vulnerability ID, severity, CCI, and associated security requirement.
2. **Assess** — Determine the Windows configuration or policy responsible for the finding.
3. **Remediate** — Apply the required configuration using PowerShell.
4. **Verify** — Query the resulting configuration to confirm the expected value was successfully applied.
5. **Document** — Maintain an individual, repeatable remediation script for the control.

This provides a consistent **STIG → Configuration → Remediation → Verification** workflow across the repository.

## STIG Remediations

| STIG ID          | Security Requirement                                               | Severity | Remediation                                          |
| ---------------- | ------------------------------------------------------------------ | -------- | ---------------------------------------------------- |
| `WN11-AU-000500` | Application event log size must be 32768 KB or greater             | CAT II   | [PowerShell](./STIGS/remediation-WN11-AU-000500.ps1) |
| `WN11-CC-000315` | Always install with elevated privileges must be disabled           | CAT I    | [PowerShell](./STIGS/remediation-WN11-CC-000315.ps1) |
| `WN11-CC-000090` | Group Policy objects must be reprocessed even if unchanged         | CAT II   | [PowerShell](./STIGS/remediation-WN11-CC-000090.ps1) |
| `WN11-CC-000110` | Printing over HTTP must be prevented                               | CAT II   | [PowerShell](./STIGS/remediation-WN11-CC-000110.ps1) |
| `WN11-CC-000285` | Remote Desktop Session Host must require secure RPC communications | CAT II   | [PowerShell](./STIGS/remediation-WN11-CC-000285.ps1) |
| `WN11-CC-000345` | WinRM service must not use Basic authentication                    | CAT I    | [PowerShell](./STIGS/remediation-WN11-CC-000345.ps1) |
| `WN11-CC-000280` | Remote Desktop Services must prompt clients for passwords          | CAT II   | [PowerShell](./STIGS/remediation-WN11-CC-000280.ps1) |
| `WN11-CC-000326` | PowerShell Script Block Logging must be enabled                    | CAT II   | [PowerShell](./STIGS/remediation-WN11-CC-000326.ps1) |
| `WN11-CC-000185` | Default AutoRun behavior must prevent AutoRun commands             | CAT I    | [PowerShell](./STIGS/remediation-WN11-CC-000185.ps1) |
| `WN11-AU-000083` | Other Object Access Events successes must be audited               | CAT II   | [PowerShell](./STIGS/remediation-WN11-AU-000083.ps1) |

## Example Remediation

Each script follows a standardized structure.

For example, `WN11-AU-000500` requires the Windows Application event log maximum size to be configured to at least **32768 KB**.

The remediation defines the required registry configuration:

```powershell
$RegistryPath = 'HKLM:\SOFTWARE\Policies\Microsoft\Windows\EventLog\Application'
$ValueName = 'MaxSize'
$RequiredSize = 32768

if (-not (Test-Path $RegistryPath)) {
    New-Item -Path $RegistryPath -Force | Out-Null
}

New-ItemProperty `
    -Path $RegistryPath `
    -Name $ValueName `
    -Value $RequiredSize `
    -PropertyType DWORD `
    -Force | Out-Null
```

The script then verifies the resulting configuration:

```powershell
$CurrentValue = (Get-ItemProperty -Path $RegistryPath -Name $ValueName).$ValueName

if ($CurrentValue -ge $RequiredSize) {
    Write-Host "[PASS] WN11-AU-000500 remediated successfully."
    Write-Host "Application event log MaxSize = $CurrentValue KB"
}
else {
    Write-Host "[FAIL] WN11-AU-000500 remediation was unsuccessful."
    Write-Host "Current MaxSize = $CurrentValue KB"
}
```

This verification step is included so that each remediation confirms the resulting configuration instead of assuming that a successfully executed command resulted in compliance.

## Script Standard

Each remediation script contains identifying information for the associated STIG control:

```text
STIG-ID         : WN11-AU-000500
Vulnerability ID: V-253337
Severity        : CAT II (Medium)
CCI             : CCI-001849
SRG             : SRG-OS-000341-GPOS-00132
```

Scripts also contain:

* Synopsis and security requirement
* Tested environment information
* Required registry or policy configuration
* Remediation logic
* Post-remediation validation
* PASS/FAIL output

This keeps each control independently understandable and executable.

## Running a Remediation

Open **PowerShell as Administrator** and execute the desired remediation script.

If PowerShell execution policy prevents the script from running, it can be temporarily bypassed for the current PowerShell process:

```powershell
Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process
```

Then run the desired script:

```powershell
.\remediation-WN11-AU-000500.ps1
```

The execution-policy change applies only to the current PowerShell process.

> **Note:** STIG remediation should be tested before deployment to production systems. Group Policy, domain policy, security tooling, or other configuration-management systems may override locally configured settings.

## Skills Demonstrated

This project demonstrates practical experience with:

* DISA STIG interpretation and remediation
* Windows 11 security hardening
* PowerShell automation
* Windows Registry configuration
* Group Policy-backed security settings
* Windows Advanced Audit Policy
* Security control validation
* Configuration verification
* Vulnerability and compliance remediation
* CCI and SRG control mapping

## References

* [DISA Cyber Exchange - STIGs](https://public.cyber.mil/stigs/)
* [DISA STIG/SRG Tools](https://public.cyber.mil/stigs/srg-stig-tools/)
* [Windows 11 STIG V2R8 - STIG-A-View](https://stigaview.com/products/win11/v2r8/)

## Disclaimer

All remediations in this repository were performed in a lab/test environment for educational, professional-development, and portfolio purposes.

These scripts are not a substitute for an authorized security assessment or enterprise configuration-management process. STIG requirements and releases may change, and configurations should be validated against the applicable DISA STIG before deployment.

## Author

**Brent Petty**

Cybersecurity & Operations Professional
B.S. Cybersecurity and Information Assurance

