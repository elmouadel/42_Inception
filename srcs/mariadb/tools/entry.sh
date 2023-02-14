#!/bin/sh

mkdir -p /run/mysqld

if [ ! -d "/var/lib/mysql/mysql" ]; then

	mysql_install_db > /dev/null 2>&1
	echo "create user for wordpress..."
	mysqld  --bootstrap < /tmp/creat_user.sql 2> /dev/null

fi

echo "starting mariadb server..."
exec mysqld 2> /dev/null