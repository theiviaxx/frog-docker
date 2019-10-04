FROM python:3.7-stretch

ENV DEBIAN_FRONTEND noninteractive
ENV PYTHONUNBUFFERED 1

# FFMPEG
RUN echo deb http://www.deb-multimedia.org testing main non-free \
    >>/etc/apt/sources.list
RUN apt-get update
RUN apt-get -y remove ffmpeg
RUN apt-get -y install yasm nasm \
    build-essential automake autoconf \
    libtool pkg-config libcurl4-openssl-dev \
    intltool libxml2-dev libgtk2.0-dev \
    libnotify-dev libglib2.0-dev libevent-dev \
    checkinstall

WORKDIR /tmp
RUN wget http://www.ffmpeg.org/releases/ffmpeg-snapshot.tar.bz2
RUN tar jxvf ffmpeg-snapshot.tar.bz2
WORKDIR /tmp/ffmpeg
RUN ./configure --prefix=/usr
RUN make -j 8
RUN cat RELEASE
RUN checkinstall
RUN dpkg --install ffmpeg_*.deb

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
