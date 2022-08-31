#import alpine:3.15 from dockerhub
FROM alpine:3.15

#set a maintainer
LABEL maintainer="gsap@student.42.fr"

#update alpine and add mariadb package
RUN apk update && apk upgrade \
&& apk add mariadb mariadb-common

#clean image
RUN rm -rf /var/lib/cache/* /tmp/* /var/tmp/*

#import init script
COPY conf/init.sh /usr/bin/init.sh

#import mariadb config file
COPY conf/config /etc/config

#launch the script
ENTRYPOINT ["sh", "usr/bin/init.sh"]
