#	Colors
GREY = \e[90m
RED = \e[91m
GREEN = \e[92m
YELLOW = \e[93m
PURPLE = \e[95m
BLUE = \e[34m
END = \e[39m

#	Volumes

MB_VOLUME = /home/sap/data/mariadb

WP_VOLUME = /home/sap/data/wordpress

VOLUMES = $(MB_VOLUME) $(WP_VOLUME)

# Rules

all: $(VOLUMES)
	@ echo "$(BLUE)\n		***LAUNCH CONTAINER***\n$(END)"
	sudo docker compose -f ./srcs/docker-compose.yml up -d
	@ echo "$(GREEN)\n		***CONTAINER LAUNCHED***\n$(END)"

up: $(VOLUMES)
	@ echo "$(BLUE)\n		***BUILD AND LAUNCH CONTAINER***\n$(END)"
	sudo docker compose -f ./srcs/docker-compose.yml up -d --build
	@ echo "$(GREEN)\n		***CONTAINER LAUNCHED***\n$(END)"

down:
	@ echo "$(GREY)\n		***SHUT DOWN CONTAINER***\n$(END)"
	sudo docker compose -f ./srcs/docker-compose.yml down
	@ echo "$(GREEN)\n		***CONTAINER STOPPED***\n$(END)"

clean: down
	@ echo "$(YELLOW)\n		***REMOVE CONTAINER***\n$(END)"
	sudo docker container prune;
	@ echo "$(GREEN)\n		***CONTAINER DELETED***\n$(END)"

fclean: clean
	@ echo "$(RED)\n		***REMOVE VOLUMES, CONTAINER AND IMAGES***\n$(END)"
	sudo rm -rf $(VOLUMES)
	@ echo "$(GREEN)\n		***VOLUMES DELETED***\n$(END)"
	sudo docker system prune -a
	@ echo "$(GREEN)\n		***CONTAINER AND IMAGES DELETED***\n$(END)"

re: fclean all

$(VOLUMES):
	@ echo "$(PURPLE)\n		***CREATE VOLUMES***\n$(END)"
	sudo mkdir -p $(VOLUMES)
	@ echo "$(GREEN)\n		***VOLUMES CREATED***\n$(END)"

.PHONY: all up down clean fclean re
