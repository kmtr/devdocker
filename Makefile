USER=${shell logname}
TAG=devdocker
IMAGE_NAME=local:${TAG}
CONTAINER_NAME=${TAG}

ps:
	docker ps -f ancestor=${IMAGE_NAME}

build:
	docker build \
		-t ${IMAGE_NAME} \
		--build-arg USER=${USER} .

create:
	docker create \
		--name ${CONTAINER_NAME} \
		-v /home/${USER}:/home/${USER} \
		-p 127.0.0.1:8080:8080 \
		${IMAGE_NAME} \
		/usr/bin/top -b

exec:
	docker exec -ti ${CONTAINER_NAME} tmux -2 -u

start:
	docker start ${CONTAINER_NAME}

stop:
	docker stop ${CONTAINER_NAME}

rm:
	docker rm ${CONTAINER_NAME}
