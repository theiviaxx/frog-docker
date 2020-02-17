FROM python:3.7-stretch

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED 1

# FFMPEG
RUN apt update
RUN apt -y install ffmpeg

# Frog Repo
RUN mkdir /opt/frog
COPY ./Frog /opt/frog
RUN pip install -e /opt/frog
# Additional packages for this container
RUN pip install psycopg2
RUN pip install gunicorn
RUN pip install whoosh

# Config
RUN mkdir /opt/config
COPY ./config /opt/config

# Project
RUN mkdir /opt/project
COPY ./project /opt/project
RUN mkdir /opt/project/dev/logs
COPY ./config/frog_settings.py /opt/project/dev/dev
RUN frog_secret /opt/project
