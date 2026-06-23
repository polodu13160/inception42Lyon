.PHONY = all stop fclean FORCE

FLAGS = -d  

all:
	@echo "change env.example to .env! and modif password for db and wp in secrets if first initialization" 
	@if [ ! -f .env ]; then \
		echo "Missing .env file, change env.example to .env!"; \
		exit 1 ;\
	fi
	mkdir -p ./secrets
	@if [ ! -f ./secrets/db_root_password.txt ]; then \
		echo "password for root (mariadb/wordpress) :" ; \
		read password ; \
		echo "$$password"  | tr -d '\n' | cat > ./secrets/db_root_password.txt ;\
	fi
	@if [ ! -f ./secrets/db_user_password.txt ]; then \
		echo "password for user (mariadb/wordpress/phpmyadmin) :";\
		read password ;\
		echo "$$password"  | tr -d '\n' | cat > ./secrets/db_user_password.txt ;\
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
	rm -rf ./secrets/db_root_password.txt
	rm -rf ./secrets/db_user_password.txt
stop:
	docker compose down
clean: 
	docker compose down -v
	rm -rf /home/${USER}/data

rerunforce: 
	rm -rf ./secrets/db_root_password.txt
	rm -rf ./secrets/db_user_password.txt
	@make all FLAGS="-d --build"



