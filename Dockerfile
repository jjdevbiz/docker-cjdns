FROM debian:stable

ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

ENV VER_NUM 4.2.1
ENV VER $VER_NUM-linux-x64
ENV GPG_KEY DD8F2338BAE7501E3DD5AC78C273792F7D83545D
ENV GPG_FINGERPRINT 'EF6E 286D DA85 EA2A 4BA7  DE68 4E2C 6E87 9329 8290'
ENV CHKSUM SHASUMS256.txt
ENV REPO https://github.com/hyperboria/cjdns.git
ENV PACKAGE node-v$VER.tar.gz
ENV SOURCE https://nodejs.org/dist/v$VER_NUM/$PACKAGE
ENV SOURCE_CHKSUM https://nodejs.org/dist/v$VER_NUM/
ENV SOURCE_CHKSUM_ASC https://nodejs.org/dist/v$VER_NUM/$CHKSUM.asc
ENV DEPENDENCY 'git build-essential python2.7 wget tar'
ENV USER docker
ENV USER_HOME /opt/node-v$VER

RUN apt-get update
RUN apt-get upgrade -y -q

RUN apt-get -y -q install $DEPENDENCY

WORKDIR /opt

RUN git clone $REPO
RUN wget $SOURCE
RUN wget $SOURCE_CHKSUM
RUN wget $SOURCE_CHKSUM_ASC
#RUN gpg --keyserver pool.sks-keyservers.net --recv-keys
#RUN gpg --verify -v $CHKSUM.asc
#RUN grep $PACKAGE $CHKSUM | sha256sum -c -

RUN tar xvf node-v$VER.tar.gz
RUN cd node-v$VER
RUN cp -av * /

WORKDIR /opt/cjdns

RUN ./do

#RUN mkdir -p /dev/net
#RUN mknod /dev/net/tun c 10 200
#RUN chmod 0666 /dev/net/tun
#RUN cat /dev/net/tun
RUN ./cjdroute --genconf >> $USER_HOME/cjdroute.conf

RUN useradd -m -d $USER_HOME docker

#ADD conf $USER_HOME

VOLUME ["$USER_HOME"]

USER docker
WORKDIR $USER_HOME

#CMD ["./cjdroute","<","cjdroute.conf",">","cjdroute.log"]
