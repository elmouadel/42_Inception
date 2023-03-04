FROM alpine:3.16
RUN apk update && apk add --no-cache curl php8 php8-fpm php8-phar \
php8-mysqli php8-gd php8-json php8-mbstring php8-xml php8-curl \
php8-exif php8-zip php8-opcache php8-redis php-tokenizer php-ctype mariadb-client

RUN mv /usr/bin/php8 /usr/bin/php

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir -p /var/www/html
COPY ./tools/entry.sh /tmp/entry.sh
COPY ./conf/www.conf /etc/php8/php-fpm.d/.

WORKDIR /var/www/html

RUN adduser -S fpm-user && addgroup -S fpm-user 
			
CMD ["sh", "/tmp/entry.sh"]


