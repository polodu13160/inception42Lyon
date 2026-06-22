<em>This project has been created as part of the 42 curriculum by **pde-petr**</em>

# Inception - 42 Project

## DESCRIPTION

### THEORY

This project aims to deploy a containerized infrastructure. Here are the key concepts covered:

* **Virtual Machines vs Docker**
    * A VM is independent and virtualizes the hardware. Docker creates a protected space running on the host's kernel, making it much lighter and faster.
* **Secrets vs Environment Variables**
    * Environment variables are visible in plaintext. Secrets, on the other hand, are meant for sensitive data. In Docker, they are stored in a secure in-memory folder within the container (`/run/secrets/`). They are never written in plaintext to the host's disk. This is the recommended method for database passwords.
* **Docker Network vs Host Network**
    * **Docker Network (Bridge):** This is the default network. It creates an isolated internal network. Your containers can communicate with each other using their names (e.g., WordPress can call MariaDB), but they are "behind" a gateway.
    * **Host Network:** The container does not have its own network. It directly uses the IP address and ports of your host computer. It is high-performance but less secure since there is no network isolation.
* **Docker Volumes vs Bind Mounts**
    * The main difference is that a Bind Mount allows you to know exactly where the data is stored on your host machine (explicit path).

### PROJECT

This project aims to create 3 different containers that will interact with each other:
* **NGINX:** Acts as the web server and redirects traffic to the different sites.
* **WordPress:** A free and open-source Content Management System (CMS), used here as the main website.
* **MariaDB:** Allows for the creation and management of the database used by WordPress.
* **phpMyAdmin:** Allows you to directly view and modify the stored data via a web interface.

---

## INSTRUCTIONS

### Makefile
To launch the project, the `Makefile` automatically handles the password configuration (which are identical across the different containers):

* `make`: Builds the images and starts the containers, including password generation.
* `make stop`: Stops the containers.
* `make clean`: Stops and removes the containers as well as the volumes.
* `make fclean`: Removes everything (containers, images, volumes).
* `make rerunforce`: Rebuilds everything from scratch, including password generation.

### Service Access
* **WordPress:** `https://localhost` (or via `DOMAIN_NAME=student.42.fr` by configuring the `hosts` file to link it to `localhost`).
* **phpMyAdmin:** `https://localhost/phpmyadmin/`
    * *Note:* Do not forget the trailing `/`. Use the username and password `user` not `root`.

---

## RESOURCES

* [Docker Secrets](https://blog.stephane-robert.info/docs/conteneurs/moteurs-conteneurs/docker/secrets/)
* [Docker Volume](https://docs.docker.com/reference/compose-file/volumes/)
* [Grafikart - Docker](https://grafikart.fr/tutoriels/docker)
* [Tuto GradeMe - Inception](https://tuto.grademe.fr/inception/)
* [StackExchange - Bash argument](https://unix.stackexchange.com/questions/393351/pass-contents-of-file-as-argument-to-bash-script)
* [Docker Official Documentation](https://docs.docker.com/get-started/)
* [Reddit - Volumes vs Bind Mounts](https://www.reddit.com/r/docker/comments/1oyjhnw/docker_volumes_vs_bind_mounts/)
* [OVHcloud - What is WordPress?](https://www.ovhcloud.com/fr/learn/what-is-wordpress/)