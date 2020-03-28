FROM mysql:latest

# The default database. Any scripts run on startup will be applied to this database. See
# the mysql documentation on Docker Hub for more information.
ENV MYSQL_DATABASE sandbox

# The docker-entrypoint-initdb.d is overwritten by the volume mounted in the run target
# (see Makefile).
# 
# This can be useful depending on how the image is intended to be used but as set up
# currently provides no real value (and unnecessarily increases image size).
COPY ./scripts/startup/*.sql /docker-entrypoint-initdb.d/
