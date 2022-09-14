FROM debian:buster

RUN apt-get update -yq \
&& apt-get install nginx openssl -yq

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 365 -nodes \
        -out /etc/nginx/ssl/nginx.crt \
        -keyout /etc/nginx/ssl/nginx.key \
        -subj "/C=FR/ST=Paris/L=Paris/O=42/CN=gsap.42.fr"

EXPOSE 443

COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

CMD ["nginx", "-g", "daemon off;"]
