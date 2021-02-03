# pull official base image
FROM dorowu/ubuntu-desktop-lxde-vnc:xenial

# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1
ENV DEBIAN_FRONTEND=noninteractive

# tzdata hack
RUN ln -fs /usr/share/zoneinfo/Europe/Rome /etc/localtime

# update system
RUN apt-get update
RUN apt-get install git build-essential libglib2.0-dev libboost-regex-dev libedit-dev \
	libmagickcore-dev python-dev python-pexpect python-dbus python-gobject gawk libtool autoconf automake \
	debhelper libboost-dev flex libpng16-16 libxml2-dev graphviz imagemagick gnuplot python-pyside* \
	tesseract-ocr --yes --fix-missing

# build project
WORKDIR /opt
COPY . /opt/fMBT/
WORKDIR /opt/fMBT
RUN ./autogen.sh; ./configure; make; make install 
