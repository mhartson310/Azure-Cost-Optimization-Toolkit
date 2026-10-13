#Requires -Modules Az.Accounts, Az.Compute
<#
.SYNOPSIS
    Finds Azure managed-disk candidates for manual orphaned-resource review.
.DESCRIPTION
    READ-ONLY. Enumerates managed disks in the selected subscription and reports
    unattached disks older than the chosen minimum age. An unattached disk is NOT
    automatically safe to delete; validate owners, backups, recovery plans,
    dependencies and potential reservations before taking action.
.EXAMPLE
    ./Find-OrphanedDisks.ps1 -MinimumAgeDays 30 -ExportFormat Both
.EXAMPLE
    ./Find-OrphanedDisks.ps1 -SubscriptionId "<subscription-guid>" -ExportFormat CSV
.NOTES
    No resources are modified. Requires an existing Connect-AzAccount session
    and read permission on the subscription.
#>
[CmdletBinding()]
param(
    [Parameter()]
    [string]$SubscriptionId,

    [Parameter()]
    [ValidateRange(0, 3650)]
    [int]$MinimumAgeDays = 30,

    [Parameter()]
    [ValidateSet("Both", "CSV", "JSON", "None")]
    [string]$ExportFormat = "Both",

    [Parameter()]
    [string]$OutputPath = "./reports"
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

$context = Get-AzContext
if (-not $context) {
    throw "No Azure context found. Run Connect-AzAccount first."
}
if (-not [string]::IsNullOrWhiteSpace($SubscriptionId)) {
    $context = Set-AzContext -SubscriptionId $SubscriptionId -ErrorAction Stop
}
$subscription = $context.Subscription.Id
if ([string]::IsNullOrWhiteSpace($subscription)) {
    throw "No subscription selected. Choose a subscription explicitly."
}

Write-Host "Inspecting managed disks in subscription $subscription (read-only)..." -ForegroundColor Cyan

$now = [DateTimeOffset]::UtcNow
$cutoff = $now.AddDays(-$MinimumAgeDays)
$disks = @(Get-AzDisk -ErrorAction Stop)

$results = @(
    foreach ($disk in $disks) {
        $state = [string]$disk.DiskState
        $managedBy = [string]$disk.ManagedBy
        $extended = @($disk.ManagedByExtended | Where-Object { $_ })
        $created = $disk.TimeCreated

        # No age data means the eligibility is unknown: do not recommend it.
        if ($null -eq $created) { continue }
        $createdUtc = ([DateTimeOffset]$created).ToUniversalTime()

        if ($state -ne "Unattached" -or
            -not [string]::IsNullOrWhiteSpace($managedBy) -or
            $extended.Count -gt 0 -or
            $createdUtc -gt $cutoff) {
            continue
        }

        [pscustomobject]@{
            SubscriptionId    = $subscription
            ResourceGroup     = $disk.ResourceGroupName
            DiskName          = $disk.Name
            ResourceId        = $disk.Id
            Location          = $disk.Location
            DiskSizeGB        = $disk.DiskSizeGB
            Sku               = [string]$disk.Sku.Name
            DiskState         = $state
            CreatedUtc        = $createdUtc.ToString("o")
            AgeDays           = [int][Math]::Floor(($now - $createdUtc).TotalDays)
            ManagedBy         = $managedBy
            OwnerReviewStatus = "PENDING"
            DeletionApproved  = $false
        }
    }
)

$results = @($results | Sort-Object -Property AgeDays -Descending)
Write-Host ("Found {0} candidate(s) for human review out of {1} disk(s)." -f $results.Count, $disks.Count) -ForegroundColor Yellow

if ($ExportFormat -ne "None") {
    New-Item -Path $OutputPath -ItemType Directory -Force | Out-Null
    $timestamp = (Get-Date).ToUniversalTime().ToString("yyyyMMddTHHmmssZ")
    $stem = Join-Path $OutputPath "orphaned-disks-$timestamp"

    if ($ExportFormat -in @("Both", "CSV")) {
        # An empty CSV is not falsely represented as a successful finding.
        if ($results.Count -gt 0) {
            $results | Export-Csv -Path "$stem.csv" -NoTypeInformation -Encoding UTF8
            Write-Host "CSV: $stem.csv"
        } else {
            Write-Host "No CSV created: no matching candidates."
        }
    }
    if ($ExportFormat -in @("Both", "JSON")) {
        ConvertTo-Json -InputObject $results -Depth 5 |
            Set-Content -Path "$stem.json" -Encoding UTF8
        Write-Host "JSON: $stem.json"
    }
}

# Output structured objects for interactive review and downstream read-only analysis.
$results
