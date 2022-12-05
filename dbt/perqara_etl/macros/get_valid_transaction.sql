{#
    This macro returns list of order_status where the order is considered valid
#}

{% macro get_valid_transaction_status() -%}
    {%- set valid_status = ["shipped", "delivered"] -%}
    {% for status in valid_status %}
        '{{ status }}'{{ ", " if not loop.last else "" }}
    {% endfor %}
{%- endmacro %}