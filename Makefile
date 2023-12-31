# https://docs.docker.com/engine/reference/commandline/compose/
# -f to specify a path to a Compose file
# -p to specify a project name
NAME = inception
SRCS = ./srcs/docker-compose.yml
MAIN_CMD = docker compose -f ${SRCS} -p ${NAME}

all: down build up

build:
	${MAIN_CMD} build

up:
	${MAIN_CMD} up

down:
	${MAIN_CMD} down

clean:
	${MAIN_CMD} down -v

fclean:
	${MAIN_CMD} down --rmi all --volumes
	sudo rm -rf /home/mravera/data/DB_volume/*
	sudo rm -rf /home/mravera/data/WordPress_volume/*

re: fclean all

.PHONY: all clean fclean re