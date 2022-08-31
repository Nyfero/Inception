mkdir -p /var/www/html
cd /var/www/html
wp core download --allow-root

while ! mysqladmin -hmariadb -u${MYSQL_USER} -p${MYSQL_USER_PASSWORD} ping; do
  sleep 2
done

wp config create  --dbname=${MYSQL_DATABASE} \
  --dbuser=${MYSQL_USER} \
  --dbpass=${MYSQL_USER_PASSWORD} \
  --dbhost=mariadb:3306 \
  --dbcharset="utf8" \
  --dbcollate="utf8_general_ci" \
  --allow-root

wp core install --url=${WP_URL} \
  --title="${WP_TITLE}" \
  --admin_user=${WP_ADMIN} \
  --admin_password=${WP_ADMIN_PASSwORD} \
  --admin_email=${WP_ADMIN_MAIL} \
  --allow-root

wp user create ${WP_USER} ${WP_USER_MAIL} \
  --role=author \
  --user_pass=${WP_USER_PASSWORD} \
  --allow-root

exec "$@"
