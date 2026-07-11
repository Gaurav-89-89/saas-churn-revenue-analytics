-- ============================================================
-- SaaS Customer Churn Analysis — Simple SQL Queries
-- ============================================================

-- 1. Overall churn rate
-- Result: 9.62%
SELECT ROUND(AVG(churn_flag) * 100, 2) AS churn_rate_pct
FROM fact_churn;


-- 2. Churn rate by plan tier
-- Result: Basic 11.66% | Pro 8.40% | Enterprise 6.83%
SELECT plan_tier, ROUND(AVG(churn_flag) * 100, 2) AS churn_rate_pct
FROM fact_subscriptions s
JOIN fact_churn c ON s.customer_id = c.customer_id
GROUP BY plan_tier
ORDER BY churn_rate_pct DESC;


-- 3. Total revenue lost to churn
-- Result: $457,926
SELECT ROUND(SUM(mrr), 2) AS mrr_lost
FROM fact_subscriptions s
JOIN fact_churn c ON s.customer_id = c.customer_id
WHERE c.churn_flag = 1;


-- 4. Low usage vs high usage churn comparison
SELECT
    CASE WHEN feature_adoption_pct < 30 THEN 'Low Usage' ELSE 'High Usage' END AS usage_group,
    ROUND(AVG(churn_flag) * 100, 2) AS churn_rate_pct
FROM fact_usage u
JOIN fact_churn c ON u.customer_id = c.customer_id
GROUP BY usage_group;
