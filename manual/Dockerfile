FROM python:3.10.7-slim-bullseye

# System setup
RUN apt-get update \
  && apt-get dist-upgrade -y \
  && apt-get install -y --no-install-recommends \
    git \
    ssh-client \
    software-properties-common \
    make \
    build-essential \
    ca-certificates \
    libpq-dev \
    postgresql-client \
  && apt-get clean \
  && rm -rf \
    /var/lib/apt/lists/* \
    /tmp/* \
    /var/tmp/*

ENV PYTHONIOENCODING=utf-8
ENV LANG=C.UTF-8

# Update python
RUN python -m pip install --upgrade pip setuptools wheel --no-cache-dir

COPY requirements.txt ./requirements.txt
RUN pip install -r requirements.txt

ENV APPHOME=/usr/app
WORKDIR /usr/app
VOLUME /usr/app

ENTRYPOINT [ "/bin/bash" ]