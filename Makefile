

all: volumes build
	docker-compose -f ./srcs/docker-compose.yml up -d

up: all

down:
	docker-compose -f ./srcs/docker-compose.yml down

build:
	docker-compose -f ./srcs/docker-compose.yml build

re: clean build up

clean: down
	docker system prune -fa
	
volumes:
	mkdir -p /home/eabdelha/data/wordpress
	mkdir -p /home/eabdelha/data/mariadb
	mkdir -p /home/eabdelha/data/hugo

cvolumes: 
	rm -rf /home/eabdelha/data/wordpress
	rm -rf /home/eabdelha/data/mariadb
	rm -rf /home/eabdelha/data/hugo

.PHONY: all re down clean

