FROM debian:buster

RUN apt-get update -y \
&& apt-get install curl -y \
&& curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar #client wp

RUN apt-get install -y	php7.3-cli \
						php7.3-common \
						php7.3-curl \
						php7.3-mbstring \
						php7.3-mysql \
						php-fpm curl \
						mariadb-client \
						wget

# update wp
RUN chmod +x wp-cli.phar \
&&	mv wp-cli.phar /usr/local/bin/wp \
&&	wp cli update

COPY conf/init.sh .
COPY conf/www.conf /etc/php/7.3/fpm/pool.d

RUN chmod +x init.sh \
&&  mkdir -p /var/run/ \
&&  mkdir -p /run/php/

EXPOSE 9000

ENTRYPOINT ["bash", "init.sh"]

#launch mysql
CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize", "--allow-to-run-as-root"]
