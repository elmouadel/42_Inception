FROM alpine:3.16
EXPOSE 443
RUN apk update && apk add --no-cache nginx openssl
RUN mkdir -p /etc/ssl/private
RUN mkdir -p /etc/ssl/certs
RUN openssl req -x509 -nodes -days 1 -newkey rsa:2048 \
-keyout /etc/ssl/private/nginx-selfsigned.key \
-out /etc/ssl/certs/nginx-selfsigned.crt \
-subj "/C=MA/ST=Khouribga/L=Khouribga/O=il/CN=mahdi"

COPY ./conf/nginx.conf /etc/nginx/nginx.conf
ENTRYPOINT ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]




