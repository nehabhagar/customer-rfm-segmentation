# Customer RFM Segmentation & Revenue Churn Analysis

An end-to-end data analytics project using **MySQL** and **Power BI** to segment 793 customer accounts across $1.23M+ in transactional revenue using Recency, Frequency, and Monetary (RFM) modeling.
![Power BI Dashboard Overview](Screenshot%202026-10-04%20091048.png)
---

## 📌 Project Overview
Customer retention is significantly more cost-effective than customer acquisition. This project evaluates multi-year order history to categorize customer purchase behavior, isolate revenue-at-risk accounts, and provide commercial and retention teams with actionable customer tiers.

---

## 🎯 Key Findings & Business Insights
- **Revenue Concentration:** **Champions** and **Loyal Customers** represent **42.6%** of the customer base and drive over **53% of overall revenue ($1.23M)**.
- **Churn Mitigation Priority:** Isolated **137 At-Risk customer accounts** accounting for **$478,000** in historical spend who have not purchased recently.
- **Actionable Retention Strategy:** Established 7 distinct behavioral segments to guide personalized outreach, reactivation discounts, and VIP loyalty incentives.

---

## 🛠️ Technical Stack & Methods
- **Database Engine:** MySQL Workbench
- **Analytical Methods:** Statistical quintile scoring using `NTILE(5)` and SQL Window Functions
- **Business Intelligence:** Microsoft Power BI Desktop (Star Schema Data Modeling, DAX Measures, Interactive Visuals)

---

## 📊 RFM Scoring Architecture

| Metric | Business Definition | SQL Calculation |
| :--- | :--- | :--- |
| **Recency** | Days since customer's most recent order | `DATEDIFF(reference_date, MAX(order_date))` |
| **Frequency** | Total count of distinct orders placed | `COUNT(DISTINCT order_id)` |
| **Monetary** | Cumulative gross spend per customer | `ROUND(SUM(sales), 2)` |

### Behavioral Tiers Defined:
1. **Champions:** High spenders who order frequently and purchased recently.
2. **Loyal Customers:** Consistent buyers with solid historical value.
3. **Potential Loyalists:** Recent buyers with average order frequency.
4. **Promising / New Customers:** Recent first-time or low-frequency buyers.
5. **Customers Needing Attention:** Moderate spenders whose purchase gap is widening.
6. **At Risk:** High-value historical spenders with long periods of inactivity.
7. **Lost / Hibernating:** Lowest recency and frequency scores.

---

## 📈 Power BI Dashboard Components
- **Executive KPI Cards:** Total Customer Base (793), Total Gross Sales ($1.23M), Average Order Value, Average Recency Gap.
- **Recency vs. Monetary Matrix:** Quadrant scatter plot pinpointing high-value churn risks.
- **Segment Contribution:** Treemaps and bar charts displaying revenue distribution across customer tiers.
- **Retention Action Directory:** Interactive data table allowing account managers to filter by segment and export target lists.

---

## 🚀 How to Run This Project
1. Execute the scripts in the `/sql` directory inside MySQL Workbench to generate the base tables and RFM views.
2. Load the output dataset into Power BI Desktop.
3. Review the DAX measures and interactive dashboard layouts.
