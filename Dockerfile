FROM mysql:latest

ENV MYSQL_DATABASE university

COPY ./scripts/sql/ /docker-entrypoint-initdb.d/
