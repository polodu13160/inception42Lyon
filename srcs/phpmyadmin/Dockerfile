FROM debian:bookworm


# RUN apt install -y phpmyadmin
RUN apt-get update -y && apt-get install -y \
    php \
    php8.2-fpm \
    php8.2-mysql \
    wget  \
    mariadb-client

COPY conf/auto_config.sh /scripts/auto_config.sh
RUN chmod 755 /scripts/auto_config.sh
COPY conf/config.sample.inc.php /scripts/config.inc.php
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf
ENTRYPOINT ["/scripts/auto_config.sh"]
