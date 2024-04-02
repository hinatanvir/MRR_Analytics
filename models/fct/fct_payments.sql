-- models/fct/fct_payments.sql

{{ config(materialized='view') }}

SELECT
    transaction_id,
    subscription_id,
    customer_id,
    transaction_date::DATE as transaction_date, -- Ensuring data type consistency
    transaction_amount::FLOAT as transaction_amount, -- Convert amount to a float for aggregation
    transaction_status
FROM {{ ref('src_payments') }}
