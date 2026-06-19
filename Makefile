.PHONY = all stop fclean FORCE

FLAGS = -d  

all:
	@echo "change env.example to .env! and modif password for db and wp in secrets if first initialization" 
	@if [ ! -f .env ]; then \
		echo "Missing .env file, change env.example to .env!"; \
		exit 1; \
	fi
	mkdir -p /home/${USER}/data/mariadb
	mkdir -p /home/${USER}/data/wordpress
	mkdir -p /home/${USER}/data/phpmyadmin
	head  -n 8 .env > /tmp/en2
	mv /tmp/en2 .env
	@echo "MY_UID=$$(id -u)" >> .env
	docker compose up $(FLAGS)
fclean: clean
	docker rmi inception42lyon-mariadb:latest inception42lyon-nginx:latest  inception42lyon-wordpress:latest  
stop:
	docker compose down
clean: 
	docker compose down -v
	rm -rf /home/${USER}/data

rerunforce:
	@make all FLAGS="-d --build"


