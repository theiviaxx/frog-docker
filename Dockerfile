FROM python:2.7

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED 1

# FFMPEG
#RUN apt-get -y install software-properties-common
#RUN add-apt-repository ppa:mc3man/trusty-media
#RUN apt-get update
#RUN apt-get -y dist-upgrade
#RUN apt-get install -y ffmpeg

# video service
#COPY ./video_worker /etc/systemd/system/video_worker

# Config
RUN mkdir /config
WORKDir /config
COPY /config/requirements.txt /config/
RUN pip install -r /config/requirements.txt

# Project
RUN mkdir /src;
WORKDIR /src;
COPY /src /src
RUN frog_secret /src
