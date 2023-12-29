#!/bin/sh

echo "test script"
cd wordpress/
wp core install --url=mravera.42.fr --title="WP_CLI" --admin_user=wpcli --admin_password=wpcli --allow-root
wp theme install inspiro --activate --allow-root
wp user create $WP_USERNAME $WP_USERMAIL --user_pass=$WP_USERPWD --allow-root

/usr/sbin/php-fpm7.4 -F