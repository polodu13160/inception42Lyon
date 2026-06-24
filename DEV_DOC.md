# Developer Documentation - Inception Project

This documentation is intended for developers wishing to install, understand, or modify the Inception project infrastructure.

## 1. Configure the environment (Prerequisites)
To deploy the project from scratch, your system must have **Docker**, **Docker Compose** and **Make**.

**Configuration steps:**
1. **Domain name:** Edit your `/etc/hosts` file (with root rights) to redirect the local domain name to your machine:
   `127.0.0.1 student.42.fr`
2. **Environment variables:** Copy the example file to create your local configuration:
   `cp env.example .env`
   *(Make sure variables like `SQL_USER` and `DOMAIN_NAME` are populated correctly).*
3. **Secrets:** You do not need to create passwords manually. The Makefile script will take care of this interactively during the first launch.

## 2. Compile and launch the project
The entire project lifecycle is managed by the `Makefile` located at the root.
* To compile local Docker images and launch containers in detached mode, run:
  ```bash
  make

## 3. Access MariaDB and Wordpress

# Access mariaDB
 ```bash
  docker exec -it mariadb bash
  mariadb -u user/root -p
  SHOW DATABASES
  USE DATABASENAME
```
see other commands : https://mariadb.com/docs/server/reference/sql-statements/comment-syntax

# Access Wordpress

https://DOMAIN_NAME/wp-admin/

Connect with user

# Access PhpMyAdmin

https://DOMAIN_NAME/phpmyadmin/

Connect with user
