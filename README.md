# Data Engineer Assesment for Perqara

**NOTE:** gitignore normally includes `.env`, but in this particular case, it is intentionally excluded. 

```
docker compose build
docker compose up -d
docker compose run --workdir="//usr/app" etl-app init.sh
```