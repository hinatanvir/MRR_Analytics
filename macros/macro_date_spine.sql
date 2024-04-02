{% macro generate_date_series(start_date, end_date) %}
    WITH date_series AS (
        SELECT 
            DATEADD(day, SEQ4(), '{{ start_date }}') as date
        FROM TABLE(GENERATOR(ROWCOUNT => DATEDIFF(day, '{{ start_date }}', '{{ end_date }}')))
        WHERE date <= '{{ end_date }}'
    )
    SELECT * FROM date_series
{% endmacro %}
