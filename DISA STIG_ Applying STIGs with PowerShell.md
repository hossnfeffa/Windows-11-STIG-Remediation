# STIG Creation Methodology

1. Scan your VM with a Windows 11 STIG Audit Policy.  
2. View the Scan results and pick a STIG to Remediate/Implement (**WN11-AU-000500**).  
3. Figure out how to implement the STIG manually and attempt it.  
4. Rescan to confirm the implementation Success.  
5. If fix successful, undo the manual fix and rescan to show Failure (if your fix included a registry entry, consider exporting ChatGPT to Analyze before undoing it)  
6. Figure out how to implement your fix with PowerShell (and ChatGPT) and attempt it.  
7. Rescan to confirm the implementation Success.  
8. Publish your fix to GitHub and include it in your experience tracking spreadsheet.

---

# Step By Step STIG Automation for STIG ID: [WN11-AU-000500🔗](https://stigaview.com/products/win11/v2r5/WN11-AU-000500)

1. Login to [https://portal.azure.com](https://portal.azure.com)  
2. Create a new Windows 11 VM if you don’t already have one ([How to Properly Create a VM](https://docs.google.com/document/d/1o7I2MsZPgSH24LNC4aEr98tAu4nKpgYRSnxNY0VZYUQ/edit?tab=t.0#bookmark=id.398eet66ipbv))  
3. Disable the Windows Firewall  
4. Login to [https://cloud.tenable.com](https://cloud.tenable.com)   
5. Create a new **Advanced Network Scan**  
   1. Use LOCAL-SCAN-ENGINE-01, target your VM’s Private IP address  
   2. Under the ‘Discovery’ tab, enable “Use fast network discovery”  
   3. Provide Windows credentials for your scan  
   4. Add Compliance Checks for DISA Windows 11 STIG v2r6 (search: Windows 11 STIG)  
   5. If you want the scan to only check for STIGs and be FAST:  
      1. disable ALL plugins and then click on **“Policy Compliance”**  
      2. Within Policy Compliance, enable *only* **“Windows Compliance Checks”**  
6. Do an initial baseline scan.  
   Note: If your scan only runs for around 1 minute and only shows Vulns by Asset and History, make sure “Use fast network discovery” is enabled under the Discovery tab.  
7. In the scan results, pick any failed STIG and take note of the STIG-ID (For the lab, we will use: **WN11-AU-000500**)  
8. Figure out how to remediate it manually by searching the STIG-ID on Google  
   1. For example the google search: [https://www.google.com/search?q=%22WN11-AU-000500%22](https://www.google.com/search?q=%22WN11-AU-000500%22)  
      1. Yields [instructions on how to apply that particular STIG](https://stigaview.com/products/win11/v2r5/WN11-AU-000500/)  
9. Restart your VM and run a scan to test the fix  
10. If it’s fixed, revert your fix (undo it) and run a scan to show that it fails again.  
11. Figure out how to remediate it with PowerShell   
    1. You can simply paste the contents of the page into ChatGPT and ask it to implement it in PowerShell  
12. Test your remediation by running the PowerShell script and rescanning it  
13. Ensure the STIG has been applied and has passed in the scan results  
14. Use the [STIG Implementation / Vulnerability Remediation template](https://github.com/joshmadakor1/lognpacific-public/blob/main/cyber-range/vulnerability-remediations/__template_remediation-STIG-ID-WN11-AU-000500.ps1), fill it out appropriately, insert your code, and add it to your Github repository  
15. Add the link to our internship experience tracking spreadsheet