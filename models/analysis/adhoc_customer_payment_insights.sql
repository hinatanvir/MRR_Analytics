with revenue_failures as (
    select
        revenue_month,
        customer_segment,
        sum(total_failed_revenue) as total_failed_revenue,
        count_failed_transactions
    from {{ ref('mart_customer_payment_analysis') }}
    group by 1, 2
)

, ranked_failures as (
    select
        revenue_month,
        customer_segment,
        total_failed_revenue,
        count_failed_transactions,
        rank() over (
            partition by revenue_month
            order by total_failed_revenue desc
        ) as revenue_failure_rank
    from revenue_failures
)

select
    revenue_month,
    customer_segment,
    total_failed_revenue,
    count_failed_transactions
from ranked_failures
where revenue_failure_rank <= 3
order by
    revenue_month desc,
    revenue_failure_rank