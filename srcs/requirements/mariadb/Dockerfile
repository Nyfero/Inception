FROM alpine

MAINTAINER ${USER}

#install mariadb
RUN apk update \
&& apk update \
&& apk add mariadb mariadb-common mariadb-client

#RUN /etc/init.d/mariadb setup
#RUN rc-service mariadb start
#RUN rc-update add mariadb default
#RUN rc-status default

#clean image
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
