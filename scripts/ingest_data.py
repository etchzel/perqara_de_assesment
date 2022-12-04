from sqlalchemy import create_engine
import pandas as pd
import argparse
import os
import glob
import re

dataset_path = '../dataset/'

def main(params):
    # parametrizes db connection config
    user = params.user
    password = params.password
    host = params.host
    port = params.port
    db = params.db

    engine = create_engine(f'postgresql://{user}:{password}@{host}:{port}/{db}')

    # create schema layers
    with engine.connect() as conn:
        conn.execute("CREATE SCHEMA IF NOT EXISTS raw;")
        conn.execute("CREATE SCHEMA IF NOT EXISTS clean;")
        conn.execute("CREATE SCHEMA IF NOT EXISTS mart;")
        print("Created schema layer for the data warehouse")
    
        print("Loading data")
        print(dataset_path)
        # glob dataset files and load to data warehouse
        for file in glob.glob(dataset_path + '*'):
            table_name = re.split(r"\W+", file)[-2]
            try:
                pd.read_csv(file).to_sql(name=table_name, con=conn, schema='raw', if_exists='replace')
                print(table_name + " loaded successfully")
            except:
                print('load error')


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    parser.add_argument('--user', help='user name for postgres')
    parser.add_argument('--password', help='password for postgres')
    parser.add_argument('--host', help='host for postgres')
    parser.add_argument('--port', help='port for postgres')
    parser.add_argument('--db', help='database name for postgres')

    args = parser.parse_args()

    main(args)
