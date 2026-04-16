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
git clone https://github.com/mhartson310/Azure-Cost-Optimization-Toolkit.git
cd Azure-Cost-Optimization-Toolkit
```

### 2. Run Initial Cost Assessment

```powershell
# Comprehensive cost analysis
pwsh ./scripts/cost-assessment.ps1 -SubscriptionId "YOUR_SUB_ID" -OutputPath "./reports"
```

**This generates:**
- Current spend analysis (by service, region, resource group)
- Top cost drivers (biggest expenses)
- Immediate savings opportunities (quick wins)
- Long-term optimization recommendations
- ROI projections

### 3. Identify Quick Wins

```powershell
# Find orphaned resources (typically 5-15% of spend)
pwsh ./scripts/orphaned-resources/find-orphaned-disks.ps1

# Find oversized VMs
pwsh ./scripts/right-sizing/analyze-vm-utilization.ps1 -DaysToAnalyze 30

# Find unused public IPs
pwsh ./scripts/orphaned-resources/find-unused-public-ips.ps1
```

### 4. Implement Automation

```bash
# Deploy cost management policies
terraform init
terraform apply

# Enable auto-shutdown for non-prod
pwsh ./scripts/automation/configure-auto-shutdown.ps1 -Environment "NonProd"

# Configure storage lifecycle management
pwsh ./scripts/storage-optimization/deploy-lifecycle-policies.ps1
```

### 5. Monitor Savings

```powershell
# Generate monthly savings report
pwsh ./scripts/reporting/monthly-savings-report.ps1 -Month "2026-04"
```

---

## 💡 Top 10 Cost Saving Opportunities

### 1. Right-Size Virtual Machines (15-30% savings)

Most VMs are oversized by 2-3 sizes. Right-size based on actual usage.

```powershell
# Analyze VM utilization over 30 days
./scripts/right-sizing/analyze-vm-utilization.ps1 -DaysToAnalyze 30

# Output: VMs with <50% CPU/memory utilization
# Typical savings: 30-40% on those VMs
```

**Real example:** Client had 200 VMs averaging 15% CPU. Right-sized to smaller SKUs, saved $45k/month.

---

### 2. Delete Orphaned Resources (5-15% savings)

Unattached disks, unused public IPs, abandoned snapshots accumulate over time.

```powershell
# Find all orphaned resources
./scripts/orphaned-resources/find-all-orphaned.ps1

# Common findings:
# - Unattached managed disks (typically 50+ per sub)
# - Unused public IPs ($3.60/month each)
# - Abandoned snapshots (growing monthly)
# - Empty resource groups
```

**Real example:** Fortune 500 client had 847 unattached disks = $12k/month waste.

---

### 3. Use Reserved Instances / Savings Plans (40-72% savings)

For predictable workloads, Reserved Instances save 40-72%.

```powershell
# Analyze RI opportunities
./scripts/reserved-instances/analyze-ri-opportunities.ps1

# Recommendations:
# - Which VM sizes to reserve
# - 1-year vs 3-year term analysis
# - Shared vs single-scope
# - Break-even calculations
```

**Real example:** Client saved $2.1M annually by converting 60% of VMs to 3-year RIs.

---

### 4. Auto-Shutdown Non-Production VMs (60-75% savings on non-prod)

Non-prod VMs don't need to run 24/7.

```powershell
# Configure auto-shutdown for dev/test
./scripts/automation/configure-auto-shutdown.ps1 `
    -Environment "NonProd" `
    -ShutdownTime "19:00" `
    -StartupTime "07:00" `
    -TimeZone "Eastern Standard Time"
```

**Typical savings:** 65% reduction on non-prod costs (12 hours/day × 5 days/week)

**Real example:** $180k/month non-prod spend → $63k/month after auto-shutdown.

---

### 5. Storage Tier Optimization (30-70% savings on storage)

Move infrequently accessed data to cool/archive tiers.

```powershell
# Analyze blob access patterns
./scripts/storage-optimization/analyze-blob-access.ps1

# Deploy lifecycle management
./scripts/storage-optimization/deploy-lifecycle-policies.ps1
```

**Storage tier pricing:**
- Hot: $0.0184/GB (immediate access)
- Cool: $0.0100/GB (46% savings, 30-day minimum)
- Archive: $0.00099/GB (95% savings, 180-day minimum)

**Real example:** Client moved 400TB of backups to archive tier, saved $7,200/month.

---

### 6. Delete Unused Resources (5-10% savings)

Zombie resources that are running but not needed.

```powershell
# Find unused resources (no usage in 30+ days)
./scripts/unused-resources/find-unused-resources.ps1 -DaysInactive 30

# Common unused resources:
# - VMs with no recent logins
# - Databases with no connections
# - App Services with no requests
# - Load Balancers with no backend
```

---

### 7. Optimize SQL Databases (20-40% savings on SQL)

Right-size SQL databases and use elastic pools.

```powershell
# Analyze SQL database utilization
./scripts/right-sizing/analyze-sql-utilization.ps1

# Elastic pool opportunity analysis
./scripts/right-sizing/analyze-elastic-pool-savings.ps1
```

**Real example:** Client had 50 SQL databases, consolidated to 3 elastic pools, saved $28k/month.

---

### 8. Network Cost Optimization (10-25% savings on networking)

Eliminate unnecessary network charges.

```powershell
# Find network cost leaks
./scripts/network-optimization/find-network-waste.ps1

# Common issues:
# - Unused VPN gateways ($150/month each)
# - Over-provisioned ExpressRoute circuits
# - Cross-region data transfer costs
# - Unused Application Gateways
```

---

### 9. Azure Hybrid Benefit (40-55% savings on Windows/SQL)

Use existing Windows Server and SQL Server licenses.

```powershell
# Identify eligible resources
./scripts/licensing/azure-hybrid-benefit-analyzer.ps1

# Apply licenses programmatically
./scripts/licensing/apply-hybrid-benefit.ps1
```

**Real example:** Client saved $340k annually by applying Hybrid Benefit to 800 Windows VMs.

---

### 10. Enforce Tagging for Chargeback (Visibility = Savings)

Can't optimize what you can't see.

```powershell
# Deploy tagging policy
terraform apply -target="azurerm_policy_assignment.require_tags"

# Audit tag compliance
./scripts/governance/audit-tag-compliance.ps1
```

**Result:** Clear visibility into which departments/projects spend money → Accountability → Savings

---

## 📊 Cost Analysis Dashboards

### Executive Dashboard

Shows:
- Monthly spend trends (12 months)
- Top 10 cost drivers
- Savings opportunities identified
- Savings realized YTD
- Projected annual savings

### Operational Dashboard

Shows:
- Resource utilization heatmap
- Orphaned resources count
- Right-sizing opportunities
- Reserved Instance utilization
- Storage tier distribution

### Department Chargeback

Shows:
- Cost by department/cost center
- Cost per user/resource
- Trend analysis
- Budget vs actual
- Cost allocation reports

---

## 💼 Case Studies

### Case Study 1: Financial Services Firm

**Profile:** 500 VMs, $180k/month Azure spend  
**Duration:** 3 months  
**Savings:** 42% = $76k/month = **$912k/year**

**Optimizations:**
- Right-sized 180 oversized VMs: $28k/month
- Deleted 94 orphaned disks: $4.2k/month
- Implemented RIs for 60% of workload: $32k/month
- Auto-shutdown for 150 dev VMs: $8k/month
- Storage tier optimization: $3.8k/month

---

### Case Study 2: Healthcare Organization

**Profile:** 2,000 VMs, $450k/month Azure spend  
**Duration:** 6 months  
**Savings:** 38% = $171k/month = **$2.05M/year**

**Optimizations:**
- Azure Hybrid Benefit: $62k/month
- 3-year RIs for production: $48k/month
- SQL elastic pool consolidation: $22k/month
- Network rationalization: $18k/month
- Orphaned resource cleanup: $11k/month
- Right-sizing: $10k/month

---

### Case Study 3: Government Contractor (FedRAMP)

**Profile:** FedRAMP High environment, $280k/month  
**Duration:** 4 months  
**Savings:** 31% = $87k/month = **$1.04M/year**

**Note:** FedRAMP environments have less optimization flexibility

**Optimizations:**
- Reserved Instances: $35k/month
- Azure Hybrid Benefit: $18k/month
- Right-sizing (within compliance): $12k/month
- Storage optimization: $15k/month
- Network optimization: $7k/month

---

## 🎓 Implementation Guide

### Phase 1: Discovery (Week 1-2)

1. Run comprehensive cost assessment
2. Identify quick wins (orphaned resources)
3. Document top 20 cost drivers
4. Establish baseline metrics

### Phase 2: Quick Wins (Week 3-4)

1. Delete orphaned resources (immediate savings)
2. Implement basic tagging
3. Right-size obvious outliers
4. Enable auto-shutdown for dev/test

### Phase 3: Strategic Optimization (Month 2-3)

1. Implement Reserved Instances / Savings Plans
2. Deploy storage lifecycle policies
3. Apply Azure Hybrid Benefit
4. Consolidate SQL databases

### Phase 4: Automation (Month 4+)

1. Deploy cost control policies
2. Automate monthly optimization scans
3. Set up savings tracking dashboards
4. Establish governance processes

### Phase 5: Continuous Optimization (Ongoing)

1. Monthly cost review meetings
2. Quarterly deep-dive analysis
3. Annual RI/license renewal planning
4. Continuous policy refinement

---

## 📋 Monthly Cost Review Template

```markdown
# Azure Cost Review - [Month Year]

## Executive Summary
- Total Spend: $XXX,XXX
- Change vs Last Month: +/- X%
- Savings Realized: $XX,XXX
- Savings Opportunities Identified: $XX,XXX

## Top 10 Cost Drivers
1. [Service] - $XX,XXX
2. [Service] - $XX,XXX
...

## Savings Opportunities Found This Month
1. [Opportunity] - Estimated $X,XXX/month
2. [Opportunity] - Estimated $X,XXX/month
...

## Savings Implemented This Month
1. [Action taken] - Actual $X,XXX/month saved
2. [Action taken] - Actual $X,XXX/month saved
...

## Next Month Priorities
1. [Priority 1]
2. [Priority 2]
...
```

---

## 🛠️ Tools Included

### PowerShell Scripts (20+)

- Cost analysis and reporting
- Resource utilization analysis
- Orphaned resource detection
- Right-sizing recommendations
- Reserved Instance analysis
- Automated optimization actions

### KQL Queries (15+)

- Cost analytics queries
- Utilization analysis
- Trend detection
- Anomaly detection
- Chargeback queries

### Terraform Modules (10+)

- Cost control policies
- Budget alerts
- Resource tagging enforcement
- Auto-shutdown configuration
- Storage lifecycle policies

### Azure Policies (15+)

- Tagging enforcement
- SKU restrictions
- Region restrictions
- Resource limits
- Cost compliance rules

---

## 📈 Expected Results

### Conservative Estimate (First Year)

- **Month 1-2:** 5-10% savings (quick wins)
- **Month 3-4:** 15-25% savings (right-sizing, RIs)
- **Month 5-6:** 25-35% savings (full optimization)
- **Month 7-12:** 30-40% savings (sustained)

### Aggressive Estimate (With Full Commitment)

- **Month 1-2:** 10-15% savings
- **Month 3-4:** 25-35% savings
- **Month 5-6:** 35-45% savings
- **Month 7-12:** 40-50% savings

---

## ⚠️ Important Considerations

### What This Toolkit Does NOT Do

- ❌ Replace Azure Cost Management (complements it)
- ❌ Guarantee specific savings (varies by environment)
- ❌ Work without proper permissions (requires Reader+ roles)
- ❌ Optimize without business context (review before deleting)
- ❌ Replace human decision-making (recommends, doesn't delete)

### Before Running Scripts

1. **Backup critical data** before any deletion
2. **Test in non-production** first
3. **Review recommendations** before implementing
4. **Get stakeholder approval** for major changes
5. **Monitor for business impact** after changes

---

## 🤝 Contributing

Contributions welcome! See [CONTRIBUTING.md](CONTRIBUTING.md).

**Especially needed:**
- Additional optimization scripts
- Industry-specific recommendations
- Case studies and examples
- Dashboard improvements
- Documentation enhancements

---

## 📝 License

MIT License - see [LICENSE](LICENSE) file.

---

## 🙋 Need Help?

**Free Resources:**
- 📖 [Azure Cost Optimization Guide](https://mhartson.com/insights/azure-cost-optimization)
- 📥 [Cloud Security Starter Kit](https://mhartson.com/resources/starter-kit)
- 💬 [Hartson Security Guild Community](https://hartson-security-guild.circle.so)

**Professional Services:**
- 💰 Comprehensive cost optimization assessment
- 📊 Implementation services
- 🎓 FinOps training and enablement
- 📈 Ongoing optimization advisory

**[Book a cost optimization call →](https://mhartson.com/consulting)**

---

## 🎯 Why Choose This Toolkit

### vs Azure Advisor (Built-in)

| Feature | Azure Advisor | This Toolkit |
|---------|--------------|-------------|
| Coverage | Generic recommendations | Production-tested optimizations |
| Depth | Surface-level | Deep analysis |
| Customization | Limited | Fully customizable |
| Automation | Manual actions | Automated implementations |
| Case Studies | None | Real savings examples |

### vs Third-Party Tools (CloudHealth, Cloudability)

| Feature | Third-Party Tools | This Toolkit |
|---------|------------------|-------------|
| Cost | $50k-$500k/year | Free |
| Customization | Limited | Unlimited |
| Data Residency | External | Your subscription |
| FedRAMP Compatible | Varies | Yes |
| Vendor Lock-in | High | None |

---

## 🔗 Related Projects

- [Azure-Landing-Zones](https://github.com/mhartson310/Azure-Landing-Zones) - Build right from the start
- [FedRAMP-Azure-Toolkit](https://github.com/mhartson310/FedRAMP-Azure-Toolkit) - Compliance automation
- [Sentinel-KQL-Library](https://github.com/mhartson310/Sentinel-KQL-Library) - Security analytics

---

**Built with 💰 by [Mario Hartson](https://mhartson.com)** | Cloud Security & Cost Optimization | 15+ years saving organizations millions

📧 mario@hartsonadvisory.com | 💼 [LinkedIn](https://linkedin.com/in/mariohartson) | 🌐 [mhartson.com](https://mhartson.com)
