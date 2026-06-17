#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld
chown -R mysql:mysql /var/lib/mysql


if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Installing MariaDB system files..."
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql
fi

if [ ! -d "/var/lib/mysql/${SQL_DATABASE}" ]; then
    echo "Creation database"
    cat << EOF | cat > /tmp/init.sql
FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF
    
    
    mysqld --user=mysql --bootstrap < /tmp/init.sql
    rm -f /tmp/init.sql
fi

chown -R ${MY_UID}:mysql /run/mysqld
chown -R ${MY_UID}:mysql /var/lib/mysql
chmod -R 775 /run/mysqld
chmod -R 775 /var/lib/mysql

echo "Démarrage de MariaDB..."
exec mysqld_safe