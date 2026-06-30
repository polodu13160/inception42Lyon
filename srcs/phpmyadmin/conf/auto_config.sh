#!/bin/bash

if [ ! -f "/var/www/phpmyadmin/config.inc.php" ]; then
echo "myadmin is not installed"
wget https://files.phpmyadmin.net/phpMyAdmin/5.2.3/phpMyAdmin-5.2.3-all-languages.tar.gz
tar -xvzf phpMyAdmin-5.2.3-all-languages.tar.gz
rm phpMyAdmin-5.2.3-all-languages.tar.gz
mkdir -p /var/www/phpmyadmin
mv phpMyAdmin-5.2.3-all-languages/* /var/www/phpmyadmin/
rm -rf phpMyAdmin-5.2.3-all-languages
mkdir -p /var/www/phpmyadmin/tmp
chown -R ${MY_UID}:www-data /var/www/phpmyadmin/
chmod -R 775 /var/www/phpmyadmin/
mkdir -p /run/php
mv /scripts/config.inc.php /var/www/phpmyadmin/config.inc.php
else 
    echo "help"
fi
mkdir -p /var/www/phpmyadmin/tmp/twig
chown -R ${MY_UID}:www-data /var/www/phpmyadmin/tmp/twig
chmod -R 700  /var/www/phpmyadmin/tmp/twig
rm -rf /run/secrets/db*
exec /usr/sbin/php-fpm8.2 -F