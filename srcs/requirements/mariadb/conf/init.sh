#	Start mysql
service mysql start

# Wait that mysql is started
while ! mysqladmin ping; do
	sleep 2
done

#	Create 'wordpress' database
mysql -u root -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE};"

#	Remove 'test' database
mysql -u root -e "DROP DATABASE IF EXISTS 'test';"

#	Create admin for wordpress database
mysql -u root -e "CREATE USER IF NOT EXISTS '${MYSQL_ADMIN}'@'%' IDENTIFIED BY '${MYSQL_ADMIN_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_ADMIN}'@'%';"

# Reload access right
mysql -u root -e "FLUSH PRIVILEGES;"

# Create user for wordpress database
mysql -u root -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_USER_PASSWORD}';"
mysql -u root -e "GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE}.* TO '${MYSQL_USER}'@'%';"

mysql -u root -e "FLUSH PRIVILEGES;"

#	Remove root and anonymous user
mysql -u root -e "DELETE FROM mysql.user WHERE user='';"
mysql -u root -e "DELETE FROM mysql.user WHERE user='root';"

mysql -u root -e "FLUSH PRIVILEGES;"

#	Restart mysql
killall mysqld

# Exec this file as a command
exec "$@"
