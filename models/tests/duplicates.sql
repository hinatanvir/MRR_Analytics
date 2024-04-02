-- tests/duplicates.sql

{% macro duplicates(model, field) %}

SELECT 
    {{ field }}
FROM {{ model }}
GROUP BY {{ field }}
HAVING COUNT(*) > 1

{% endmacro %}
