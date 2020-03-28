CONTAINER_NAME=mysql_sandbox
NETWORK_NAME=${CONTAINER_NAME}
# This configuration is intended for SQL query practice on localhost. Do not use
# in production systems or insert any secure data.
PASSWORD=insecure
PORT=3306

build:
	docker build -t ${CONTAINER_NAME} .

run:
	mkdir -p .data
	docker network inspect ${NETWORK_NAME} > /dev/null 2>&1 || docker network create ${NETWORK_NAME}
	docker start ${CONTAINER_NAME} > /dev/null 2>&1 || docker run -d -p ${PORT}:3306 --name ${CONTAINER_NAME} \
		-e MYSQL_ROOT_PASSWORD=${PASSWORD} --net=${NETWORK_NAME} -v $(PWD)/.data:/var/lib/mysql \
		-v $(PWD)/scripts/startup:/docker-entrypoint-initdb.d --health-cmd='mysqladmin ping --silent' ${CONTAINER_NAME}

stop:
	docker stop ${CONTAINER_NAME}

connect: run
	scripts/wait.sh ${CONTAINER_NAME}
	docker run -it --rm --net=${NETWORK_NAME} -v $(PWD)/scripts/custom:/tmp mysql mysql -h ${CONTAINER_NAME} -uroot -p

exec:
	docker exec -it -v $(PWD)/scripts/custom:/tmp ${CONTAINER_NAME} bash

destroy: stop
	docker rm ${CONTAINER_NAME}
	docker network rm ${NETWORK_NAME}
	docker image rm ${CONTAINER_NAME}
