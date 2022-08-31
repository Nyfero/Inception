#import alpine:3.15 from dockerhub
FROM alpine:3.15

#set a maintainer
LABEL maintainer="gsap@student.42.fr"

#update alpine and add nginx package
RUN apk update && apk upgrade  \
&& apk add nginx openssl

RUN mkdir /etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 9999 -nodes \
-out /etc/nginx/ssl/gsap.pem \
-keyout /etc/nginx/ssl/gsap.key \
-subj "/C=FR/ST=Paris/L=Paris/O=42/CN=gsap.42.fr"

RUN mkdir -p /run/nginx
EXPOSE 443
COPY conf/nginx.conf /etc/nginx/conf.d/nginx.conf

#clean image
RUN rm -rf /var/lib/cache/* /tmp/* /var/tmp/*

ENTRYPOINT ["nginx", "-g", "deamon off;"]
