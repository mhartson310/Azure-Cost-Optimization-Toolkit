# Azure Cost Optimization Toolkit — FinOps Engineering Reference

Azure cost-analysis and waste-detection examples intended to make cloud optimization **measurable, repeatable, and reviewable**.

> **Scope:** Analysis patterns and scripts. No fixed savings percentage or independently verified client savings are claimed.

## What this demonstrates

- Azure resource waste and cost-analysis workflows
- PowerShell automation for identifying orphaned disks
- KQL organization for cost, utilization, and optimization investigations
- FinOps decisions integrated with operational risk and governance

## Problem

Cost optimization is only meaningful when potential savings can be linked to actual resources, reviewed for operational impact, and verified against subsequent billing data.

## Architecture and trust boundaries

Cost data, subscription inventory, monitoring data, and execution identities have different access requirements. Discovery should be read-only wherever possible; deletion and resizing need separate approval and rollback criteria.

## Available implementation

- [Orphaned disk investigation script](scripts/week-01-orphaned-disks/Find-OrphanedDisks.ps1)
- [Cost-analysis queries](kql-queries/cost-analysis)
- [Utilization queries](kql-queries/utilization)
- [Optimization opportunity queries](kql-queries/optimization-opportunities)
- [Waste-detection queries](kql-queries/waste-detection)

## Threats and controls

Treat resource deletion, retention changes, aggressive right-sizing, and network reconfiguration as changes requiring ownership, security, resilience, and data-loss review.

## Deployment and validation

Review and run scripts in a non-production or read-only context first. Capture input scope, output, affected resources, and any false positives. This repository does not currently contain the full dashboard and broad automation catalog described in earlier versions of the README.

## Monitoring and results

1. Establish a baseline from authoritative billing and resource data.
2. Identify a concrete candidate and quantify its expected impact.
3. Review business, security, and recovery dependencies.
4. Implement only an approved change.
5. Compare observed post-change performance and cost with the baseline.

**Forecast savings are not realized savings.** No universal ROI or time-to-value is implied.

## Portfolio connections

[Azure landing zones](https://github.com/mhartson310/Azure-Landing-Zones) · [Zero Trust reference architectures](https://github.com/mhartson310/Azure-Zero-Trust-Reference-Architectures) · [FedRAMP governance patterns](https://github.com/mhartson310/FedRAMP-Azure-Toolkit)

**Status:** Reference implementation. Validate all commands and resource scopes before using them in a live subscription.
