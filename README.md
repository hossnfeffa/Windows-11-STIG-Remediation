# Windows 11 STIG Remediation

A hands-on collection of Security Technical Implementation Guide (STIG) remediations performed against a Windows 11 baseline, documented for portfolio and internship/job-hunt purposes as part of ongoing vulnerability management practice.

## Overview

This repository documents the process of identifying, remediating, and verifying findings from the DISA **Windows 11 STIG** benchmark in a lab/test environment. Each entry walks through the vulnerability as defined by DISA, the steps taken to remediate it, and evidence that the fix was applied successfully.

The goal of this project is to demonstrate practical, hands-on vulnerability management and hardening skills — reading a STIG finding, understanding the underlying risk, applying the correct technical control (Group Policy, registry, local security policy, PowerShell, etc.), and validating the result.

## Environment

| Item | Details |
|---|---|
| Target OS | Windows 11 (Enterprise/Pro) |
| STIG Benchmark | DISA Microsoft Windows 11 STIG, version `<fill in version/release>` |
| Scan/Validation Tool | `<e.g., DISA STIG Viewer, PowerSTIG, Evaluate-STIG, manual verification>` |
| Environment Type | `<e.g., isolated VM / lab environment>` |

## Methodology

For each finding included in this repository, the following process was followed:

1. **Identify** the finding using the DISA STIG Viewer / checklist and record the Vulnerability ID (V-ID), Rule ID, and Severity (CAT I/II/III).
2. **Assess** the current (non-compliant) state of the system against the finding.
3. **Remediate** by applying the appropriate control (Local Group Policy, registry edit, security policy setting, or PowerShell script).
4. **Verify** the fix by re-checking the setting and capturing before/after evidence (screenshots, `gpresult`, registry exports, or script output).
5. **Document** the finding and remediation steps in this repository.

## Remediation Summary

Ten findings are documented in this repository. Fill in the table below as each one is completed and linked to its corresponding folder/file.

| # | STIG ID (V-ID) | Rule Title | Severity | Status | Remediation Method | Details |
|---|---|---|---|---|---|---|
| 1 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ✅ Complete | `<GPO / Registry / PowerShell>` | [Link](./findings/01-<slug>/) |
| 2 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/02-<slug>/) |
| 3 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/03-<slug>/) |
| 4 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/04-<slug>/) |
| 5 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/05-<slug>/) |
| 6 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/06-<slug>/) |
| 7 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/07-<slug>/) |
| 8 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/08-<slug>/) |
| 9 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/09-<slug>/) |
| 10 | `WN11-XX-XXXXXX` | `<rule title>` | CAT `<I/II/III>` | ⬜ Not Started | | [Link](./findings/10-<slug>/) |

## Repository Structure

```
Windows-11-STIG-Remediation/
├── README.md
└── findings/
    ├── 01-<slug>/
    │   ├── README.md        # Finding details, before/after, remediation steps
    │   └── evidence/        # Screenshots, exports, script output
    ├── 02-<slug>/
    │   ├── README.md
    │   └── evidence/
    └── ...
```

Each finding folder's `README.md` should follow a consistent template, for example:

```markdown
## <V-ID> - <Rule Title>

**Severity:** CAT <I/II/III>
**STIG Reference:** <benchmark name and version>

### Discussion
Brief explanation of the vulnerability/risk this finding addresses.

### Check
How the non-compliant state was identified (commands, GPO path, registry key, etc.).

### Fix
The exact remediation steps taken.

### Verification
How compliance was confirmed after remediation (with evidence linked below).

### Evidence
- ![Before](./evidence/before.png)
- ![After](./evidence/after.png)
```

## Tools & References

- [DISA Cyber Exchange – STIGs](https://public.cyber.mil/stigs/)
- [DISA STIG Viewer](https://public.cyber.mil/stigs/srg-stig-tools/)
- `<PowerSTIG / Evaluate-STIG, if used>`
- `<Microsoft Security Compliance Toolkit, if used>`

## Disclaimer

All remediations in this repository were performed in an isolated lab/test environment for educational and portfolio purposes. This is not an official DISA-certified assessment and should not be used as a substitute for formal compliance scanning or an authorized STIG assessment.

## Author

**Brent**
`<LinkedIn / portfolio link>`
