-- ============================================================
-- SaaS Customer Churn & Revenue Analytics — Database Schema
-- ============================================================

CREATE TABLE dim_customers (
    customer_id     TEXT PRIMARY KEY,
    signup_date     DATE NOT NULL,
    region          TEXT,
    industry        TEXT,
    company_size    TEXT
);

CREATE TABLE fact_subscriptions (
    customer_id     TEXT PRIMARY KEY,
    plan_tier       TEXT,
    contract_type   TEXT,
    mrr             REAL,
    discount_pct    REAL,
    tenure_months   INTEGER,
    upsell_count    INTEGER,
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id)
);

CREATE TABLE fact_usage (
    customer_id             TEXT PRIMARY KEY,
    logins_last_30_days     INTEGER,
    last_login_days_ago     INTEGER,
    feature_adoption_pct    REAL,
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id)
);

CREATE TABLE fact_support (
    customer_id                     TEXT PRIMARY KEY,
    support_tickets_last_90d        INTEGER,
    avg_ticket_resolution_hrs       REAL,
    payment_failures_last_12mo      INTEGER,
    nps_score                       INTEGER,
    csat_score                      REAL,
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id)
);

CREATE TABLE fact_churn (
    customer_id     TEXT PRIMARY KEY,
    churn_flag      INTEGER,
    churn_date      DATE,
    churn_reason    TEXT,
    FOREIGN KEY (customer_id) REFERENCES dim_customers(customer_id)
);
