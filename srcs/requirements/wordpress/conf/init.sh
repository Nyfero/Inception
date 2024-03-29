# Download wp
mkdir -p /var/www/html
cd /var/www/html/
wp core download --allow-root

# Waiting for mdb
while ! mysqladmin -hmariadb -u${MYSQL_USER} -p${MYSQL_USER_PASSWORD} ping; do
	sleep 2
done

# Create new wp-config.php and check database
wp config create	--dbname=${MYSQL_DATABASE} \
					--dbuser=${MYSQL_USER} \
					--dbpass=${MYSQL_USER_PASSWORD} \
					--dbhost=mariadb:3306 \
					--dbcollate="utf8_general_ci" \
					--allow-root

# Create wp table in database
wp core install --url=${WP_URL} \
				--title="${WP_TITLE}" \
				--admin_user=${WP_ADMIN} \
				--admin_password=${WP_ADMIN_PASSWORD} \
				--admin_email=${WP_ADMIN_MAIL} \
				--allow-root

# Create user
wp user create	${WP_USER} ${WP_USER_MAIL} \
				--role=author \
				--user_pass=${WP_USER_PASSWORD} \
				--allow-root

exec "$@"
