$ErrorActionPreference = 'Stop'
Set-StrictMode -Version Latest
. (Join-Path $PSScriptRoot '../scripts/week-01-orphaned-disks/DiskCandidates.ps1')

$now = [DateTimeOffset]::Parse('2026-10-01T12:00:00Z')
$subscription = '00000000-0000-0000-0000-000000000001'

function New-FakeDisk {
    param(
        [string]$State = 'Unattached',
        [string]$ManagedBy = '',
        [object[]]$Extended = @(),
        [AllowNull()][object]$Created = $now.AddDays(-60)
    )
    [pscustomobject]@{
        DiskState = $State
        ManagedBy = $ManagedBy
        ManagedByExtended = $Extended
        TimeCreated = $Created
        ResourceGroupName = 'rg-demo'
        Name = 'data-disk'
        Id = '/subscriptions/test/resourceGroups/rg-demo/providers/Microsoft.Compute/disks/data-disk'
        Location = 'eastus'
        DiskSizeGB = 128
        Sku = [pscustomobject]@{Name='Premium_LRS'}
    }
}
function Assert-Equal {
    param([object]$Actual,[object]$Expected,[string]$Message)
    if ($Actual -ne $Expected) { throw "$Message. Expected=[$Expected], actual=[$Actual]" }
    Write-Host "PASS: $Message"
}
function Candidates {
    param([object]$Disk,[int]$Days=30)
    @(Get-ManagedDiskReviewCandidate -Disk $Disk -SubscriptionId $subscription -ObservedUtc $now -MinimumAgeDays $Days)
}

$good = Candidates -Disk (New-FakeDisk)
Assert-Equal $good.Count 1 'Old, unattached, unmanaged disk is identified for review'
Assert-Equal $good[0].AgeDays 60 'Creation age is calculated from deterministic UTC clock'
Assert-Equal $good[0].OwnerReviewStatus 'PENDING' 'Owner review is explicitly pending'
Assert-Equal $good[0].DeletionApproved $false 'Never auto-approve deletion'
Assert-Equal $good[0].SubscriptionId $subscription 'Scope is explicit'
Assert-Equal (Candidates -Disk (New-FakeDisk -State 'Attached')).Count 0 'Attached disk excluded'
Assert-Equal (Candidates -Disk (New-FakeDisk -ManagedBy '/subscriptions/vm')).Count 0 'Managed disk excluded'
Assert-Equal (Candidates -Disk (New-FakeDisk -Extended @('/vm2'))).Count 0 'Multi-attached disk excluded'
Assert-Equal (Candidates -Disk (New-FakeDisk -Created $now.AddDays(-29))).Count 0 'Below minimum creation age excluded'
Assert-Equal (Candidates -Disk (New-FakeDisk -Created $now.AddDays(-30))).Count 1 'Boundary age included'
Assert-Equal (Candidates -Disk (New-FakeDisk -Created $now.AddDays(1))).Count 0 'Future creation timestamp excluded'
Assert-Equal (Candidates -Disk (New-FakeDisk -Created $null)).Count 0 'Unknown creation timestamp excluded'
Assert-Equal (Candidates -Disk (New-FakeDisk -Created 'not-a-date')).Count 0 'Invalid creation date excluded'
Write-Host 'PASS: All FinOps disk classification tests completed without connecting to Azure.'
