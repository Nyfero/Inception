FROM debian:buster

RUN apt-get update -yq \
&& apt-get install nginx openssl -yq

#Configuration of Openssl for tcl/ssl communication
#We need to create a rsa key with the x509 norm and the sha256 hash algorithm
# -nodes (for no Des) will not encrypt the key with a passphrase (easiest to use with Nginx but lower security)
# https://www.digicert.com/kb/ssl-support/openssl-quick-reference-guide.htm#Usingthe-subjSwitch
# https://codingwithmanny.medium.com/configure-self-signed-ssl-for-nginx-docker-from-a-scratch-7c2bcd5478c6

RUN mkdir -p /etc/nginx/ssl
RUN openssl req -newkey rsa:2048 -x509 -sha256 -days 9999 -nodes \
        -out /etc/nginx/ssl/nginx.crt \
        -keyout /etc/nginx/ssl/nginx.key \
        -subj "/C=FR/ST=Clichy/L=Clichy/O=42/CN=fmonbeig.42.fr"

EXPOSE 443
COPY conf/nginx.conf /etc/nginx/conf.d/default.conf

#Launching Nginx in foreground to be more easily accessible
CMD ["nginx", "-g", "daemon off;"]
