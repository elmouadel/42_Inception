FROM alpine:3.16

RUN	apk update && apk upgrade && apk add --no-cache hugo git 
RUN mkdir /var/www && mkdir /var/www/hugo

COPY ./srcs/ /tmp/srcs
COPY ./tools/entry.sh /tmp/entry.sh

CMD ["sh", "/tmp/entry.sh"]


