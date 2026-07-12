# Data Cleaning Process (Excel)

The raw dataset was validated and cleaned in Excel before analysis. The following checks were performed:

## 1. Missing Values
Used Conditional Formatting (Highlight Cell Rules → Blanks) to scan all columns for missing data.
Result: missing values only appear in `churn_date` and `churn_reason` — expected, since these are blank for customers who have not churned.

## 2. Duplicate Customer IDs
Used Data → Remove Duplicates on the `customer_id` column.
Result: 0 duplicates found.

## 3. Logical Consistency Check
Added a helper column with the formula:
```
=IF(AND(churn_date<>"", churn_date<signup_date), "ERROR", "OK")
```
Result: 0 rows where churn date occurred before signup date.

## 4. Data Quality Issue Found: Missing Churn Dates
Added a helper column with the formula:
```
=IF(AND(churn_flag=1, churn_date=""), "MISSING", "OK")
```
Result: **311 churned customers (~1.2% of churned records) had no churn date** — caused by customers who churned within their first signup month.

## 5. Fix Applied
For each flagged row, a churn date was assigned between the customer's signup date and the dataset snapshot date (June 30, 2026), and a churn reason was filled in from the existing category list where blank.

## 6. Range / Outlier Checks
Spot-checked key numeric columns using MIN/MAX formulas:
- `mrr`: no negative values
- `nps_score`: within valid 0–10 range
- `csat_score`: within valid 1–5 range

## Result
The cleaned dataset was saved and used as the source file for all downstream analysis (Python EDA and Power BI dashboard).
