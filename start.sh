#!/bin/bash
if [ ! -d /var/local/mysql/data ]; then 
	echo "Creating database data folder..."
	sudo mkdir -p /var/local/mysql/data /var/local/mysql/initdb
	chmod o+rwx /var/local/mysql/data
	sudo cp ./db/db.sql /var/local/mysql/initdb/
else 
	rm -rf /var/local/mysql/initdb/*
fi 

docker run -d --name mysql -e MYSQL_DATABASE=BucketList -e MYSQL_USER=ibrahim -e MYSQL_PASSWORD=ibrahim -e MYSQL_ROOT_PASSWORD=root -v /var/local/mysql/data:/var/lib/mysql -v /var/local/mysql/initdb:/docker-entrypoint-initdb.d -p 30306:3306 mysql
sleep 5
docker run -d -e MYSQL_DB_NAME=BucketList --link mysql:mysql --name webapp -p 5000:5000 albarki/webapp
