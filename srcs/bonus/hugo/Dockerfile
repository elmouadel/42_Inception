FROM alpine:3.16

RUN	apk update && apk upgrade && apk add --no-cache hugo
RUN mkdir /var/www
RUN mkdir /var/www/hugo

COPY ./tools/entry.sh /tmp/entry.sh

CMD ["sh", "/tmp/entry.sh"]

