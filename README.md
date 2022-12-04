# Data Engineer Assesment for Perqara

**NOTE:** gitignore normally includes `.env`, but in this particular case, it is intentionally excluded. 

```
docker compose build
docker compose up -d
docker compose run etl-app init.sh
```

```
docker compose run --workdir="//usr/app/dbt/perqara_etl/" --entrypoint=dbt etl-app debug
```