FROM mysql:latest

ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=mydatabase

COPY mydatabase.sql /docker-entrypoint-initdb.d/

EXPOSE 3306
