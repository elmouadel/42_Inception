#!/bin/sh

if [ ! -d "/var/www/hugo/static_web" ]; then
	
	hugo new site /var/www/hugo/static_web > /dev/null
	git clone https://github.com/zerostaticthemes/hugo-whisper-theme.git \
	/var/www/hugo/static_web/themes/hugo-whisper-theme > /dev/null

	cp -a /var/www/hugo/static_web/themes/hugo-whisper-theme/exampleSite/. /var/www/hugo/static_web/

	rm -rf /var/www/hugo/static_web/content /var/www/hugo/static_web/static
	echo "building static website..."
	cp -rf /tmp/srcs/* /var/www/hugo/static_web/.
	
fi