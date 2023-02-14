FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache curl

RUN mkdir -p /var/www && mkdir -p /var/www/html

COPY ./tools/entry.sh /tmp/entry.sh

CMD ["sh", "/tmp/entry.sh"]
