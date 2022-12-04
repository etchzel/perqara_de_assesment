FROM python:3.10.7-slim-bullseye

COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

COPY init.sh /init.sh

ENTRYPOINT [ "bash", "init.sh" ]