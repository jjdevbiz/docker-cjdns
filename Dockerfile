FROM ubuntu:latest

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV REPO https://github.com/hyperboria/cjdns.git
ENV NODEJS https://nodejs.org/dist/v4.2.1/node-v4.2.1-linux-x64.tar.gz

RUN apt-get update
RUN apt-get upgrade -y -q

RUN apt-get -y -q install nodejs git build-essential

RUN apt-get -y -q install git

WORKDIR /opt

RUN git clone $REPO

WORKDIR /opt/cjdns

RUN ./do
