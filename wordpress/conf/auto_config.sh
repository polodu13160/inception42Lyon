#!/bin/bash

# Petite pause pour laisser le temps à MariaDB de s'allumer
sleep 100
# 1. On entre dans le dossier monté par le volume
cd /var/www/wordpress

# 2. On vérifie si WordPress est déjà installé (pour éviter de tout casser si on redémarre le conteneur)
if [ ! -f wp-config.php ]; then
    echo "Téléchargement et configuration de WordPress..."
    
    # On télécharge WP avec l'outil officiel (plus propre que curl/tar)
    wp core download --allow-root --locale=fr_FR
    
    # Création du lien avec la base de données
    wp config create --allow-root \
        --dbname=$SQL_DATABASE \
        --dbuser=$SQL_USER \
        --dbpass=$SQL_PASSWORD \
        --dbhost=mariadb:3306

    # Installation du site
    wp core install --allow-root \
        --url=pde-petr.42.fr \
        --title="Inception de Paul" \
        --admin_user=$WP_ADMIN_USER \
        --admin_password=$WP_ADMIN_PASSWORD \
        --admin_email=$WP_ADMIN_EMAIL

    # Création du deuxième utilisateur (Auteur)
    wp user create --allow-root \
        $WP_USER_LOGIN \
        $WP_USER_EMAIL \
        --role=author \
        --user_pass=$WP_USER_PASSWORD
fi

# 3. On s'assure que les droits sont parfaits pour le serveur web !
chown -R www-data:www-data /var/www/wordpress

# 4. On lance la BONNE version de PHP au premier plan
exec /usr/sbin/php-fpm8.2 -F