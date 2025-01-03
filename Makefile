COMPOSE_DIR := ./srcs

all: up

up:
	mkdir -p ${HOME}/data/wordpress
	mkdir -p ${HOME}/data/mariadb
	sudo mount --make-shared /
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml up --build

down:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml down

stop:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml stop

restart: down up

build:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml build

clean:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml down --volumes --remove-orphans

fclean: clean
	@sudo rm -rf ${HOME}/data
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml down --rmi all --volumes --remove-orphans

re: fclean all

logs:
	docker compose -f $(COMPOSE_DIR)/docker-compose.yml logs -f

f:
	@sudo rm -rf ${HOME}/data
	docker builder prune -a --force
	docker system prune -a --volumes --force
	docker volume prune --all --force

nginx:
	mkdir -p ${HOME}/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build nginx

maria:
	mkdir -p ${HOME}/data/mariadb
	docker compose -f srcs/docker-compose.yml up --build mariadb

wordpress:
	mkdir -p ${HOME}/data/wordpress
	docker compose -f srcs/docker-compose.yml up --build wordpress

host:
	@HOSTS_FILE="/etc/hosts"; \
	ENTRY="127.0.0.1       albozkur.42.fr"; \
	if [ -f $$HOSTS_FILE ]; then \
	    if grep -Fxq "$$ENTRY" $$HOSTS_FILE; then \
	        echo "Domain already exists in this directory-> $$HOSTS_FILE, domain-> $$ENTRY"; \
	    else \
	        echo "Adden domain name in this directory-> $$HOSTS_FILE, domain-> $$ENTRY"; \
	        sudo sed -i "1i $$ENTRY" $$HOSTS_FILE; \
	    fi \
	else \
	    echo "File not found: $$HOSTS_FILE"; \
		echo "Please add the domain manually, this problem couse by the OS. This setup is for Linux OS."; \
	    exit 1; \
	fi

.PHONY: all up down restart build clean fclean re host