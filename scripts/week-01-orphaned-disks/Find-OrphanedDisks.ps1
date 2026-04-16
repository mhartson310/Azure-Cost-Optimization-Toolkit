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

## 🎨 Sample Output
