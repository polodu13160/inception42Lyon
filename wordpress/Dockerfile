FROM debian:bookworm

LABEL authors="paul.depetrini@gmail.com"

# Installation propre
RUN apt-get update -y && apt-get install -y \
    php \
    php8.2-fpm \
    php-mysql \
    mariadb-client \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Création du dossier et attribution des droits
RUN mkdir -p /var/www/wordpress && \
    chown -R www-data:www-data /var/www/wordpress

# WP-CLI
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x wp-cli.phar && \
    mv wp-cli.phar /usr/local/bin/wp

# LA BONNE DESTINATION POUR TA CONFIG !
COPY conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

# Ton script
COPY conf/auto_config.sh /scripts/auto_config.sh
RUN chmod +x /scripts/auto_config.sh

ENTRYPOINT [ "/scripts/auto_config.sh" ]











