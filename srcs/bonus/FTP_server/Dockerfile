FROM alpine:3.16

RUN	apk update && apk upgrade && apk add --no-cache vsftpd
RUN mkdir -p /var/www/html

COPY conf/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY tools/entry.sh /tmp/entry.sh


CMD ["sh", "/tmp/entry.sh"]