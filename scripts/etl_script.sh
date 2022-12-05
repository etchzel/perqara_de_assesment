#!bin/bash

# ingest data to db
python scripts/ingest_data.py \
    --user=$POSTGRES_USER \
    --password=$POSTGRES_PASSWORD \
    --host=$DATABASE_HOST \
    --port=5432 \
    --db=$POSTGRES_DB

# change directory to dbt
cd $APPHOME/dbt
pwd

# initialize dbt
dbt init perqara_etl -s

cd $APPHOME/dbt/perqara_etl
pwd

# install dbt packages
dbt deps

# test dbt connection
dbt debug

# build dbt models and run tests
dbt build

# dump postgres db
cd $APPHOME/db_dump
pwd
export PGPASSWORD=${POSTGRES_PASSWORD}
pg_dump -h $DATABASE_HOST -p 5432 -U $POSTGRES_USER -d $POSTGRES_DB > dwh_dump.pgsql
