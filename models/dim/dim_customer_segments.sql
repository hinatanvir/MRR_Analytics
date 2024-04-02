-- models/dim/dim_customer_segments.sql
{{ config(materialized='view') }}

WITH stg_customers AS (
    SELECT
        customer_id,
        UPPER(name) AS name,
        LOWER(email) AS email,
        signup_date::DATE as signup_date,
        demographic_segment,
        geographic_location
    FROM {{ ref('src_customers') }}
)

SELECT
    customer_id,
    name,
    email,
    signup_date,
    -- Assuming you're using Snowflake, BigQuery, or Redshift which supports DATEDIFF
    DATEDIFF('day', signup_date, CURRENT_DATE()) AS tenure_days, -- Customer tenure in days
    demographic_segment AS customer_segment, -- Simplified segmentation
    CASE
        WHEN geographic_location IN ('US-East', 'US-West') THEN 'US'
        WHEN geographic_location IN ('EU-Central', 'EU-North') THEN 'EU'
        ELSE geographic_location
    END AS region_segment -- Geographical segmentation
FROM stg_customers