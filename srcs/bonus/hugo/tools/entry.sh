#!/bin/sh

cd /var/www/hugo/static_web
echo "starting hugo server..."
exec hugo server --bind=0.0.0.0 -b $HUGO_DOMAIN_NAME --themesDir=themes > /dev/null