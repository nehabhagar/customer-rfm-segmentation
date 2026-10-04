-- =====================================================================
-- Project: Customer RFM Segmentation & Churn Risk Analysis
-- Database: MySQL
-- Description: Aggregates customer transactional data, calculates
--              Recency, Frequency, Monetary (RFM) metrics, applies
--              statistical quintiles via NTILE(5), and maps behavioral tiers.
-- =====================================================================

-- Step 1: Base RFM Calculation
WITH customer_rfm_raw AS (
    SELECT 
        customer_id,
        customer_name,
        segment,
        DATEDIFF('2024-12-31', MAX(order_date)) AS recency,
        COUNT(DISTINCT order_id) AS frequency,
        ROUND(SUM(sales), 2) AS monetary
    FROM orders
    GROUP BY customer_id, customer_name, segment
),

-- Step 2: Quintile Scoring using NTILE(5)
rfm_scores AS (
    SELECT 
        customer_id,
        customer_name,
        segment,
        recency,
        frequency,
        monetary,
        NTILE(5) OVER (ORDER BY recency DESC) AS r_score,     -- Higher score = more recent
        NTILE(5) OVER (ORDER BY frequency ASC) AS f_score,     -- Higher score = more frequent
        NTILE(5) OVER (ORDER BY monetary ASC) AS m_score       -- Higher score = higher spend
    FROM customer_rfm_raw
)

-- Step 3: Segmentation Logic
SELECT 
    customer_id,
    customer_name,
    segment,
    recency,
    frequency,
    monetary,
    r_score,
    f_score,
    m_score,
    CONCAT(r_score, f_score, m_score) AS rfm_combined,
    CASE 
        WHEN r_score >= 4 AND f_score >= 4 AND m_score >= 4 THEN 'Champions'
        WHEN r_score >= 3 AND f_score >= 3 AND m_score >= 3 THEN 'Loyal Customers'
        WHEN r_score >= 4 AND f_score <= 2 THEN 'Promising / New'
        WHEN r_score >= 3 AND f_score >= 2 AND m_score >= 2 THEN 'Potential Loyalists'
        WHEN r_score <= 2 AND f_score >= 3 AND m_score >= 3 THEN 'At Risk'
        WHEN r_score <= 2 AND f_score <= 2 AND m_score >= 3 THEN 'Customers Needing Attention'
        ELSE 'Lost / Hibernating'
    END AS customer_rfm_segment
FROM rfm_scores
ORDER BY monetary DESC;
