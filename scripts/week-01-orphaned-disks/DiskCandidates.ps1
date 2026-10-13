<#
.SYNOPSIS
    Pure classification function for read-only Azure managed disk inventory.
.DESCRIPTION
    A qualifying result is only a review candidate, never authorization to delete.
    Creation age is NOT detachment age. Never infer billable savings here.
#>
function Get-ManagedDiskReviewCandidate {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory = $true)]
        [object]$Disk,
        [Parameter(Mandatory = $true)]
        [string]$SubscriptionId,
        [Parameter(Mandatory = $true)]
        [DateTimeOffset]$ObservedUtc,
        [Parameter(Mandatory = $true)]
        [ValidateRange(0,3650)]
        [int]$MinimumAgeDays
    )

    if ([string]$Disk.DiskState -ne "Unattached") { return }
    if (-not [string]::IsNullOrWhiteSpace([string]$Disk.ManagedBy)) { return }
    if (@($Disk.ManagedByExtended | Where-Object { $_ }).Count -gt 0) { return }
    if ($null -eq $Disk.TimeCreated) { return }

    try { $createdUtc = ([DateTimeOffset]$Disk.TimeCreated).ToUniversalTime() }
    catch { return }

    if ($createdUtc -gt $ObservedUtc -or
        $createdUtc -gt $ObservedUtc.AddDays(-$MinimumAgeDays)) { return }

    $size = $null
    if ($null -ne $Disk.DiskSizeGB) { $size = $Disk.DiskSizeGB }
    $skuName = $null
    if ($null -ne $Disk.Sku) { $skuName = [string]$Disk.Sku.Name }

    [pscustomobject]@{
        SubscriptionId    = $SubscriptionId
        ResourceGroup     = [string]$Disk.ResourceGroupName
        DiskName          = [string]$Disk.Name
        ResourceId        = [string]$Disk.Id
        Location          = [string]$Disk.Location
        DiskSizeGB        = $size
        Sku               = $skuName
        DiskState         = [string]$Disk.DiskState
        CreatedUtc        = $createdUtc.ToString("o")
        AgeDays           = [int][Math]::Floor(($ObservedUtc - $createdUtc).TotalDays)
        OwnerReviewStatus = "PENDING"
        DeletionApproved  = $false
        EvidenceLimit     = "Creation age only; detachment age and owner intent not verified"
    }
}
