#!/bin/sh

cd wordpress/
wp core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PWD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
wp user create $WP_USER_LOGIN $WP_USER_EMAIL --user_pass=$WP_USER_PWD --allow-root

/usr/sbin/php-fpm7.4 -F