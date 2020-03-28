# dockerized-mysql-sandbox

A simple mysql sandbox pre-populated with simple data. All you need is Docker.  

## Quick Start

Step 1: [Install docker](https://www.docker.com/get-started)
Step 2: Build your custom image
```
make build
```
Step3: Run the container and connect to the server
```
make connect
```
This command will run the custom mysql container in the background and startup a new container with the mysql client. You will be asked for the root password.  
  
Step 4: Play  

All data is persisted locally in .data. This means stopping and restarting the container will not cause data loss.

## Connecting to the Server
There are two simple ways to connect to the container running the mysql server. The first is the simplest and covers the most common use case, writing queries.  
```
make connect
```
This will run the container if it is not already running. Make sure to build the image first with `make build`. You'll be asked for the root password. If successful, you'll be greeted with an active mysql client session.  

The second method is via `docker exec` but you can just use `make exec` to get inside the client container. If you still want to run the client you'll have to run `mysql -uroot -p` and input the root password.  

Both of these make targets mount `scripts/custom` on your local machine to `/tmp` inside the container.

## Custom Scripts
You can add scripts to the `scripts/custom` directory which is mounted to the client container at `/tmp`.

Example:

```
SOURCE tmp/test.sql;
```

## Startup Scripts
Scripts found in `scripts/startup` will be run on startup in alphabetical order (see *Initializing a fresh instance* in the mysql [documentation](https://hub.docker.com/_/mysql) hosted on Docker Hub).

## Sources
The `create.sql` and `data.sql` files are taken from Vijini Mallawaarachchi's Medium article, [SQL Recap for Interviews](https://towardsdatascience.com/sql-cheat-sheet-for-interviews-6e5981fa797b).

