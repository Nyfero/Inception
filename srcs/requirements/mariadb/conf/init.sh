# give the right to mysql to run (need to be done in case of restart)
mkdir -p /run/mysqld && chown -R mysql:mysql /run/mysqld

#check if mysql isn't install yet
if [ ! -d "var/lib/mysql/mysql" ]; then

  # install mysql
  # option basedir put the executable in /usr
  # option datadir put the data directory in /var/lib/mysql
  # option rpm defined option in /etc
  # Ressource:
  # https://mariadb.com/kb/en/mysql_install_db/
  # https://mariadb.com/kb/en/configuring-mariadb-with-option-files/
  mysql_install_db --basedir=/usr --datadir=/var/lib/mysql --rpm --defaults-file=/etc/config

fi

# modify mariadb config file

  # Allow to connect with port 3306 by voiding the option skip-networking
  sed -i "s|skip-networking|# skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

  # Allow server to accept connections on all interfaces.
  sed -i "s|#bind-address=0.0.0.0|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf

# launch mariadb
mysqld --user=root
