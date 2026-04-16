## 📊 What You Get

### Beautiful HTML Report

![HTML Report Preview](../../docs/images/orphaned-disks-report-preview.png)

The HTML report includes:
- Executive summary with savings metrics
- Priority-coded disk list (Critical/High/Medium/Low)
- Cost analysis per disk
- Recommended actions
- Age and creation date
- Resource tags (if any)

### CSV Export

For spreadsheet analysis and tracking:
- All disk details
- Resource IDs for automation
- Cost calculations
- Age in days
- Sortable by cost/priority

## 🎯 How It Works

1. **Connects** to your Azure subscription(s)
2. **Scans** all managed disks across all resource groups
3. **Identifies** disks with:
   - `DiskState = "Unattached"` 
   - No `ManagedBy` reference
   - Age greater than minimum threshold (default 30 days)
4. **Calculates** monthly and annual cost per disk
5. **Prioritizes** by cost impact
6. **Generates** beautiful HTML and CSV reports

## ⚙️ Parameters

| Parameter | Default | Description |
|-----------|---------|-------------|
| `SubscriptionId` | All accessible | Specific subscription to scan |
| `OutputPath` | `.\reports` | Where to save reports |
| `MinimumAge` | `30` | Minimum days orphaned to report |
| `ExportFormat` | `Both` | CSV, HTML, or Both |
| `DryRun` | `False` | Preview without generating files |

## 🗑️ How to Delete Orphaned Disks

**Option 1: Manual (Safest - Recommended)**

```powershell
# Review the disk first
Get-AzDisk -ResourceGroupName "rg-name" -DiskName "disk-name"

# Create snapshot (safety measure)
$disk = Get-AzDisk -ResourceGroupName "rg-name" -DiskName "disk-name"
$snapshotConfig = New-AzSnapshotConfig -SourceUri $disk.Id -Location $disk.Location -CreateOption Copy
New-AzSnapshot -ResourceGroupName "rg-name" -SnapshotName "disk-name-snapshot" -Snapshot $snapshotConfig

# Delete the disk
Remove-AzDisk -ResourceGroupName "rg-name" -DiskName "disk-name" -Force
```

**Option 2: Bulk Delete (Use with caution)**

```powershell
# Import the CSV
$orphanedDisks = Import-Csv ".\reports\orphaned-disks-2026-04-16-1430.csv"

# Filter for high-confidence deletions (>90 days old)
$toDelete = $orphanedDisks | Where-Object { $_.AgeInDays -gt 90 }

# Review before deleting
$toDelete | Format-Table DiskName, AgeInDays, MonthlyCostUSD

# Delete (after confirmation)
foreach ($disk in $toDelete) {
    Write-Host "Deleting $($disk.DiskName)..." -ForegroundColor Yellow
    Remove-AzDisk -ResourceGroupName $disk.ResourceGroup -DiskName $disk.DiskName -Force
}
```

## 🛡️ Safety Tips

**Before deleting disks:**

1. ✅ **Verify with resource owner** - Check if disk is planned for reuse
2. ✅ **Create snapshots** - Easy to restore if needed
3. ✅ **Check for dependencies** - Some disks might be part of inactive workloads
4. ✅ **Document deletion** - Track what was deleted and when
5. ✅ **Monitor applications** - Ensure no unexpected impacts

**Never delete without checking:**

- 🚫 Disks with business-critical tags
- 🚫 Recently detached disks (< 30 days)
- 🚫 Disks in production resource groups without verification
- 🚫 Disks associated with disaster recovery scenarios

## 🔄 Automation

### Schedule Monthly Scans

**Option 1: Task Scheduler (Windows)**

```powershell
# Create scheduled task for monthly scans
$action = New-ScheduledTaskAction -Execute "pwsh.exe" -Argument "-File C:\Scripts\Find-OrphanedDisks.ps1"
$trigger = New-ScheduledTaskTrigger -Monthly -At 6am -DaysOfMonth 1
Register-ScheduledTask -TaskName "MonthlyOrphanedDiskScan" -Action $action -Trigger $trigger
```

**Option 2: Azure Automation Runbook**

Upload the script to Azure Automation for scheduled cloud execution.

**Option 3: GitHub Actions**

```yaml
# .github/workflows/monthly-scan.yml
on:
  schedule:
    - cron: '0 6 1 * *'  # First day of month at 6 AM
```

## 📈 Tracking Savings

Create a simple tracking spreadsheet:

| Month | Disks Deleted | Monthly Savings | Running Total |
|-------|---------------|-----------------|---------------|
| Apr 2026 | 15 | $847 | $847 |
| May 2026 | 8 | $423 | $1,270 |
| Jun 2026 | 12 | $678 | $1,948 |

## 🐛 Troubleshooting

### Error: "Cannot access subscription"

```powershell
# Verify permissions
Get-AzRoleAssignment -SignInName (Get-AzContext).Account.Id
```

### Error: "Az module not installed"

```powershell
Install-Module -Name Az -Scope CurrentUser -Force
Import-Module Az
```

### HTML report doesn't display correctly

- Open in modern browser (Chrome, Edge, Firefox)
- Ensure HTML file downloaded completely
- Check for antivirus blocking content

## 🔗 Related Scripts

- **[Week 2](../week-02-unused-public-ips/)** - Unused Public IPs Detector
- **[Week 3](../week-03-vm-right-sizing/)** - VM Right-Sizing Analyzer

## 📞 Support

Questions? Issues? Suggestions?

- 📧 Email: mario@hartsonadvisory.com
- 💬 [GitHub Issues](https://github.com/mhartson310/Azure-Cost-Optimization-Toolkit/issues)
- 🌐 [mhartson.com](https://mhartson.com)

---

**Built by [Mario Hartson](https://mhartson.com)** | Part of the [Azure Cost Optimization Toolkit](https://github.com/mhartson310/Azure-Cost-Optimization-Toolkit)
