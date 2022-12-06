# Data Engineer Assesment for Perqara

My submission for Data Engineer Assesment for Perqara.

**NOTE:** gitignore normally includes `.env`, but in this particular case, it is intentionally excluded.

## Requirements

- Docker
- Docker compose

**NOTE:** `docker compose` command here uses Docker Compose V2, more info [here](https://docs.docker.com/compose/compose-v2/).

For Windows:

- WSL2 for Docker Desktop Backend

## Services

- Postgres 13 (as a Data Warehouse).
- PGAdmin (Web Service GUI for postgres).
- Python 3.10.7.
- dbt (Data Build Tool for transforming data in Data Warehouse).

**NOTE:** Normally Airflow should be included to orchestrate the ETL process but I opted to not include it to save some space.

## Pipeline Structure

The data pipeline is build according to the diagram below:

![perqara_etl](./images/perqara_etl.png)

Optionally you can add Airflow or a cron job to the services to orchestrate the pipeline

## Running instruction

- Clone this repo.

- Change directory to the cloned repo.

- Build the image first.

  ```bash
  docker compose build
  ```

- Next spin up the containers

  ```bash
  docker compose up -d
  ```

Since the entrypoint is set to run with `["/bin/bash", "scripts/etl_script.sh"]`, the script to run the ETL will automatically run after the container is spin up. The script also include dumping the DB data to [postgres/dump](./postgres/dump/) folder.

## PGAdmin setup

PGAdmin can be used to check the data, but there's a need to register the server first for first time login.

- In the login page, login into PGAdmin. Email is set to `admin@admin.com` and password to `root`.

- Next click on Add New Server

  ![add_server](./images/add_server.png)

- After that in the `General` tab, enter in the `Name` like below.

  ![add_server_general](./images/add_server_general.png)

- Finally, click on `Connection` tab and enter in the connection credentials as shown below. Password is `root`.

  ![add_server_connection](./images/add_server_connection.png)


## Manual Testing

For manual testing of the ETL App container, replace the Dockerfile in the main directory, then rebuild the image and spin up the container.

**NOTE:** Make sure previous container is already pruned before rerunning.

```bash
docker compose build
docker compose up -d
docker compose run etl-app
```

This will give access to the ETL App container terminal, next run whatever command.

Example to test dbt connection with the postgres database/datawarehouse:

- Outside of the container

  ```bash
  docker compose run --workdir="//usr/app/dbt/perqara_etl/" --entrypoint=dbt etl-app debug
  ```

  `etl-app` here is the service name as shown in the [docker-compose.yaml](docker-compose.yaml) file.

- Inside the container terminal

  ```bash
  cd /usr/app/dbt/perqara_etl
  dbt debug
  ```

  or if not initialized yet (or want to create new dbt project)

  ```bash
  cd /usr/app/dbt
  dbt init <project_name> -s
  ```

## Cleanup

- Take down the containers.

  ```bash
  docker compose down
  ```

- Remove all stopped containers.

  ```bash
  docker container prune
  ```

## Point of improvement

- Separate the container for dbt service with python ingestion.
- Add orchestration.
- Add unit tests to the python ingestion script.
- Add data integrity tests to dbt models.
- Add in data models documentation in `dbt/perqara_etl/models/<model_layer>/schema.yml` so the following dbt command can be run to generate docs.

  ```bash
  dbt docs generate
  dbt docs serve --port 8001
  ```