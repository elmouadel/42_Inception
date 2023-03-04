# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: eabdelha <eabdelha@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/02/16 14:46:15 by eabdelha          #+#    #+#              #
#    Updated: 2023/03/04 11:16:24 by eabdelha         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

all: volumes build up

up:
	docker-compose -f ./srcs/docker-compose.yml up -d

attach: volumes build
	docker-compose -f ./srcs/docker-compose.yml up

down: 
	docker-compose -f ./srcs/docker-compose.yml down

build: 
	docker-compose -f ./srcs/docker-compose.yml build

re: clean build up

volumes:
	mkdir -p /home/eabdelha/data/wordpress
	mkdir -p /home/eabdelha/data/mariadb
	mkdir -p /home/eabdelha/data/hugo


clean: down
	docker system prune -fa

cvolumes: 
	rm -rf /home/eabdelha/data/wordpress/*
	rm -rf /home/eabdelha/data/mariadb/*
	rm -rf /home/eabdelha/data/hugo/*
	docker volume rm $$(docker volume ls -q)

call: clean cvolumes

.PHONY: all re down clean

