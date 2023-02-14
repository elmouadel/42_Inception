#!/bin/sh

adduser -S $FTP_USER && addgroup -S $FTP_USER
chown -R $FTP_USER:$FTP_USER /var/www/html

echo "$FTP_USER:$FTP_PWD" | chpasswd &> /dev/null
echo $FTP_USER >> /etc/vsftpd.userlist

echo "starting FTP server..."
vsftpd /etc/vsftpd/vsftpd.conf