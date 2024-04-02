-- models/fct/fct_payments.sql

{{ config(materialized='view') }}

SELECT
    p.transaction_id,
    p.customer_id,
    p.transaction_date,
    p.transaction_amount,
    p.transaction_status,
    c.customer_segment
FROM {{ ref('src_payments') }} AS p
LEFT JOIN {{ ref('dim_customer_segments') }} AS c ON p.customer_id = c.customer_id
