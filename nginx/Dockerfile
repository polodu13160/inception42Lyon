FROM debian:bookworm


LABEL org.opencontainers.image.authors="paul.depetrini@gmail.com"

RUN apt update -y
RUN apt install -y nginx 
RUN mkdir -p /etc/nginx/ssl
RUN apt install -y openssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/CN=${DOMAIN_NAME}/UID=pde-petr"
RUN mkdir -p /var/run/nginx
COPY conf/nginx.conf /etc/nginx/nginx.conf
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html

# voir la version nginx hahahahahahaahah by pauldepetrini jai suivi etape de https://www.it-connect.fr/debian-comment-installer-nginx-en-tant-que-serveur-web/
# https://www.wanadevdigital.fr/24-tuto-docker-demarrer-docker-partie-2/
#https://blog.stephane-robert.info/docs/services/web/nginx/ pour comprendre comment config
EXPOSE 443
# a skip ca va le lancer a chaque fois que je lance le contener; step by step bro
CMD ["nginx", "-g", "daemon off;"]

