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
CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'%' IDENTIFIED BY '$(</run/secrets/db_user_password)';
GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '$(</run/secrets/db_root_password)';
FLUSH PRIVILEGES;
EOF
    
    
    mysqld --user=mysql --bootstrap < /tmp/init.sql
    rm -f /tmp/init.sql
fi



chown -R ${MY_UID}:mysql /run/mysqld
chown -R ${MY_UID}:mysql /var/lib/mysql
chmod -R 775 /run/mysqld
chmod -R 775 /var/lib/mysql

rm -rf /run/secrets/db*

echo "Démarrage de MariaDB..."
exec mysqld_safe