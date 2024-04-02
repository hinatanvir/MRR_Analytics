-- models/src/customers.sql

{{ config(materialized='view') }}

WITH customer_cte AS (

    SELECT
        customer_id,
        UPPER(customer_name) as name,
        LOWER(contact_email) as email,
        signup_date::DATE as signup_date, -- Ensuring the data type is DATE
        demographic_segment,
        geographic_location
    FROM {{ source('mrr_playbook', 'customers') }}

)

SELECT
    *
FROM customer_cte
