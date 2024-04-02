-- models/src/payments.sql

{{ config(materialized='view') }}

WITH payment_cte AS (

    SELECT
        transaction_id,
        customer_id,
        transaction_date::DATE as transaction_date, -- Ensuring the data type is DATE
        transaction_amount::FLOAT as transaction_amount, -- Ensuring the data type is FLOAT
        CASE 
            WHEN transaction_status = 'Success' THEN 'Successful'
            WHEN transaction_status = 'Fail' THEN 'Failed'
            ELSE transaction_status
        END as transaction_status
    FROM {{ source('mrr_playbook', 'payments') }}

)

SELECT
    *
FROM payment_cte
