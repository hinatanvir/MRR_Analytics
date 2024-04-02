{% snapshot scd_customer_subscriptions %}

{{  config(
      target_schema='DEV',
      unique_key='subscription_id',
      strategy='timestamp',
      updated_at='last_updated_at',
      invalidate_hard_deletes=True
)
}}

SELECT
    subscription_id,
    customer_id,
    start_date,
    end_date,
    monthly_amount,
    CURRENT_TIMESTAMP as last_updated_at
FROM {{ ref('subscription_periods') }}

{% endsnapshot %}
