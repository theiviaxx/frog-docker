FROM python:2.7

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

# Config
RUN mkdir /config
WORKDir /config
COPY /config/requirements.txt /config/
RUN pip install -r /config/requirements.txt

# Project
RUN mkdir /src
WORKDIR /src
COPY /src /src
RUN mkdir /src/logs
COPY /config/frog_settings.py /config/
RUN frog_secret /src

# Copy Django Admin
RUN cp /usr/local/lib/python2.7/site-packages/django/contrib/admin/static/admin /src -R
