FROM debian:buster

RUN apt-get update -y \
	&& apt-get -y upgrade \
	&& apt-get install mariadb-server -y

COPY conf/init.sh .
COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld \
	&& mkdir -p /run/mysqld \
	&& chown -R mysql:root /run/mysqld \
	&& chown -R mysql:root /var/run/mysqld \
	&& touch /var/run/mysqld/mysqld.sock \
	&& chmod +x init.sh

EXPOSE 3306

ENTRYPOINT ["sh", "init.sh"]
CMD ["mysqld_safe"]
