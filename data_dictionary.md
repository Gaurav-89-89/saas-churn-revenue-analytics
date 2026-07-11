# Data Dictionary — SaaS Customer Churn & Revenue Dataset

**File:** `saas_customer_churn_dataset.csv`
**Rows:** 26,000 customers
**Snapshot date:** 2026-06-30 (treat this as "today" for tenure/age calculations)
**Overall churn rate:** ~9.6%

| Column | Type | Description |
|---|---|---|
| `customer_id` | string | Unique customer identifier |
| `signup_date` | date | Date the customer subscribed |
| `region` | category | North America / Europe / APAC / LATAM |
| `industry` | category | Customer's industry vertical |
| `company_size` | category | Small (1-50) / Medium (51-500) / Large (500+) employees |
| `plan_tier` | category | Basic / Pro / Enterprise |
| `contract_type` | category | Monthly or Annual billing |
| `mrr` | float | Monthly Recurring Revenue for this customer (USD), net of discount |
| `discount_pct` | float | % discount applied to list price |
| `tenure_months` | int | Months since signup (as of snapshot date) |
| `logins_last_30_days` | int | Product logins in the last 30 days |
| `last_login_days_ago` | int | Days since last login |
| `feature_adoption_pct` | float | % of available features actively used |
| `support_tickets_last_90d` | int | Support tickets raised in the last 90 days |
| `avg_ticket_resolution_hrs` | float | Average time to resolve support tickets |
| `payment_failures_last_12mo` | int | Failed payment/billing attempts in last 12 months |
| `nps_score` | int (0-10) | Net Promoter Score, last survey |
| `csat_score` | float (1-5) | Customer satisfaction score, last survey |
| `upsell_count` | int | Number of upsells/expansions since signup |
| `churn_flag` | 0/1 | **Target variable** — 1 if customer has churned |
| `churn_date` | date or blank | Date of churn (blank if still active) |
| `churn_reason` | category or blank | Stated/inferred reason for churn (blank if still active) |

## Notes for analysis
- Built-in signal: churn correlates with low `feature_adoption_pct`, high `support_tickets_last_90d`,
  `contract_type = Monthly`, `payment_failures_last_12mo`, low `nps_score`, `plan_tier = Basic`,
  and very early tenure (`tenure_months < 3`).
- Good candidates for cohort analysis: group by `signup_date` (month) x `churn_flag` for retention curves.
- Good candidates for revenue analysis: `mrr` x `plan_tier` x `churn_flag` for revenue-at-risk / MRR waterfall.
- For NRR/GRR you can treat `upsell_count` and `mrr` changes as expansion revenue proxies.
- This is synthetic data generated to have realistic, discoverable patterns — safe to publish
  publicly in a portfolio/GitHub repo (no real customer data).
