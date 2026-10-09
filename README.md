# Azure Cost Optimization Toolkit

[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)
[![Azure](https://img.shields.io/badge/Azure-Cost_Optimization-0078D4?logo=microsoft-azure)](https://azure.microsoft.com/)
[![Maintained](https://img.shields.io/badge/Maintained-Yes-brightgreen.svg)](https://github.com/mhartson310/Azure-Cost-Optimization-Toolkit)

A practical Azure FinOps and cost-governance toolkit with scripts, KQL queries, policy patterns, and reporting examples for identifying waste, improving resource efficiency, and making optimization repeatable.

---

## What this demonstrates

- Azure cost-governance and FinOps architecture;
- identifying orphaned, idle, and oversized resources;
- policy-based cost guardrails;
- KQL and scripting for repeatable analysis;
- tagging, chargeback, and optimization workflows;
- balancing cost decisions with operational and security requirements.

## What this is

A reference implementation for turning Azure cost optimization into an engineering workflow rather than a one-time spreadsheet exercise. The focus is on repeatable discovery, governance, validation, and reporting.

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
- current spend analysis by service, region, or resource group;
- top cost drivers;
- candidate optimization opportunities;
- follow-up recommendations for review and validation.

### 3. Identify Quick Wins

```powershell
# Find orphaned resources and quantify current waste
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

## Optimization opportunities

The toolkit focuses on optimization categories that can be measured and validated before changes are made.

### 1. Right-size compute

Use utilization and workload requirements to identify oversized compute. Review CPU, memory, availability, performance, licensing, and scaling behavior before changing SKUs.

~~~powershell
./scripts/right-sizing/analyze-vm-utilization.ps1 -DaysToAnalyze 30
~~~

### 2. Remove orphaned and unused resources

Find unattached disks, unused public IPs, stale snapshots, empty resource groups, and resources with no clear owner.

~~~powershell
./scripts/orphaned-resources/find-all-orphaned.ps1
~~~

### 3. Evaluate reservations and savings plans

For stable workloads, compare commitment options against actual usage, growth expectations, and workload lifecycle.

~~~powershell
./scripts/reserved-instances/analyze-ri-opportunities.ps1
~~~

### 4. Schedule non-production workloads

Use shutdown/startup automation where business and operational requirements allow it.

~~~powershell
./scripts/automation/configure-auto-shutdown.ps1
~~~

### 5. Optimize storage lifecycle

Analyze access patterns before moving data between hot, cool, cold, or archive tiers. Include retrieval cost, minimum-retention requirements, and recovery expectations.

~~~powershell
./scripts/storage-optimization/analyze-blob-access.ps1
./scripts/storage-optimization/deploy-lifecycle-policies.ps1
~~~

### 6. Review database utilization

Look for idle capacity, consolidation candidates, elastic-pool opportunities, and workload-specific scaling options.

### 7. Review network cost drivers

Inspect unused gateways/public IPs, unnecessary cross-region traffic, architecture-related egress, and avoidable data-transfer patterns.

### 8. Evaluate licensing benefits

Where applicable, compare Azure Hybrid Benefit and other licensing options against the organization's actual entitlement and workload profile.

### 9. Enforce cost governance

Use tags, policy, budget ownership, and approved SKU/region patterns so optimization is not undone by future deployments.

### 10. Measure realized outcomes

Track recommendations separately from implemented changes and realized savings. A recommendation is not a saving until the change is deployed and the billing data confirms the effect.

## Validation scenarios

Rather than relying on fixed savings percentages, validate the toolkit against your own environment:

- What resources are idle or orphaned?
- Which workloads are consistently over-provisioned?
- Which commitments match stable usage?
- Which non-production resources can be scheduled safely?
- Which storage data has a lifecycle pattern that supports tiering?
- Which optimization opportunities conflict with security, resilience, compliance, or performance requirements?

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

## Measuring results

Use a before/after measurement model:

1. establish a billing and usage baseline;
2. record the recommendation and expected operational impact;
3. approve and implement the change;
4. compare actual cost and performance after the change;
5. record realized savings separately from forecast savings;
6. keep rollback criteria for changes that affect performance or resilience.

The value of the toolkit is the repeatable **decision and validation process**, not a universal savings percentage.

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

## Where this toolkit fits

Azure Advisor and third-party FinOps platforms can be valuable inputs. This repository is different: it provides transparent scripts, KQL, policy examples, and implementation patterns that teams can review, adapt, version, and run inside their own engineering workflow.

Use it when you want to:

- inspect the logic behind a recommendation;
- integrate cost controls with infrastructure-as-code and policy;
- keep optimization decisions reviewable in source control;
- connect FinOps decisions with security, governance, and platform architecture;
- build organization-specific automation instead of relying only on portal recommendations.

It is not a replacement for Azure Cost Management, Azure Advisor, billing data, or commercial FinOps platforms.

## 🔗 Related Projects

- [Azure-Landing-Zones](https://github.com/mhartson310/Azure-Landing-Zones) - Build right from the start
- [FedRAMP-Azure-Toolkit](https://github.com/mhartson310/FedRAMP-Azure-Toolkit) - Compliance automation
- [Sentinel-KQL-Library](https://github.com/mhartson310/Sentinel-KQL-Library) - Security analytics

---

**Mario Worwell** | Cloud Security Architect | Azure | FinOps | Governance

📧 mario@hartsonadvisory.com | 💼 [LinkedIn](https://linkedin.com/in/mariohartson) | 🌐 [mhartson.com](https://mhartson.com)
