FROM debian

MAINTAINER ${USER}

#install nginx
RUN apt-get update \
&& apt-get -y install nginx

#clean image
RUN apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

#lance nginx
ENTRYPOINT ["nginx", "-g", "daemon off;"]
