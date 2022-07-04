if [ ! -d "var/lib/mysql/mysql" ]; then
  mysql_install_db --basedir=/usr --datadir=/var/lib/mysql
fi
