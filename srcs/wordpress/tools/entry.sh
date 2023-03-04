#!/bin/sh


if [ ! -f "./wp-config.php" ]; then

    wp core download \
     --allow-root 

    wp config create --dbhost=$DB_HOST \
     --dbname=$DB_NAME \
     --dbuser=$DB_USER \
     --dbpass=$DB_PASSWORD \
     --allow-root 

    wp core install --title=$WP_TITLE \
     --admin_user=$WP_ADMIN_USER \
     --admin_password=$WP_ADMIN_PASSWORD \
     --admin_email=$WP_ADMIN_MAIL \
     --url=$WP_URL --skip-email\
     --allow-root 

    wp user create $WP_USER $WP_USER_MAIL \
     --user_pass=$WP_USER_PASSWORD --role=author \
     --allow-root  

#_________________________bonus section_______________________#

    wp config set WP_REDIS_HOST redis --allow-root 
  	wp config set WP_REDIS_PORT 6379 --raw --allow-root
 	wp config set WP_CACHE_KEY_SALT $DOMAIN_NAME --allow-root
 	wp config set WP_REDIS_CLIENT predis --allow-root
    wp config set WP_REDIS_SCHEME tcp --allow-root
	wp plugin install redis-cache --activate --allow-root
    
	wp redis enable --allow-root
    wp plugin status redis-cache --allow-root

#______________________________________________________________#

fi

chown -R fpm-user:fpm-user /var/www/html
echo "starting FastCGI Process Manager..."
exec php-fpm8 -F