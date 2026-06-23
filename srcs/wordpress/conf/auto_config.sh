#!/bin/bash

cd /var/www/wordpress

if [ ! -f wp-config.php ]; then
    echo "Creation WordPress"
    wp core download --allow-root --locale=fr_FR
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$(</run/secrets/db_user_password) \
        --dbhost=mariadb:3306

    wp core install --allow-root \
        --url=$DOMAIN_NAME\
        --title="Inception de Paul" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$(</run/secrets/db_user_password) \
        --admin_email=$WP_ADMIN_EMAIL

    wp user create --allow-root \
        $WP_USER_LOGIN \
        $WP_USER_EMAIL \
        --role=author \
        --user_pass=$(</run/secrets/db_user_password)
fi

chown -R ${MY_UID}:www-data /var/www/wordpress
chmod -R 775 /var/www/wordpress

exec /usr/sbin/php-fpm8.2 -F