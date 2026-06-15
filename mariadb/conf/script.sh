#!/bin/bash

# Préparation des dossiers vitaux
mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql

# 1. Si le dossier partagé avec ton PC est totalement vide, on crée les fichiers systèmes
if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Installation des fichiers systèmes MariaDB..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

# 2. Si la base Inception n'existe pas, on la configure de manière sécurisée
if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    echo "Création de la base de données et des utilisateurs..."
    
    # On écrit toutes nos requêtes dans un fichier temporaire
    cat << EOF > /tmp/init.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
    
    # La magie du Bootstrap : on injecte le SQL directement dans le moteur éteint
    mysqld --user=mysql --bootstrap < /tmp/init.sql
    
    # On nettoie le fichier temporaire
    rm -f /tmp/init.sql
fi

# 3. Lancement normal en premier plan
echo "Démarrage de MariaDB..."
exec mysqld_safe