{#
    This macro normalizes unicode text and strip ascii
#}

{% macro unicode_text_normalize(unicode_text) -%}

    case
        when lower({{ unicode_text }}) ~ '[àáâäåãæçèéêëìíîïòóôöøùúûüÿœ]' then
            regexp_replace(
                regexp_replace(
                    regexp_replace(
                        regexp_replace(
                            regexp_replace(
                                replace(replace(replace(replace(lower({{ unicode_text }}), 'œ', 'ce'), 'ÿ', 'y'), 'ç', 'c'), 'æ', 'ae'),
                            '[ùúûü]', 'u', 'g'),
                        '[òóôöø]', 'o', 'g'),
                    '[ìíîï]', 'i', 'g'),
                '[èéêë]', 'e', 'g'),
            '[àáâäåã]', 'a', 'g')
        else
            lower({{ unicode_text }})
    end

{%- endmacro %}