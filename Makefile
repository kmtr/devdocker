USER=${shell logname}
TAG=devdocker

ps:
	docker ps -f ancestor=ubuntu:${TAG}

build:
	docker build -t ubuntu:${TAG} --build-arg USER=${USER} .

run:
	docker run -d --name ${TAG} \
		-v /home/${USER}:/home/${USER} \
		-p 8080:8080 \
		ubuntu:${TAG} \
		/usr/bin/top -b

exec:
	docker exec -ti ${TAG} tmux -2 -u

start:
	docker start ${TAG}

stop:
	docker stop ${TAG}

rm:
	docker rm ${TAG}
