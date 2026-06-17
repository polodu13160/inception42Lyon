.PHONY = all stop fclean FORCE

all:
	@if [ ! -f .env ]; then \
		echo "Fichier .env manquant, modifier le env.exemple !"; \
		exit 1; \
	fi
	mkdir -p /home/${USER}/data/mariadb
	mkdir -p /home/${USER}/data/wordpress
	@echo "MY_UID=$$(id -u)" >> .env
	docker compose up -d --build
fclean: clean
	docker rmi inception42lyon-mariadb:latest inception42lyon-nginx:latest  inception42lyon-wordpress:latest  
stop:
	docker compose down
clean: 
	docker compose down -v
	head  -n 11 .env > /tmp/en2
	mv /tmp/en2 .env
	
	rm -rf /home/${USER}/data/mariadb
	rm -rf /home/${USER}/data/wordpress

rerun:
	docker compose up -d


