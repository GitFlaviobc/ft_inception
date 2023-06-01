#!/bin/sh

if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then 
	echo "Database was found, skipping setup phase"
else
/etc/init.d/mysql start

echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE.* TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_USER_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

echo "CREATE USER '$MYSQL_USER'@'localhost' IDENTIFIED BY '$MYSQL_USER_PASSWORD'; GRANT ALL PRIVILEGES ON $MYSQL_DATABASE.* TO 'fbonini-'@'localhost'; FLUSH PRIVILEGES;"  | mysql -uroot

echo "GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

echo "ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

/etc/init.d/mysql stop
fi

exec "$@"