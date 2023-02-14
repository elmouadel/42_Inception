#!/bin/sh

chown -R fpm-user:fpm-user /var/www/html

if [ ! -f "./wp-config.php" ]; then

    php8 /usr/local/bin/wp core download \
     --allow-root 

    php8 /usr/local/bin/wp config create --dbhost=$DB_HOST \
     --dbname=$DB_NAME \
     --dbuser=$DB_USER \
     --dbpass=$DB_PASSWORD \
     --allow-root 

    php8 /usr/local/bin/wp core install --title=$WP_TITLE \
     --admin_user=$WP_ADMIN_USER \
     --admin_password=$WP_ADMIN_PASSWORD \
     --admin_email=$WP_ADMIN_MAIL \
     --url=$WP_URL --skip-email\
     --allow-root 

    existing_username=$(php8 /usr/local/bin/wp user get --field=login "$WP_USER" \
     --allow-root  2> /dev/null)

    if [ "$existing_username" == "$WP_USER" ]; then
        echo "The username '$WP_USER' already exists."
    else
        echo "The username '$WP_USER' is available."
    php8 /usr/local/bin/wp user create $WP_USER $WP_USER_MAIL \
     --user_pass=$WP_USER_PASSWORD --role=author \
     --allow-root  
    fi


    php8 /usr/local/bin/wp config set WP_REDIS_HOST redis --allow-root 
  	php8 /usr/local/bin/wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	php8 /usr/local/bin/wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
 	php8 /usr/local/bin/wp config set WP_REDIS_CLIENT predis --allow-root
    php8 /usr/local/bin/wp config set WP_REDIS_SCHEME tcp --allow-root
	php8 /usr/local/bin/wp plugin install redis-cache --activate --allow-root
    
	php8 /usr/local/bin/wp redis enable --allow-root
    php8 /usr/local/bin/wp plugin status redis-cache --allow-root


fi
echo "starting FastCGI Process Manager..."
exec php-fpm8 -F