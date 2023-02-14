#!/bin/sh

if [ ! -f "/var/www/html/adminer.php" ]; then

	echo "downloading Adminer..."
	curl -o /var/www/html/adminer.php -L \
    https://github.com/vrana/adminer/releases/download/v4.8.1/adminer-4.8.1-mysql.php > /dev/null
    
fi