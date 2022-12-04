#!/usr/bin/env bash

python app/ingest_data.py \
    --user=$POSTGRES_USER \
    --password=$POSTGRES_PASSWORD \
    --host=$DATABASE_HOST \
    --port=5432 \
    --db=$POSTGRES_DB