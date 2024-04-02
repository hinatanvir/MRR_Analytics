-- models/mart/mart_customer_payment_analysis.sql

{{ config(materialized='table') }}

WITH payment AS (
    SELECT
        p.transaction_date,
        p.transaction_amount,
        p.transaction_status,
        c.customer_segment,
        CASE 
            WHEN p.transaction_status = 'Successful' THEN p.transaction_amount
            ELSE 0
        END AS successful_transaction_amount,
        CASE 
            WHEN p.transaction_status = 'Failed' THEN p.transaction_amount
            ELSE 0
        END AS failed_transaction_amount,
        p.transaction_id  -- Ensure transaction_id is included in the CTE
    FROM {{ ref('fct_payments') }} AS p
    JOIN {{ ref('dim_customer_segments') }} AS c ON p.customer_id = c.customer_id
),

monthly_payment_revenue AS (
    SELECT
        DATE_TRUNC('MONTH', transaction_date) AS revenue_month,
        customer_segment,
        SUM(transaction_amount) AS total_revenue,
        SUM(successful_transaction_amount) AS total_successful_revenue,
        SUM(failed_transaction_amount) AS total_failed_revenue,
        COUNT(DISTINCT CASE WHEN transaction_status = 'Successful' THEN transaction_id END) AS count_successful_transactions,
        COUNT(DISTINCT CASE WHEN transaction_status = 'Failed' THEN transaction_id END) AS count_failed_transactions
    FROM payment
    GROUP BY 1, 2
)

SELECT *
FROM monthly_payment_revenue
