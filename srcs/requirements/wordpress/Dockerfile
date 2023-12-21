# syntax=docker/dockerfile:1

# https://docs.docker.com/engine/reference/builder/
# https://developer.wordpress.org/advanced-administration/before-install/howto-install/
FROM debian:bullseye

WORKDIR /app

# WordPress CLI doc
# https://make.wordpress.org/cli/handbook/how-to/how-to-install/
# installation of php, php-fpm (fastCGI Manager), php-mysql and ofc wordpress

RUN apt-get update -yq \
&& apt-get upgrade -yq \
&& apt-get install -yq wget \
&& apt-get install -y php7.4 php-fpm php-mysql mariadb-client \
&& wget -q https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&& chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

COPY wp-config.php /app/wordpress/wp-config.php

RUN wp core download --path=./wordpress --version=6.3 --allow-root
RUN cd wordpress/ && wp core install --url=mravera.42.fr --title="WP-CLI" --admin_user=wpcli --admin_password=wpcli --allow-root 

#&& wget -q https://wordpress.org/wordpress-6.3.tar.gz \
#&& tar -xzf wordpress-6.3.tar.gz && rm wordpress-6.3.tar.gz \
#&& chown -R root:root /app/wordpress \

# options for the tar command above
# -x to extract -z to use gzip -f to choose the archive file