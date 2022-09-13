
#------------DL & EXTRACT WORDPRESS------------#
mkdir -p /var/www/html
cd /var/www/html/
wp core download --allow-root  # you can do command even if you are root

#------------WAITING FOR MARIADB------------#
while ! mysqladmin -hmariadb -u${MYSQL_USER} -p${MYSQL_USER_PASSWORD} ping; do
	sleep 2
done

#------------CONFIG FILE------------#
wp config create	--dbname=${MYSQL_DATABASE} \
					--dbuser=${MYSQL_USER} \
					--dbpass=${MYSQL_USER_PASSWORD} \
					--dbhost=mariadb:3306 \
					--dbcharset="utf8" \
					--dbcollate="utf8_general_ci" \
					--allow-root

#------------INSTALL WORDPRESS------------#
# the famous 5 minute install in 0.0001s
wp core install --url=${WP_URL} \
				--title="${WP_TITLE}" \
				--admin_user=${WP_ADMIN} \
				--admin_password=${WP_ADMIN_PASSWORD} \
				--admin_email=${WP_ADMIN_MAIL} \
				--allow-root

#------------USER CREATION------------#
wp user create	${WP_USER} ${WP_USER_MAIL} \
				--role=author \
				--user_pass=${WP_USER_PASSWORD} \
				--allow-root

exec "$@"

# exec "$@" is typically used to make the entrypoint a pass through that then runs the docker command.
# It will replace the current running shell with the command that "$@" is pointing to.
# By default, that variable points to the command line arguments.
# To simplify : First it will exec everything and after do the CMD in the dockerfile
