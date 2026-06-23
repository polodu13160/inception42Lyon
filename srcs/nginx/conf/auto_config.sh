#!/bin/bash


if [ ! -f  /etc/nginx/nginx.conf ]; then
openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/CN=${DOMAIN_NAME}/UID=pde-petr"
mkdir -p /var/run/nginx
envsubst '${DOMAIN_NAME}' < /nginx.conf > /etc/nginx/nginx.conf
fi
chmod 755 /var/www/html
chown -R www-data:www-data /var/www/html
# voir la version nginx hahahahahahaahah by pauldepetrini jai suivi etape de https://www.it-connect.fr/debian-comment-installer-nginx-en-tant-que-serveur-web/
# https://www.wanadevdigital.fr/24-tuto-docker-demarrer-docker-partie-2/
#https://blog.stephane-robert.info/docs/services/web/nginx/ pour comprendre comment config
# a skip ca va le lancer a chaque fois que je lance le contener; step by step bro
nginx -g daemon off