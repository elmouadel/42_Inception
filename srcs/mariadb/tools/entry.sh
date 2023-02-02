#!/bin/sh

mkdir -p /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then

	mysql_install_db > /dev/null
	echo "create user for wordpress..."
	mysqld  --bootstrap < /tmp/creat_user.sql

fi

mysqld