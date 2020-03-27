CONTAINER_NAME=mysql_sandbox
NETWORK_NAME=${CONTAINER_NAME}
PASSWORD=pw
PORT=3306

db:
	mkdir -p data
	docker network inspect ${NETWORK_NAME} > /dev/null 2>&1 || docker network create -d bridge ${NETWORK_NAME}
	docker start ${CONTAINER_NAME} > /dev/null 2>&1 || docker run -d --name ${CONTAINER_NAME} \
		-v $(PWD)/data:/var/lib/mysql -e MYSQL_ALLOW_EMPTY_PASSWORD=yes --net=${NETWORK_NAME} \
		--health-cmd='mysqladmin ping --silent' -p ${PORT}:3306 mysql

connect: db
	scripts/wait.sh ${CONTAINER_NAME}
	docker run -it --rm --net=${NETWORK_NAME} -v $(PWD)/scripts:/tmp mysql mysql -h ${CONTAINER_NAME} -u root -p

destroy:
	docker stop ${CONTAINER_NAME}
	docker rm ${CONTAINER_NAME}
