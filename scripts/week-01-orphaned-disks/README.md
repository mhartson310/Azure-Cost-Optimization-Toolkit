# Orphaned Managed Disk Inventory (Read-only)

This directory contains an executable **PowerShell inventory script**, not an automated cleanup job.

The script lists managed disks in the chosen Azure subscription that:
- report `DiskState = Unattached`;
- have no current `ManagedBy` or `ManagedByExtended` reference;
- have a known creation date at least `MinimumAgeDays` old.

**Caution:** Creation age is not the same as detachment age. A disk may have been detached recently despite being created long ago. Every result is a **candidate for manual investigation**, not a deletion recommendation.

## Prerequisites

PowerShell 7, `Az.Accounts` and `Az.Compute`, an existing `Connect-AzAccount` session and the ability to read managed disks in the subscription.

```powershell
Connect-AzAccount
./scripts/week-01-orphaned-disks/Find-OrphanedDisks.ps1 -MinimumAgeDays 30 -ExportFormat Both
```

For a selected subscription:

```powershell
./scripts/week-01-orphaned-disks/Find-OrphanedDisks.ps1 -SubscriptionId "<subscription-id>" -MinimumAgeDays 60 -ExportFormat CSV
```

The script scans the **selected subscription only**, never all subscriptions implicitly. It generates an optional JSON/CSV report in `./reports`, and returns structured objects on the pipeline. It **does not calculate Azure prices or dollar savings**, and never deletes a disk.

## Manual review before action

Validate ownership, current dependencies, resource locks, backup/restore dependencies, Azure Site Recovery, last detach/change activity, tag metadata, and retention policy. The fields `OwnerReviewStatus=PENDING` and `DeletionApproved=False` are explicit placeholders, not approvals.

If the platform and finance teams decide to remove an unused disk, use the organization's separate change-management process and re-check the exact resource ID immediately before action. Avoid bulk deletion from CSV alone.

## Proof and limitations

CI validates PowerShell syntax **and executes deterministic offline classification tests** for attached/multi-attached disks, missing or invalid dates, minimum-age boundaries, and safe review defaults ([test cases](../../tests/disk-candidates.tests.ps1)). **These tests do not prove that Azure inventory ran successfully or that reported candidates are safe to delete.** Capture sanitized evidence from a subscription-level lab before claiming runtime validation.
