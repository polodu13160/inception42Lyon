.PHONY = all stop fclean FORCE

all:
	@if [ ! -f .env ]; then \
		echo "Fichier .env manquant, modifier le env.exemple !"; \
		exit 1; \
	fi
	mkdir -p /home/${USER}/data/mariadb
	mkdir -p /home/${USER}/data/wordpress
	docker compose up -d --build
fclean: clean
	docker rmi inception42lyon-mariadb:latest inception42lyon-nginx:latest  inception42lyon-wordpress:latest  
stop:
	docker compose down
clean: 
	docker compose down -v
	sudo rm -rf /home/${USER}/data/mariadb
	sudo rm -rf /home/${USER}/data/wordpress

rerun:
	docker compose up -d


