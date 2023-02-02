FROM alpine:3.16
EXPOSE 3306

RUN apk update && apk upgrade && apk add --no-cache mariadb
        
COPY ./conf/mariadb-server.cnf /etc/my.cnf.d/mariadb-server.cnf
COPY ./tools/creat_user.sql /tmp/creat_user.sql
COPY ./tools/entry.sh /tmp/entry.sh

ENTRYPOINT ["sh", "/tmp/entry.sh"]
