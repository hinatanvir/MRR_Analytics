-- models/src/subscription_types.sql

{{ config(materialized='view') }}

WITH subscription_type_cte AS (

    SELECT
        subscription_type_id,
        subscription_type_name as type_name,
        subscription_benefits,
        price_per_month::FLOAT as price -- Ensuring the data type is FLOAT
    FROM {{ source('mrr_playbook', 'subscription_types') }}

)

SELECT
    *
FROM subscription_type_cte


