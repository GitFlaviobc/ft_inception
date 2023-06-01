HOST = fbonini-

all: folderconfig up
up: 
	sudo docker-compose -f srcs/docker-compose.yml up -d

down:
	@docker-compose -f ./srcs/docker-compose.yml down

folderconfig:
	sudo chmod a+w /etc/hosts && sudo cat /etc/hosts | grep $(HOST).42.fr || \
	sudo echo "127.0.0.1 $(HOST).42.fr" >> /etc/hosts

	sudo mkdir -p /home/$(HOST)/data/mariadb && sudo chmod 777 /home/$(HOST)/data/mariadb
	sudo mkdir -p /home/$(HOST)/data/wordpress && sudo chmod 777 /home/$(HOST)/data/wordpress

clean:
	docker stop $$(docker ps -qa);\
	docker rm $$(docker ps -qa);\
	docker rmi -f $$(docker images -qa);\
	docker volume rm $$(docker volume ls -q);\
	docker network rm $$(docker network ls -q);\
	sudo -n sed '/127.0.0.1 $(HOST).42.fr/d' /etc/hosts -n
	sudo rm -rf /home/$(HOST)

fclean: clean
	sudo docker system prune --volumes --all --force

re: fclean all

.PHONY: all re down clean


