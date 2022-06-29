FROM alpine

MAINTAINER ${LOGIN}

#install mariadb
RUN apk update \
&& apk update \
&& apk add mysql mysql-client
#&& apk add mariadb mariadb-common mariadb-client

#clean image
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#config mariadb
COPY conf/config.sh config.sh

RUN mkdir -p /run/mysqld \
&& chown -R mysql:mysql /run/mysqld

ENTRYPOINT ["sh", "config.sh"]
