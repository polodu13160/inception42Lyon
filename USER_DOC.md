# User Documentation - Inception Project

## 1. Services provided by the infrastructure
This project deploys a set of interconnected services (a “stack”) to host a functional website:
* **Nginx:** The main web server. It receives all user requests and redirects them securely (over HTTPS) to the correct service.
* **WordPress:** The content creation and management system (CMS). This is the main website visible to visitors.
* **MariaDB:** The database system. It invisibly stores all site information (articles, users, settings).
* **phpMyAdmin:** A web administration interface that allows you to visually view and modify the contents of the database.

## 2. Start and stop the project
First step : 
  - Edit the host file located in `/etc/hosts` 
  - Add after lign ` 127.0.0.1 locahost`:
      ```bash 
      127.0.0.1 DomainNameofYourEnv
      ```
All management actions are done from the terminal, at the root of the project, using simplified commands:
* **Second step:**  `cp env.example .env` and modif .env with your informations (or not use but see the name of the user). 
* **To start the project:** Run the `make` command. This will download, configure and launch all background services.
* **To stop the project:** Run the `make stop` command. The services will stop without deleting your data.

## 3. Access the site and administration panels
Once the project is started, open your web browser:
change DomainName with the good environment variable.
* **WordPress site:** Go to `https://DomainName`.
* **WordPress Administration:** Go to `https://DomainName/wp-admin/` to manage the website.
* **Database Administration (phpMyAdmin):** Go to `https://DomainName/phpmyadmin/` (don't forget the `/` at the end).

## 4. Locate and manage credentials
For security reasons, passwords are not visible in the source code.
* When launching for the first time with `make`, the system will ask you to create two passwords.
* These passwords are securely stored in local files located in the `secrets/` folder at the root of the project:
  * `secrets/db_root_password.txt`: The password of the administrator.
  * `secrets/db_user_password.txt`: The standard user password (used to connect to phpMyAdmin and to link WordPress to the database).

## 5. Check that services are working
To ensure that all services are running correctly, open a terminal at the root of the project and type:
```bash
docker ps