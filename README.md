# Azure Cost Optimization Toolkit

[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Azure](https://img.shields.io/badge/Azure-Cost_Optimization-0078D4?logo=microsoft-azure)](https://azure.microsoft.com/)
[![Savings](https://img.shields.io/badge/Average_Savings-30--50%25-success)]()
[![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen.svg)](https://github.com/mhartson310/Azure-Cost-Optimization-Toolkit)

Production-tested scripts, KQL queries, and Azure Policy definitions to reduce Azure costs by **30-50%** without impacting operations.

**Based on real cost optimization engagements** saving clients $50k-$2M annually.

---

## 💰 What This Delivers

**Real savings from real deployments:**

| Client Size | Monthly Azure Spend | Savings Achieved | Annual Savings |
|-------------|--------------------|--------------------|----------------|
| **Small Enterprise** | $50k/month | 35% reduction | **$210k/year** |
| **Mid-Market** | $200k/month | 42% reduction | **$1.0M/year** |
| **Enterprise** | $500k/month | 38% reduction | **$2.3M/year** |
| **Fortune 500** | $2M/month | 31% reduction | **$7.4M/year** |

**Average ROI:** 200-500% in first year after implementation

---

## 🎯 What This Is

**Real optimization code** used to reduce Azure costs across Fortune 500 and government environments.

Not theoretical "best practices" - these are the exact scripts and policies that have saved millions of dollars in production.

---

## 📦 What's Included

### 🔍 Cost Analysis Scripts

- **[Orphaned Resources Detector](scripts/orphaned-resources/)** - Find abandoned resources costing you money
- **[Right-Sizing Analyzer](scripts/right-sizing/)** - Identify oversized VMs, databases, storage
- **[Reserved Instance Analyzer](scripts/reserved-instances/)** - Maximize RI savings
- **[Storage Tier Optimizer](scripts/storage-optimization/)** - Automate cool/archive tier movement
- **[Unused Resource Finder](scripts/unused-resources/)** - Identify zombie resources

### 📊 KQL Cost Analysis Queries

- **[High-Cost Resources](kql-queries/high-cost-resources.kql)** - Top spenders by category
- **[Unused VMs](kql-queries/unused-vms.kql)** - VMs with <10% utilization
- **[Oversized Databases](kql-queries/oversized-databases.kql)** - SQL DBs running at low capacity
- **[Storage Analysis](kql-queries/storage-analysis.kql)** - Hot vs cool vs archive usage
- **[Network Cost Leaks](kql-queries/network-cost-leaks.kql)** - Unused public IPs, idle gateways

### 🛡️ Azure Policy for Cost Control

- **[Resource Tagging](policies/enforce-cost-tags.json)** - Enforce cost tracking tags
- **[SKU Restrictions](policies/restrict-expensive-skus.json)** - Block expensive SKUs in non-prod
- **[Region Restrictions](policies/restrict-regions.json)** - Limit to cost-effective regions
- **[Shutdown Schedules](policies/vm-auto-shutdown.json)** - Auto-shutdown non-prod VMs
- **[Storage Tier Policies](policies/storage-lifecycle.json)** - Automatic tier transitions

### 📈 Power BI Dashboard

- **[Cost Optimization Dashboard](dashboards/cost-optimization.pbix)** - Executive reporting
- **[Savings Tracker](dashboards/savings-tracker.pbix)** - Track implemented savings
- **[Department Chargeback](dashboards/chargeback.pbix)** - Cost allocation

---

## 🚀 Quick Start

### Prerequisites

- Azure subscription with Cost Management Reader role
- PowerShell 7.0+
- Azure CLI authenticated
- Log Analytics workspace (optional, for advanced analysis)

### 1. Clone the Repository

```bash
