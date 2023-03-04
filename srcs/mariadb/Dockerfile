FROM alpine:3.16

RUN apk update && apk upgrade && apk add --no-cache mariadb
        
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools/entry.sh /tmp/entry.sh

CMD ["sh", "/tmp/entry.sh"]
