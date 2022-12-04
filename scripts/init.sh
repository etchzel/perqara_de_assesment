#!/usr/bin/env bash

dbt init --project-dir "//usr/app/dbt" perqara_etl -s

python scripts/ingest_data.py \
    --user=$POSTGRES_USER \
    --password=$POSTGRES_PASSWORD \
    --host=$DATABASE_HOST \
    --port=5432 \
    --db=$POSTGRES_DB
