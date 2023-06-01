#!/bin/sh

if [ -f ./wp-config.php ]
then

	echo "Wordpress settings found, skipping setup phase"

else
	wget http://wordpress.org/latest.tar.gz
	
	tar xfz latest.tar.gz
	
	mv wordpress/* .
	
	rm -rf latest.tar.gz wordpress/

	sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php

	sed -i "s/password_here/$MYSQL_USER_PASSWORD/g" wp-config-sample.php
	
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php

	sed -i "s/database_name_here/$MYSQL_DATABASE/g" wp-config-sample.php

	cp wp-config-sample.php wp-config.php
fi

exec "$@"