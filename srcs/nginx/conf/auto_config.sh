#!/bin/bash


if [ ! -f  /instalgood ]; then
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/CN=${DOMAIN_NAME}/UID=pde-petr"
mkdir -p /var/run/nginx
apt install -y gettext-base
envsubst '${DOMAIN_NAME}' < /nginx.conf > /etc/nginx/nginx.conf
touch /instalgood
fi
chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html
nginx -g " daemon off;" 