# Frog Docker

This repo holds the install steps for use with docker.  There is a single Dockerfile that builds the app for Frog itself and then adds nginx and postgres to host it.  This is by far the easiest way to get up and runnign with Frog with minimal config or effort.

## Prerequisites

* docker and docker-compose


## Installation

```
$ git clone git@github.com:theiviaxx/frog-docker.git
$ git submodule update --init --recursive
$ docker-compose up --build
```

That's it.  This might take some time at first as it will need to download other docker images and also grab ffmpeg.  Once it is complete, it should start hosting of port `:80` immediately.

## Config

There isn't a whole lot to configure, but what there is it's in the `config/frog_settings.py` file in this repo.  Simply edit the values you need and then run it again as above.

The one setting of note would be `ALLOWED_HOSTS`, add the server IP in that list as well as the hostname if available.

## Notes

### Storage Path

One of the main things you may need to configure differently is the statis file storage location.  Using this repo as-is, it will store everything in a directory called `static` under the repo.  If you want to change that, simply make a symlink to your preferred location.

For example, say we have our repo at `/opt/frog-docker` and our storage mount is at `/mnt/my_storage`, you would create a symlink with:

```
$ sudo ln -s /mnt/my_storage /opt/frog-docker/static
```

And then start the server as before with the `docker-compose up --build` command

### Port

By defualt this assumes it will be hosting on port `:80`.  TO change this, simply edit the `docker-compose.yml` file under the `nginx/ports` section.  For example, if oyu wanted to host it on port `:8000` just change that section to something like this:

```
services:  
  nginx:
    image: nginx:latest
    container_name: ng01
    ports:
      - "80:8000"
```
